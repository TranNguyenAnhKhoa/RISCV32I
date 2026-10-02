//--------------------------------------------------------------------
// File: csr_registers.v
// Module: csr_registers
// Description: Storage and read/write decoding for Machine-mode CSRs
//              and trap metadata conforming to RISC-V Privileged v1.12.
//--------------------------------------------------------------------

`include "csr_defines.v"

module csr_registers #(
    parameter HART_ID = 32'h0000_0000
) (
    input             clk_i,
    input             rstn_i,
    // Read / Write Interface from Zicsr execution
    input      [11:0] csr_addr_i,
    output reg [31:0] csr_rdata_o,
    output reg        csr_valid_addr_o,
    output            csr_read_only_o,
    input             csr_write_en_i,
    input      [31:0] csr_wdata_i,
    // Trap Entry Interface
    input             trap_valid_i,
    input             trap_is_interrupt_i,
    input      [4:0]  trap_cause_i,
    input      [31:0] trap_pc_i,
    input      [31:0] trap_val_i,
    output     [31:0] trap_redirect_pc_o,
    // Trap Return (MRET) Interface
    input             mret_valid_i,
    output     [31:0] mret_redirect_pc_o,
    // Hardware Interrupt Inputs
    input             irq_software_i,
    input             irq_timer_i,
    input             irq_external_i,
    output            mstatus_mie_o,
    output     [31:0] mie_val_o,
    output     [31:0] mip_val_o,
    // Performance Counter Event
    input             inst_retire_i
);

    // CSR Read-Only check: addresses with bits [11:10] == 2'b11 are read-only
    assign csr_read_only_o = (csr_addr_i[11:10] == 2'b11);

    // Physical Machine-Mode CSR Registers
    reg        mstatus_mie_q;
    reg        mstatus_mpie_q;
    reg [1:0]  mstatus_mpp_q;

    reg [31:0] mie_q;
    reg [31:0] mtvec_q;
    reg [31:0] mscratch_q;
    reg [31:0] mepc_q;
    reg [31:0] mcause_q;
    reg [31:0] mtval_q;

    reg [63:0] mcycle_q;
    reg [63:0] minstret_q;

    // Composition wires
    wire [31:0] mstatus_w;
    wire [31:0] misa_w;
    wire [31:0] mip_w;

    // mstatus composition (32 bits total)
    assign mstatus_w = {
        19'b0,                                      // 31:13 reserved
        mstatus_mpp_q,                              // 12:11 MPP
        2'b00,                                      // 10:9  reserved
        1'b0,                                       // 8     SPP (User mode not supported, 0)
        mstatus_mpie_q,                             // 7     MPIE
        3'b000,                                     // 6:4   reserved
        mstatus_mie_q,                              // 3     MIE
        3'b000                                      // 2:0   reserved
    };

    // misa composition: RV32I base integer (MXL=1 for 32-bit, bit 8 for I)
    assign misa_w = 32'h4000_0100;

    // mip composition: connects external interrupt lines (32 bits total)
    assign mip_w = {
        20'b0,                                      // 31:12 reserved
        irq_external_i,                             // 11    MEIP
        3'b000,                                     // 10:8  reserved
        irq_timer_i,                                // 7     MTIP
        3'b000,                                     // 6:4   reserved
        irq_software_i,                             // 3     MSIP
        3'b000                                      // 2:0   reserved
    };

    assign mstatus_mie_o       = mstatus_mie_q;
    assign mie_val_o           = mie_q;
    assign mip_val_o           = mip_w;
    assign mret_redirect_pc_o  = mepc_q;

    // Trap Redirect Vector calculation
    wire [31:0] mtvec_base_w;
    wire        mtvec_is_vectored_w;

    assign mtvec_base_w        = {mtvec_q[31:2], 2'b00};
    assign mtvec_is_vectored_w = (mtvec_q[1:0] == `MTVEC_MODE_VECTORED);

    assign trap_redirect_pc_o  = (mtvec_is_vectored_w && trap_is_interrupt_i) ?
                                 (mtvec_base_w + {25'b0, trap_cause_i, 2'b00}) :
                                 mtvec_base_w;

    // Combinational Read Port
    always @(*) begin
        csr_rdata_o      = 32'h0000_0000;
        csr_valid_addr_o = 1'b1;

        case (csr_addr_i)
            // Machine Information Registers
            `CSR_ADDR_MVENDORID:  csr_rdata_o = 32'h0000_0000;
            `CSR_ADDR_MARCHID:    csr_rdata_o = 32'h0000_0000;
            `CSR_ADDR_MIMPID:     csr_rdata_o = 32'h0001_0000;
            `CSR_ADDR_MHARTID:    csr_rdata_o = HART_ID;

            // Machine Trap Setup
            `CSR_ADDR_MSTATUS:    csr_rdata_o = mstatus_w;
            `CSR_ADDR_MISA:       csr_rdata_o = misa_w;
            `CSR_ADDR_MIE:        csr_rdata_o = mie_q;
            `CSR_ADDR_MTVEC:      csr_rdata_o = mtvec_q;

            // Machine Trap Handling
            `CSR_ADDR_MSCRATCH:   csr_rdata_o = mscratch_q;
            `CSR_ADDR_MEPC:       csr_rdata_o = mepc_q;
            `CSR_ADDR_MCAUSE:     csr_rdata_o = mcause_q;
            `CSR_ADDR_MTVAL:      csr_rdata_o = mtval_q;
            `CSR_ADDR_MIP:        csr_rdata_o = mip_w;

            // Counters and Timers
            `CSR_ADDR_MCYCLE,
            `CSR_ADDR_CYCLE,
            `CSR_ADDR_TIME:       csr_rdata_o = mcycle_q[31:0];
            `CSR_ADDR_MCYCLEH,
            `CSR_ADDR_CYCLEH,
            `CSR_ADDR_TIMEH:      csr_rdata_o = mcycle_q[63:32];
            `CSR_ADDR_MINSTRET,
            `CSR_ADDR_INSTRET:    csr_rdata_o = minstret_q[31:0];
            `CSR_ADDR_MINSTRETH,
            `CSR_ADDR_INSTRETH:   csr_rdata_o = minstret_q[63:32];

            default: begin
                csr_rdata_o      = 32'h0000_0000;
                csr_valid_addr_o = 1'b0;
            end
        endcase
    end

    // Sequential Updates: Trap handling, MRET, CSR writes, and Counters
    always @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            mstatus_mie_q  <= 1'b0;
            mstatus_mpie_q <= 1'b0;
            mstatus_mpp_q  <= 2'b11;                // Boot into Machine mode
            mie_q          <= 32'h0000_0000;
            mtvec_q        <= 32'h0000_0000;
            mscratch_q     <= 32'h0000_0000;
            mepc_q         <= 32'h0000_0000;
            mcause_q       <= 32'h0000_0000;
            mtval_q        <= 32'h0000_0000;
            mcycle_q       <= 64'd0;
            minstret_q     <= 64'd0;
        end else begin
            // Performance Counters: mcycle increments continuously, minstret increments on retirement
            mcycle_q <= mcycle_q + 64'd1;
            if (inst_retire_i) begin
                minstret_q <= minstret_q + 64'd1;
            end

            // Priority 1: Hardware Trap Entry
            if (trap_valid_i) begin
                mstatus_mpie_q <= mstatus_mie_q;
                mstatus_mie_q  <= 1'b0;
                mstatus_mpp_q  <= 2'b11;
                mepc_q         <= {trap_pc_i[31:1], 1'b0};
                mcause_q       <= {trap_is_interrupt_i, 26'b0, trap_cause_i};
                mtval_q        <= trap_val_i;
            end
            // Priority 2: MRET (Return from Trap)
            else if (mret_valid_i) begin
                mstatus_mie_q  <= mstatus_mpie_q;
                mstatus_mpie_q <= 1'b1;
                mstatus_mpp_q  <= 2'b11;
            end
            // Priority 3: CSR Write from software instruction
            else if (csr_write_en_i && !csr_read_only_o) begin
                case (csr_addr_i)
                    `CSR_ADDR_MSTATUS: begin
                        mstatus_mie_q  <= csr_wdata_i[`MSTATUS_MIE_BIT];
                        mstatus_mpie_q <= csr_wdata_i[`MSTATUS_MPIE_BIT];
                        mstatus_mpp_q  <= 2'b11; // Only M-mode supported
                    end

                    `CSR_ADDR_MIE: begin
                        // Only software (bit 3), timer (bit 7), external (bit 11) interrupts are writable
                        mie_q[`MIE_MSIE_BIT] <= csr_wdata_i[`MIE_MSIE_BIT];
                        mie_q[`MIE_MTIE_BIT] <= csr_wdata_i[`MIE_MTIE_BIT];
                        mie_q[`MIE_MEIE_BIT] <= csr_wdata_i[`MIE_MEIE_BIT];
                    end

                    `CSR_ADDR_MTVEC: begin
                        // Mode is 2'b00 (direct) or 2'b01 (vectored)
                        if (csr_wdata_i[1:0] <= 2'b01) begin
                            mtvec_q <= {csr_wdata_i[31:2], csr_wdata_i[1:0]};
                        end else begin
                            mtvec_q <= {csr_wdata_i[31:2], 2'b00};
                        end
                    end

                    `CSR_ADDR_MSCRATCH: begin
                        mscratch_q <= csr_wdata_i;
                    end

                    `CSR_ADDR_MEPC: begin
                        mepc_q <= {csr_wdata_i[31:1], 1'b0};
                    end

                    `CSR_ADDR_MCAUSE: begin
                        mcause_q <= csr_wdata_i;
                    end

                    `CSR_ADDR_MTVAL: begin
                        mtval_q <= csr_wdata_i;
                    end

                    `CSR_ADDR_MCYCLE: begin
                        mcycle_q[31:0] <= csr_wdata_i;
                    end

                    `CSR_ADDR_MCYCLEH: begin
                        mcycle_q[63:32] <= csr_wdata_i;
                    end

                    `CSR_ADDR_MINSTRET: begin
                        minstret_q[31:0] <= csr_wdata_i;
                    end

                    `CSR_ADDR_MINSTRETH: begin
                        minstret_q[63:32] <= csr_wdata_i;
                    end

                    default: begin
                        // Read-only or unmapped registers discard write
                    end
                endcase
            end
        end
    end

endmodule
