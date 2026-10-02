//--------------------------------------------------------------------
// File: debug_module_tb.v
// Module: debug_module_tb
// Description: Self-checking testbench for RISC-V Debug Module (DM)
//              conforming to RISC-V Debug Specification 0.13.2.
//--------------------------------------------------------------------

`timescale 1ns/1ps
`include "dm_defines.v"

module debug_module_tb;

    reg         clk_r;
    reg         rstn_r;

    // DMI signals
    reg         dmi_req_valid_r;
    wire        dmi_req_ready_w;
    reg  [6:0]  dmi_req_address_r;
    reg  [31:0] dmi_req_data_r;
    reg  [1:0]  dmi_req_op_r;
    wire        dmi_resp_valid_w;
    reg         dmi_resp_ready_r;
    wire [31:0] dmi_resp_data_w;
    wire [1:0]  dmi_resp_op_w;

    // Core debug control signals
    wire        core_debug_req_w;
    wire        core_debug_resume_req_w;
    wire        core_debug_resethalt_req_w;
    reg         core_debug_halted_r;
    reg         core_debug_resume_ack_r;
    reg  [2:0]  core_debug_cause_r;
    wire        ndmreset_w;
    wire        dmactive_w;

    // Core register access signals
    wire        core_reg_req_w;
    wire        core_reg_write_w;
    wire [15:0] core_reg_addr_w;
    wire [31:0] core_reg_wdata_w;
    reg  [31:0] core_reg_rdata_r;
    reg         core_reg_ready_r;

    // Simulated Core GPR & PC storage
    reg  [31:0] simulated_gprs [0:31];
    reg  [31:0] simulated_dpc;
    reg  [31:0] simulated_dcsr;

    // Test tracking counters
    integer checks_passed = 0;
    integer checks_failed = 0;

    // Clock generator: 50 MHz (20ns period)
    always #10 clk_r = ~clk_r;

    // DUT Instantiation
    debug_module dut (
        .clk_i                      (clk_r),
        .rstn_i                     (rstn_r),
        .dmi_req_valid_i            (dmi_req_valid_r),
        .dmi_req_ready_o            (dmi_req_ready_w),
        .dmi_req_address_i          (dmi_req_address_r),
        .dmi_req_data_i             (dmi_req_data_r),
        .dmi_req_op_i               (dmi_req_op_r),
        .dmi_resp_valid_o           (dmi_resp_valid_w),
        .dmi_resp_ready_i           (dmi_resp_ready_r),
        .dmi_resp_data_o            (dmi_resp_data_w),
        .dmi_resp_op_o              (dmi_resp_op_w),
        .core_debug_req_o           (core_debug_req_w),
        .core_debug_resume_req_o    (core_debug_resume_req_w),
        .core_debug_resethalt_req_o (core_debug_resethalt_req_w),
        .core_debug_halted_i        (core_debug_halted_r),
        .core_debug_resume_ack_i    (core_debug_resume_ack_r),
        .core_debug_cause_i         (core_debug_cause_r),
        .ndmreset_o                 (ndmreset_w),
        .dmactive_o                 (dmactive_w),
        .core_reg_req_o             (core_reg_req_w),
        .core_reg_write_o           (core_reg_write_w),
        .core_reg_addr_o            (core_reg_addr_w),
        .core_reg_wdata_o           (core_reg_wdata_w),
        .core_reg_rdata_i           (core_reg_rdata_r),
        .core_reg_ready_i           (core_reg_ready_r)
    );

    // Simulated Core Response Process
    always @(posedge clk_r or negedge rstn_r) begin
        if (!rstn_r) begin
            core_reg_ready_r        <= 1'b0;
            core_reg_rdata_r        <= 32'h0000_0000;
            core_debug_resume_ack_r <= 1'b0;
        end else begin
            core_reg_ready_r        <= 1'b0;
            core_debug_resume_ack_r <= 1'b0;

            // Handle register read/write while halted
            if (core_reg_req_w) begin
                core_reg_ready_r <= 1'b1;
                if (core_reg_addr_w >= `REGNO_GPR_BASE && core_reg_addr_w <= `REGNO_GPR_END) begin
                    if (core_reg_write_w) begin
                        if (core_reg_addr_w[4:0] != 5'd0) begin
                            simulated_gprs[core_reg_addr_w[4:0]] <= core_reg_wdata_w;
                        end
                    end else begin
                        core_reg_rdata_r <= (core_reg_addr_w[4:0] == 5'd0) ?
                                            32'h0000_0000 : simulated_gprs[core_reg_addr_w[4:0]];
                    end
                end else if (core_reg_addr_w == `REGNO_CSR_DPC) begin
                    if (core_reg_write_w) begin
                        simulated_dpc <= core_reg_wdata_w;
                    end else begin
                        core_reg_rdata_r <= simulated_dpc;
                    end
                end else if (core_reg_addr_w == `REGNO_CSR_DCSR) begin
                    if (core_reg_write_w) begin
                        simulated_dcsr <= core_reg_wdata_w;
                    end else begin
                        core_reg_rdata_r <= simulated_dcsr;
                    end
                end
            end

            // Handle resume request
            if (core_debug_resume_req_w) begin
                core_debug_halted_r     <= 1'b0;
                core_debug_resume_ack_r <= 1'b1;
            end
        end
    end

    // Task: DMI Write
    task dmi_write;
        input [6:0]  addr;
        input [31:0] data;
        begin
            @(posedge clk_r);
            while (!dmi_req_ready_w) @(posedge clk_r);
            dmi_req_valid_r   = 1'b1;
            dmi_req_address_r = addr;
            dmi_req_data_r    = data;
            dmi_req_op_r      = `DMI_OP_WRITE;
            dmi_resp_ready_r  = 1'b1;

            @(posedge clk_r);
            dmi_req_valid_r   = 1'b0;

            while (!dmi_resp_valid_w) @(posedge clk_r);
            if (dmi_resp_op_w != `DMI_RESP_SUCCESS) begin
                $display("[ERROR] DMI Write to 0x%02h returned error status: %d", addr, dmi_resp_op_w);
                checks_failed = checks_failed + 1;
            end
            @(posedge clk_r);
        end
    endtask

    // Task: DMI Read and Compare
    task dmi_read_check;
        input [6:0]   addr;
        input [31:0]  expected_data;
        input [31:0]  mask;
        input [511:0] test_name;
        reg   [31:0]  read_val;
        begin
            @(posedge clk_r);
            while (!dmi_req_ready_w) @(posedge clk_r);
            dmi_req_valid_r   = 1'b1;
            dmi_req_address_r = addr;
            dmi_req_data_r    = 32'h0000_0000;
            dmi_req_op_r      = `DMI_OP_READ;
            dmi_resp_ready_r  = 1'b1;

            @(posedge clk_r);
            dmi_req_valid_r   = 1'b0;

            while (!dmi_resp_valid_w) @(posedge clk_r);
            read_val = dmi_resp_data_w;

            if ((read_val & mask) == (expected_data & mask)) begin
                $display("[PASS] %0s | Addr: 0x%02h Read: 0x%08h (Expected: 0x%08h)", test_name, addr, read_val, expected_data);
                checks_passed = checks_passed + 1;
            end else begin
                $display("[FAIL] %0s | Addr: 0x%02h Read: 0x%08h (Expected: 0x%08h, Mask: 0x%08h)", test_name, addr, read_val, expected_data, mask);
                checks_failed = checks_failed + 1;
            end
            @(posedge clk_r);
        end
    endtask

    // Initial Test Sequence
    integer i;
    initial begin
        clk_r               = 1'b0;
        rstn_r              = 1'b0;
        dmi_req_valid_r     = 1'b0;
        dmi_req_address_r   = 7'h00;
        dmi_req_data_r      = 32'h0;
        dmi_req_op_r        = `DMI_OP_NOP;
        dmi_resp_ready_r    = 1'b1;
        core_debug_halted_r = 1'b0;
        core_debug_cause_r  = 3'd0;
        simulated_dpc       = 32'h0000_0000;
        simulated_dcsr      = 32'h0000_0000;

        for (i = 0; i < 32; i = i + 1) begin
            simulated_gprs[i] = 32'h0000_0000;
        end

        $display("=================================================================");
        $display("  STARTING RISC-V DEBUG MODULE (DM) TESTBENCH");
        $display("=================================================================");

        // Step 1: Apply Hardware Reset
        #40;
        rstn_r = 1'b1;
        #20;

        // Check DM is inactive initially
        dmi_read_check(`DM_ADDR_DMCONTROL, 32'h0000_0000, 32'h0000_0001, "Check DM Inactive after reset");

        // Step 2: Activate Debug Module (dmcontrol.dmactive = 1)
        dmi_write(`DM_ADDR_DMCONTROL, 32'h0000_0001);
        dmi_read_check(`DM_ADDR_DMCONTROL, 32'h0000_0001, 32'h0000_0001, "Check dmcontrol dmactive = 1");

        // Step 3: Check dmstatus (Version 0.13, Authenticated, Running)
        dmi_read_check(`DM_ADDR_DMSTATUS, 32'h0000_0CA2, 32'h0000_0CFE, "Check dmstatus initial running");

        // Step 4: Request Hart Halt (dmcontrol.haltreq = 1)
        dmi_write(`DM_ADDR_DMCONTROL, 32'h8000_0001);
        @(posedge clk_r);

        // Verify core received debug halt request
        if (core_debug_req_w == 1'b1) begin
            $display("[PASS] core_debug_req_o asserted on haltreq");
            checks_passed = checks_passed + 1;
        end else begin
            $display("[FAIL] core_debug_req_o NOT asserted on haltreq");
            checks_failed = checks_failed + 1;
        end

        // Core responds by halting
        @(posedge clk_r);
        core_debug_halted_r = 1'b1;
        core_debug_cause_r  = `DCSR_CAUSE_HALTREQ;
        @(posedge clk_r);

        // Check dmstatus indicates halted
        dmi_read_check(`DM_ADDR_DMSTATUS, 32'h0000_03A2, 32'h0000_0300, "Check dmstatus allhalted = 1");

        // Check haltsum0
        dmi_read_check(`DM_ADDR_HALTSUM0, 32'h0000_0001, 32'h0000_0001, "Check haltsum0 bit 0 = 1");

        // Step 5: Abstract Command - Write GPR x5 with 0xDEADBEEF
        dmi_write(`DM_ADDR_DATA0, 32'hDEAD_BEEF);
        // command: cmdtype=0, aarsize=2 (32-bit), transfer=1, write=1, regno=0x1005 (x5)
        dmi_write(`DM_ADDR_COMMAND, {8'h00, 1'b0, 3'd2, 1'b0, 1'b0, 1'b1, 1'b1, 16'h1005});

        #40;
        if (simulated_gprs[5] == 32'hDEAD_BEEF) begin
            $display("[PASS] GPR x5 written with 0xDEADBEEF via Abstract Command");
            checks_passed = checks_passed + 1;
        end else begin
            $display("[FAIL] GPR x5 has 0x%08h (Expected: 0xDEADBEEF)", simulated_gprs[5]);
            checks_failed = checks_failed + 1;
        end

        // Step 6: Abstract Command - Read GPR x5 back into data0
        dmi_write(`DM_ADDR_DATA0, 32'h0000_0000);
        // command: cmdtype=0, aarsize=2, transfer=1, write=0 (read), regno=0x1005 (x5)
        dmi_write(`DM_ADDR_COMMAND, {8'h00, 1'b0, 3'd2, 1'b0, 1'b0, 1'b1, 1'b0, 16'h1005});

        #40;
        dmi_read_check(`DM_ADDR_DATA0, 32'hDEAD_BEEF, 32'hFFFF_FFFF, "Read GPR x5 back from data0");

        // Step 7: Abstract Command - Write and Read DPC (Debug PC)
        dmi_write(`DM_ADDR_DATA0, 32'h0000_1000);
        // Write DPC (regno = 0x07B1)
        dmi_write(`DM_ADDR_COMMAND, {8'h00, 1'b0, 3'd2, 1'b0, 1'b0, 1'b1, 1'b1, 16'h07B1});
        #40;
        if (simulated_dpc == 32'h0000_1000) begin
            $display("[PASS] DPC written with 0x00001000");
            checks_passed = checks_passed + 1;
        end else begin
            $display("[FAIL] DPC has 0x%08h (Expected: 0x00001000)", simulated_dpc);
            checks_failed = checks_failed + 1;
        end

        // Read DPC back
        dmi_write(`DM_ADDR_DATA0, 32'h0000_0000);
        dmi_write(`DM_ADDR_COMMAND, {8'h00, 1'b0, 3'd2, 1'b0, 1'b0, 1'b1, 1'b0, 16'h07B1});
        #40;
        dmi_read_check(`DM_ADDR_DATA0, 32'h0000_1000, 32'hFFFF_FFFF, "Read DPC back from data0");

        // Step 8: Resume Hart (dmcontrol.resumereq = 1)
        dmi_write(`DM_ADDR_DMCONTROL, 32'h4000_0001);
        #40;
        dmi_read_check(`DM_ADDR_DMSTATUS, 32'h0000_0CA2, 32'h0000_0C00, "Check dmstatus allrunning = 1 after resume");

        // Step 9: Error Handling - Abstract command while hart is RUNNING
        dmi_write(`DM_ADDR_COMMAND, {8'h00, 1'b0, 3'd2, 1'b0, 1'b0, 1'b1, 1'b0, 16'h1005});
        #40;
        dmi_read_check(`DM_ADDR_ABSTRACTCS, 32'h0000_0400, 32'h0000_0700, "Check cmderr = 4 (halt/resume error)");

        // Clear cmderr by writing 1s to bits 10:8
        dmi_write(`DM_ADDR_ABSTRACTCS, 32'h0000_0700);
        #20;
        dmi_read_check(`DM_ADDR_ABSTRACTCS, 32'h0000_0000, 32'h0000_0700, "Check cmderr cleared to 0");

        // Step 10: Check NDMReset (System Reset)
        dmi_write(`DM_ADDR_DMCONTROL, 32'h0000_0003); // dmactive=1, ndmreset=1
        @(posedge clk_r);
        if (ndmreset_w == 1'b1) begin
            $display("[PASS] ndmreset asserted correctly");
            checks_passed = checks_passed + 1;
        end else begin
            $display("[FAIL] ndmreset NOT asserted");
            checks_failed = checks_failed + 1;
        end
        dmi_write(`DM_ADDR_DMCONTROL, 32'h0000_0001); // release ndmreset

        // Final summary
        #100;
        $display("=================================================================");
        $display("  TEST SUMMARY");
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
