//--------------------------------------------------------------------
// File: CSR_if.sv
// Module: CSR_if
// Description: SystemVerilog wrapper module for CSR Unit.
//--------------------------------------------------------------------

module CSR_if #(
    parameter HART_ID = 32'h0000_0000
) (
    input  logic        clk_i,
    input  logic        rstn_i,
    // Zicsr Pipeline Interface
    input  logic        csr_access_i,
    input  logic [2:0]  csr_op_i,
    input  logic [11:0] csr_addr_i,
    input  logic [31:0] csr_wdata_i,
    input  logic        csr_rs1_is_zero_i,
    output logic [31:0] csr_rdata_o,
    output logic        csr_illegal_o,
    // Trap Entry Interface
    input  logic        trap_valid_i,
    input  logic        trap_is_interrupt_i,
    input  logic [4:0]  trap_cause_i,
    input  logic [31:0] trap_pc_i,
    input  logic [31:0] trap_val_i,
    output logic [31:0] trap_redirect_pc_o,
    // Trap Return Interface
    input  logic        mret_valid_i,
    output logic [31:0] mret_redirect_pc_o,
    // Interrupt Lines
    input  logic        irq_software_i,
    input  logic        irq_timer_i,
    input  logic        irq_external_i,
    output logic        interrupt_req_o,
    output logic [4:0]  interrupt_cause_o,
    // Performance Event
    input  logic        inst_retire_i
);

    csr_unit #(
        .HART_ID (HART_ID)
    ) csr_unit_inst0 (
        .clk_i               (clk_i),
        .rstn_i              (rstn_i),
        .csr_access_i        (csr_access_i),
        .csr_op_i            (csr_op_i),
        .csr_addr_i          (csr_addr_i),
        .csr_wdata_i         (csr_wdata_i),
        .csr_rs1_is_zero_i   (csr_rs1_is_zero_i),
        .csr_rdata_o         (csr_rdata_o),
        .csr_illegal_o       (csr_illegal_o),
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
        .interrupt_req_o     (interrupt_req_o),
        .interrupt_cause_o   (interrupt_cause_o),
        .inst_retire_i       (inst_retire_i)
    );

endmodule
