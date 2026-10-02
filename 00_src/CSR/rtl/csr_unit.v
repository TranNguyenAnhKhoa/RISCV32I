//--------------------------------------------------------------------
// File: csr_unit.v
// Module: csr_unit
// Description: Top-Level CSR Unit integrating Zicsr instruction
//              execution, Machine-mode CSRs, trap vector calculation,
//              and interrupt prioritization for RISCV32I.
//--------------------------------------------------------------------

`include "csr_defines.v"

module csr_unit #(
    parameter HART_ID = 32'h0000_0000
) (
    input             clk_i,
    input             rstn_i,
    // Zicsr Pipeline Interface (from ID/EX stage)
    input             csr_access_i,
    input      [2:0]  csr_op_i,
    input      [11:0] csr_addr_i,
    input      [31:0] csr_wdata_i,
    input             csr_rs1_is_zero_i,
    output     [31:0] csr_rdata_o,
    output            csr_illegal_o,
    // Trap Entry Interface (from Exception/Hazard unit)
    input             trap_valid_i,
    input             trap_is_interrupt_i,
    input      [4:0]  trap_cause_i,
    input      [31:0] trap_pc_i,
    input      [31:0] trap_val_i,
    output     [31:0] trap_redirect_pc_o,
    // Trap Return (MRET) Interface
    input             mret_valid_i,
    output     [31:0] mret_redirect_pc_o,
    // Hardware Interrupt Lines (from Platform / Timer / Peripheral)
    input             irq_software_i,
    input             irq_timer_i,
    input             irq_external_i,
    output            interrupt_req_o,
    output reg [4:0]  interrupt_cause_o,
    // Performance Counter Increment
    input             inst_retire_i
);

    // Internal wires connecting to csr_registers
    wire [31:0] current_csr_rdata_w;
    wire        csr_valid_addr_w;
    wire        csr_read_only_w;
    reg         csr_write_en_r;
    reg  [31:0] next_csr_wdata_r;

    wire        mstatus_mie_w;
    wire [31:0] mie_val_w;
    wire [31:0] mip_val_w;

    assign csr_rdata_o = current_csr_rdata_w;

    //----------------------------------------------------------------
    // Zicsr Atomic Operation Decoding
    //----------------------------------------------------------------
    always @(*) begin
        csr_write_en_r   = 1'b0;
        next_csr_wdata_r = current_csr_rdata_w;

        if (csr_access_i) begin
            case (csr_op_i)
                `CSR_OP_CSRRW,
                `CSR_OP_CSRRWI: begin
                    // Write unconditionally
                    csr_write_en_r   = 1'b1;
                    next_csr_wdata_r = csr_wdata_i;
                end

                `CSR_OP_CSRRS,
                `CSR_OP_CSRRSI: begin
                    // Bit set: writes only if rs1/uimm is non-zero
                    if (!csr_rs1_is_zero_i) begin
                        csr_write_en_r   = 1'b1;
                        next_csr_wdata_r = current_csr_rdata_w | csr_wdata_i;
                    end
                end

                `CSR_OP_CSRRC,
                `CSR_OP_CSRRCI: begin
                    // Bit clear: writes only if rs1/uimm is non-zero
                    if (!csr_rs1_is_zero_i) begin
                        csr_write_en_r   = 1'b1;
                        next_csr_wdata_r = current_csr_rdata_w & (~csr_wdata_i);
                    end
                end

                default: begin
                    csr_write_en_r   = 1'b0;
                    next_csr_wdata_r = current_csr_rdata_w;
                end
            endcase
        end
    end

    // Illegal CSR access: unmapped address OR attempt to write a Read-Only CSR
    assign csr_illegal_o = csr_access_i &&
                          (!csr_valid_addr_w || (csr_write_en_r && csr_read_only_w));

    //----------------------------------------------------------------
    // Interrupt Prioritization Logic (External > Software > Timer)
    //----------------------------------------------------------------
    wire [31:0] pending_irqs_w;
    assign pending_irqs_w = mip_val_w & mie_val_w;

    assign interrupt_req_o = mstatus_mie_w && (pending_irqs_w != 32'h0);

    always @(*) begin
        if (pending_irqs_w[`MIE_MEIE_BIT]) begin
            interrupt_cause_o = `IRQ_EXTERNAL_M;    // Cause 11
        end else if (pending_irqs_w[`MIE_MSIE_BIT]) begin
            interrupt_cause_o = `IRQ_SOFTWARE_M;    // Cause 3
        end else if (pending_irqs_w[`MIE_MTIE_BIT]) begin
            interrupt_cause_o = `IRQ_TIMER_M;       // Cause 7
        end else begin
            interrupt_cause_o = 5'd0;
        end
    end

    //----------------------------------------------------------------
    // Instantiation: CSR Registers Core Block
    //----------------------------------------------------------------
    csr_registers #(
        .HART_ID (HART_ID)
    ) csr_registers_inst (
        .clk_i               (clk_i),
        .rstn_i              (rstn_i),
        .csr_addr_i          (csr_addr_i),
        .csr_rdata_o         (current_csr_rdata_w),
        .csr_valid_addr_o    (csr_valid_addr_w),
        .csr_read_only_o     (csr_read_only_w),
        .csr_write_en_i      (csr_write_en_r && !csr_illegal_o),
        .csr_wdata_i         (next_csr_wdata_r),
        .trap_valid_i        (trap_valid_i),
        .trap_is_interrupt_i (trap_is_interrupt_i),
        .trap_cause_i        (trap_cause_i),
        .trap_pc_i           (trap_pc_i),
        .trap_val_i          (trap_val_i),
        .trap_redirect_pc_o  (trap_redirect_pc_o),
        .mret_valid_i        (mret_valid_i),
        .mret_redirect_pc_o  (mret_redirect_pc_o),
        .irq_software_i      (irq_software_i),
        .irq_timer_i         (irq_timer_i),
        .irq_external_i      (irq_external_i),
        .mstatus_mie_o       (mstatus_mie_w),
        .mie_val_o           (mie_val_w),
        .mip_val_o           (mip_val_w),
        .inst_retire_i       (inst_retire_i)
    );

endmodule
