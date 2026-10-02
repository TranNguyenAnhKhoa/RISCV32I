//--------------------------------------------------------------------
// File: csr_tb.v
// Module: csr_tb
// Description: Self-checking testbench for RISC-V CSR Unit
//              (Zicsr, Machine-mode CSRs, Trap handling, Interrupts).
//--------------------------------------------------------------------

`timescale 1ns/1ps
`include "csr_defines.v"

module csr_tb;

    reg         clk_r;
    reg         rstn_r;

    // Zicsr Pipeline Interface
    reg         csr_access_r;
    reg  [2:0]  csr_op_r;
    reg  [11:0] csr_addr_r;
    reg  [31:0] csr_wdata_r;
    reg         csr_rs1_is_zero_r;
    wire [31:0] csr_rdata_w;
    wire        csr_illegal_w;

    // Trap Entry Interface
    reg         trap_valid_r;
    reg         trap_is_interrupt_r;
    reg  [4:0]  trap_cause_r;
    reg  [31:0] trap_pc_r;
    reg  [31:0] trap_val_r;
    wire [31:0] trap_redirect_pc_w;

    // Trap Return Interface
    reg         mret_valid_r;
    wire [31:0] mret_redirect_pc_w;

    // Interrupt Lines
    reg         irq_software_r;
    reg         irq_timer_r;
    reg         irq_external_r;
    wire        interrupt_req_w;
    wire [4:0]  interrupt_cause_w;

    // Performance Event
    reg         inst_retire_r;

    // Tracking counters
    integer checks_passed = 0;
    integer checks_failed = 0;

    // Clock generator: 50 MHz
    always #10 clk_r = ~clk_r;

    // DUT Instantiation
    csr_unit #(
        .HART_ID (32'h0000_0000)
    ) dut (
        .clk_i               (clk_r),
        .rstn_i              (rstn_r),
        .csr_access_i        (csr_access_r),
        .csr_op_i            (csr_op_r),
        .csr_addr_i          (csr_addr_r),
        .csr_wdata_i         (csr_wdata_r),
        .csr_rs1_is_zero_i   (csr_rs1_is_zero_r),
        .csr_rdata_o         (csr_rdata_w),
        .csr_illegal_o       (csr_illegal_w),
        .trap_valid_i        (trap_valid_r),
        .trap_is_interrupt_i (trap_is_interrupt_r),
        .trap_cause_i        (trap_cause_r),
        .trap_pc_i           (trap_pc_r),
        .trap_val_i          (trap_val_r),
        .trap_redirect_pc_o  (trap_redirect_pc_w),
        .mret_valid_i        (mret_valid_r),
        .mret_redirect_pc_o  (mret_redirect_pc_w),
        .irq_software_i      (irq_software_r),
        .irq_timer_i         (irq_timer_r),
        .irq_external_i      (irq_external_r),
        .interrupt_req_o     (interrupt_req_w),
        .interrupt_cause_o   (interrupt_cause_w),
        .inst_retire_i       (inst_retire_r)
    );

    // Task: Execute CSR instruction and verify read data
    task csr_exec_check;
        input [2:0]   op;
        input [11:0]  addr;
        input [31:0]  wdata;
        input         rs1_zero;
        input [31:0]  expected_rdata;
        input         expected_illegal;
        input [511:0] test_name;
        begin
            @(negedge clk_r);
            csr_access_r      = 1'b1;
            csr_op_r          = op;
            csr_addr_r        = addr;
            csr_wdata_r       = wdata;
            csr_rs1_is_zero_r = rs1_zero;

            #1; // Sample combinational outputs
            if (csr_illegal_w == expected_illegal) begin
                if (!expected_illegal) begin
                    if (csr_rdata_w == expected_rdata) begin
                        $display("[PASS] %0s | Addr: 0x%03h RData: 0x%08h (Expected: 0x%08h)", test_name, addr, csr_rdata_w, expected_rdata);
                        checks_passed = checks_passed + 1;
                    end else begin
                        $display("[FAIL] %0s | Addr: 0x%03h RData: 0x%08h (Expected: 0x%08h)", test_name, addr, csr_rdata_w, expected_rdata);
                        checks_failed = checks_failed + 1;
                    end
                end else begin
                    $display("[PASS] %0s | Correctly detected Illegal CSR instruction", test_name);
                    checks_passed = checks_passed + 1;
                end
            end else begin
                $display("[FAIL] %0s | Illegal flag mismatch: Got %0d (Expected %0d)", test_name, csr_illegal_w, expected_illegal);
                checks_failed = checks_failed + 1;
            end

            @(posedge clk_r);
            #1;
            csr_access_r = 1'b0;
        end
    endtask

    // Initial Test Procedure
    initial begin
        clk_r               = 1'b0;
        rstn_r              = 1'b0;
        csr_access_r        = 1'b0;
        csr_op_r            = `CSR_OP_NONE;
        csr_addr_r          = 12'h000;
        csr_wdata_r         = 32'h0;
        csr_rs1_is_zero_r   = 1'b0;
        trap_valid_r        = 1'b0;
        trap_is_interrupt_r = 1'b0;
        trap_cause_r        = 5'd0;
        trap_pc_r           = 32'h0;
        trap_val_r          = 32'h0;
        mret_valid_r        = 1'b0;
        irq_software_r      = 1'b0;
        irq_timer_r         = 1'b0;
        irq_external_r      = 1'b0;
        inst_retire_r       = 1'b0;

        $display("=================================================================");
        $display("  STARTING RISC-V CSR UNIT TESTBENCH");
        $display("=================================================================");

        // Apply Reset
        #40;
        rstn_r = 1'b1;
        #20;

        // Test 1: Check Reset Values of Read-Only Info Registers
        csr_exec_check(`CSR_OP_CSRRS, `CSR_ADDR_MISA, 32'h0, 1'b1, 32'h4000_0100, 1'b0, "Check misa = RV32I (0x40000100)");
        csr_exec_check(`CSR_OP_CSRRS, `CSR_ADDR_MVENDORID, 32'h0, 1'b1, 32'h0000_0000, 1'b0, "Check mvendorid = 0");
        csr_exec_check(`CSR_OP_CSRRS, `CSR_ADDR_MARCHID, 32'h0, 1'b1, 32'h0000_0000, 1'b0, "Check marchid = 0");
        csr_exec_check(`CSR_OP_CSRRS, `CSR_ADDR_MIMPID, 32'h0, 1'b1, 32'h0001_0000, 1'b0, "Check mimpid = 0x00010000");
        csr_exec_check(`CSR_OP_CSRRS, `CSR_ADDR_MHARTID, 32'h0, 1'b1, 32'h0000_0000, 1'b0, "Check mhartid = 0");

        // Test 2: Check Reset Value of mstatus (MPP=2'b11 -> bits 12:11 = 0x1800)
        csr_exec_check(`CSR_OP_CSRRS, `CSR_ADDR_MSTATUS, 32'h0, 1'b1, 32'h0000_1800, 1'b0, "Check mstatus reset value (MPP=3)");

        // Test 3: CSRRW - Write and Read mscratch
        // First write 0xA5A5_5A5A (old value should be 0)
        csr_exec_check(`CSR_OP_CSRRW, `CSR_ADDR_MSCRATCH, 32'hA5A5_5A5A, 1'b0, 32'h0000_0000, 1'b0, "CSRRW write mscratch = 0xA5A55A5A");
        // Second write 0x1234_5678 (old value should be 0xA5A5_5A5A)
        csr_exec_check(`CSR_OP_CSRRW, `CSR_ADDR_MSCRATCH, 32'h1234_5678, 1'b0, 32'hA5A5_5A5A, 1'b0, "CSRRW update mscratch = 0x12345678");

        // Test 4: CSRRS - Atomic Read and Set Bits
        // Set bit 3 (MSIE) in mie
        csr_exec_check(`CSR_OP_CSRRS, `CSR_ADDR_MIE, 32'h0000_0008, 1'b0, 32'h0000_0000, 1'b0, "CSRRS set mie.MSIE (bit 3)");
        // Set bit 7 (MTIE) in mie (old value 0x08, new value 0x88)
        csr_exec_check(`CSR_OP_CSRRS, `CSR_ADDR_MIE, 32'h0000_0080, 1'b0, 32'h0000_0008, 1'b0, "CSRRS set mie.MTIE (bit 7)");
        // Set bit 11 (MEIE) in mie (old value 0x88, new value 0x888)
        csr_exec_check(`CSR_OP_CSRRS, `CSR_ADDR_MIE, 32'h0000_0800, 1'b0, 32'h0000_0088, 1'b0, "CSRRS set mie.MEIE (bit 11)");

        // Test 5: CSRRC - Atomic Read and Clear Bits
        // Clear bit 3 (MSIE) in mie (old value 0x888, new value 0x880)
        csr_exec_check(`CSR_OP_CSRRC, `CSR_ADDR_MIE, 32'h0000_0008, 1'b0, 32'h0000_0888, 1'b0, "CSRRC clear mie.MSIE");
        // Verify mie is now 0x880
        csr_exec_check(`CSR_OP_CSRRS, `CSR_ADDR_MIE, 32'h0, 1'b1, 32'h0000_0880, 1'b0, "CSRRS read-only mie = 0x880");

        // Test 6: CSRRWI / CSRRSI / CSRRCI Immediate instructions
        csr_exec_check(`CSR_OP_CSRRWI, `CSR_ADDR_MSCRATCH, 32'd25, 1'b0, 32'h1234_5678, 1'b0, "CSRRWI write mscratch = 25");
        csr_exec_check(`CSR_OP_CSRRS, `CSR_ADDR_MSCRATCH, 32'h0, 1'b1, 32'd25, 1'b0, "Verify mscratch = 25");

        // Test 7: Illegal CSR Detection
        // Attempt to write to Read-Only CSR (mvendorid is read-only, [11:10]=11)
        csr_exec_check(`CSR_OP_CSRRW, `CSR_ADDR_MVENDORID, 32'h1234_5678, 1'b0, 32'h0, 1'b1, "Detect illegal write to read-only mvendorid");
        // Attempt to access unmapped CSR address (0x123)
        csr_exec_check(`CSR_OP_CSRRW, 12'h123, 32'h1234_5678, 1'b0, 32'h0, 1'b1, "Detect illegal unmapped CSR address 0x123");

        // Test 8: Configure mtvec
        // Direct mode: base = 0x0000_8000, mode = 00
        csr_exec_check(`CSR_OP_CSRRW, `CSR_ADDR_MTVEC, 32'h0000_8000, 1'b0, 32'h0, 1'b0, "Write mtvec = 0x00008000 (Direct)");

        // Test 9: Hardware Trap Entry (Synchronous Exception: Illegal Instruction = 2)
        @(posedge clk_r);
        trap_valid_r        = 1'b1;
        trap_is_interrupt_r = 1'b0;
        trap_cause_r        = `EXC_ILLEGAL_INSTRUCTION;
        trap_pc_r           = 32'h0000_0240;
        trap_val_r          = 32'h0000_0000;
        #1;

        if (trap_redirect_pc_w == 32'h0000_8000) begin
            $display("[PASS] Exception redirect PC = 0x00008000");
            checks_passed = checks_passed + 1;
        end else begin
            $display("[FAIL] Exception redirect PC = 0x%08h (Expected: 0x00008000)", trap_redirect_pc_w);
            checks_failed = checks_failed + 1;
        end

        @(posedge clk_r);
        trap_valid_r = 1'b0;
        #1;

        // Verify mepc = 0x240 and mcause = 2
        csr_exec_check(`CSR_OP_CSRRS, `CSR_ADDR_MEPC, 32'h0, 1'b1, 32'h0000_0240, 1'b0, "Verify mepc captured 0x00000240");
        csr_exec_check(`CSR_OP_CSRRS, `CSR_ADDR_MCAUSE, 32'h0, 1'b1, 32'h0000_0002, 1'b0, "Verify mcause captured Exception 2");

        // Test 10: Trap Return (MRET)
        @(posedge clk_r);
        mret_valid_r = 1'b1;
        #1;
        if (mret_redirect_pc_w == 32'h0000_0240) begin
            $display("[PASS] MRET redirect PC = 0x00000240");
            checks_passed = checks_passed + 1;
        end else begin
            $display("[FAIL] MRET redirect PC = 0x%08h (Expected: 0x00000240)", mret_redirect_pc_w);
            checks_failed = checks_failed + 1;
        end
        @(posedge clk_r);
        mret_valid_r = 1'b0;

        // Test 11: Interrupt Prioritization and Vectored Mode
        // Set mtvec to Vectored mode: base = 0x0000_4000, mode = 01 -> 0x0000_4001
        csr_exec_check(`CSR_OP_CSRRW, `CSR_ADDR_MTVEC, 32'h0000_4001, 1'b0, 32'h0000_8000, 1'b0, "Write mtvec = 0x00004001 (Vectored)");

        // Enable global interrupts: mstatus.MIE = 1 (bit 3)
        csr_exec_check(`CSR_OP_CSRRS, `CSR_ADDR_MSTATUS, 32'h0000_0008, 1'b0, 32'h0000_1880, 1'b0, "Enable mstatus.MIE");
        // Enable timer and external interrupts in mie: mie = 0x880 (already set)

        // Assert both timer and external interrupt lines simultaneously
        @(posedge clk_r);
        irq_timer_r    = 1'b1;
        irq_external_r = 1'b1;
        #1;

        // External interrupt (11) must have higher priority than Timer (7)
        if (interrupt_req_w == 1'b1 && interrupt_cause_w == `IRQ_EXTERNAL_M) begin
            $display("[PASS] Interrupt request generated with highest priority cause = 11 (External)");
            checks_passed = checks_passed + 1;
        end else begin
            $display("[FAIL] Interrupt mismatch: Req=%0d Cause=%0d (Expected: Req=1, Cause=11)", interrupt_req_w, interrupt_cause_w);
            checks_failed = checks_failed + 1;
        end

        // Simulate taking the external interrupt trap
        trap_valid_r        = 1'b1;
        trap_is_interrupt_r = 1'b1;
        trap_cause_r        = `IRQ_EXTERNAL_M;
        trap_pc_r           = 32'h0000_0500;
        #1;

        // In vectored mode, redirect PC = base + (cause * 4) = 0x4000 + (11 * 4) = 0x402C
        if (trap_redirect_pc_w == 32'h0000_402C) begin
            $display("[PASS] Vectored interrupt redirect PC = 0x0000402C (0x4000 + 11*4)");
            checks_passed = checks_passed + 1;
        end else begin
            $display("[FAIL] Vectored redirect PC = 0x%08h (Expected: 0x0000402C)", trap_redirect_pc_w);
            checks_failed = checks_failed + 1;
        end

        @(posedge clk_r);
        trap_valid_r   = 1'b0;
        irq_timer_r    = 1'b0;
        irq_external_r = 1'b0;

        // Test 12: Performance Counters (mcycle and minstret)
        #40;
        // Pulse inst_retire_r 3 times
        @(posedge clk_r); inst_retire_r = 1'b1;
        @(posedge clk_r); inst_retire_r = 1'b1;
        @(posedge clk_r); inst_retire_r = 1'b1;
        @(posedge clk_r); inst_retire_r = 1'b0;
        #10;

        csr_exec_check(`CSR_OP_CSRRS, `CSR_ADDR_MINSTRET, 32'h0, 1'b1, 32'd3, 1'b0, "Verify minstret incremented by 3");

        // Final Summary
        #60;
        $display("=================================================================");
        $display("  CSR TEST SUMMARY");
        $display("  Total Checks Passed: %0d", checks_passed);
        $display("  Total Checks Failed: %0d", checks_failed);
        if (checks_failed == 0) begin
            $display("  STATUS: \033[32mALL TESTS PASSED\033[0m");
        end else begin
            $display("  STATUS: \033[31mSOME TESTS FAILED\033[0m");
        end
        $display("=================================================================");

        $finish;
    end

endmodule
