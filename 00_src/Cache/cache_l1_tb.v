`timescale 1ns/1ps

module cache_l1_tb;
    localparam time CLOCK_PERIOD = 10;
    localparam integer MEMORY_WORD_COUNT = 256;

    reg clock;
    reg reset_n;
    integer pass_count;
    integer fail_count;
    integer memory_index;

    reg         icache_cpu_request_valid;
    reg  [31:0] icache_cpu_address;
    wire        icache_cpu_request_ready;
    wire        icache_cpu_response_valid;
    wire [31:0] icache_cpu_read_data;
    reg         icache_invalidate;
    wire        icache_busy;
    wire        icache_memory_request_valid;
    wire [31:0] icache_memory_address;
    wire        icache_memory_request_ready;
    wire        icache_memory_response_valid;
    wire [31:0] icache_memory_read_data;
    reg         icache_memory_ready_enable;
    wire [31:0] icache_hit_count;
    wire [31:0] icache_miss_count;

    reg         dcache_cpu_request_valid;
    reg         dcache_cpu_write;
    reg  [31:0] dcache_cpu_address;
    reg  [31:0] dcache_cpu_write_data;
    reg  [3:0]  dcache_cpu_write_strobe;
    wire        dcache_cpu_request_ready;
    wire        dcache_cpu_response_valid;
    wire [31:0] dcache_cpu_read_data;
    reg         dcache_flush;
    wire        dcache_flush_busy;
    wire        dcache_flush_done;
    wire        dcache_memory_request_valid;
    wire        dcache_memory_write;
    wire [31:0] dcache_memory_address;
    wire [31:0] dcache_memory_write_data;
    wire [3:0]  dcache_memory_write_strobe;
    wire        dcache_memory_request_ready;
    wire        dcache_memory_response_valid;
    wire [31:0] dcache_memory_read_data;
    reg         dcache_memory_ready_enable;
    wire [31:0] dcache_hit_count;
    wire [31:0] dcache_miss_count;
    wire [31:0] dcache_writeback_count;

    always #(CLOCK_PERIOD/2) begin
        clock = ~clock;
    end

    l1_icache_fa #(
        .LINE_COUNT    (2),
        .WORDS_PER_LINE(4)
    ) instruction_cache (
        .clk_i                 (clock),
        .rstn_i                (reset_n),
        .cpu_request_valid_i   (icache_cpu_request_valid),
        .cpu_address_i         (icache_cpu_address),
        .cpu_request_ready_o   (icache_cpu_request_ready),
        .cpu_response_valid_o  (icache_cpu_response_valid),
        .cpu_read_data_o       (icache_cpu_read_data),
        .invalidate_i          (icache_invalidate),
        .busy_o                (icache_busy),
        .memory_request_valid_o(icache_memory_request_valid),
        .memory_address_o      (icache_memory_address),
        .memory_request_ready_i(icache_memory_request_ready),
        .memory_response_valid_i(icache_memory_response_valid),
        .memory_read_data_i    (icache_memory_read_data),
        .hit_count_o           (icache_hit_count),
        .miss_count_o          (icache_miss_count)
    );

    cache_backing_memory #(
        .WORD_COUNT  (MEMORY_WORD_COUNT),
        .READ_LATENCY(2)
    ) instruction_memory (
        .clk_i                  (clock),
        .rstn_i                 (reset_n),
        .ready_enable_i         (icache_memory_ready_enable),
        .memory_request_valid_i (icache_memory_request_valid),
        .memory_write_i         (1'b0),
        .memory_address_i       (icache_memory_address),
        .memory_write_data_i    (32'b0),
        .memory_write_strobe_i  (4'b0000),
        .memory_request_ready_o (icache_memory_request_ready),
        .memory_response_valid_o(icache_memory_response_valid),
        .memory_read_data_o     (icache_memory_read_data)
    );

    l1_dcache_fa #(
        .LINE_COUNT    (2),
        .WORDS_PER_LINE(4)
    ) data_cache (
        .clk_i                 (clock),
        .rstn_i                (reset_n),
        .cpu_request_valid_i   (dcache_cpu_request_valid),
        .cpu_write_i           (dcache_cpu_write),
        .cpu_address_i         (dcache_cpu_address),
        .cpu_write_data_i      (dcache_cpu_write_data),
        .cpu_write_strobe_i    (dcache_cpu_write_strobe),
        .cpu_request_ready_o   (dcache_cpu_request_ready),
        .cpu_response_valid_o  (dcache_cpu_response_valid),
        .cpu_read_data_o       (dcache_cpu_read_data),
        .flush_i               (dcache_flush),
        .flush_busy_o          (dcache_flush_busy),
        .flush_done_o          (dcache_flush_done),
        .memory_request_valid_o(dcache_memory_request_valid),
        .memory_write_o        (dcache_memory_write),
        .memory_address_o      (dcache_memory_address),
        .memory_write_data_o   (dcache_memory_write_data),
        .memory_write_strobe_o (dcache_memory_write_strobe),
        .memory_request_ready_i(dcache_memory_request_ready),
        .memory_response_valid_i(dcache_memory_response_valid),
        .memory_read_data_i    (dcache_memory_read_data),
        .hit_count_o           (dcache_hit_count),
        .miss_count_o          (dcache_miss_count),
        .writeback_count_o     (dcache_writeback_count)
    );

    cache_backing_memory #(
        .WORD_COUNT  (MEMORY_WORD_COUNT),
        .READ_LATENCY(3)
    ) data_memory (
        .clk_i                  (clock),
        .rstn_i                 (reset_n),
        .ready_enable_i         (dcache_memory_ready_enable),
        .memory_request_valid_i (dcache_memory_request_valid),
        .memory_write_i         (dcache_memory_write),
        .memory_address_i       (dcache_memory_address),
        .memory_write_data_i    (dcache_memory_write_data),
        .memory_write_strobe_i  (dcache_memory_write_strobe),
        .memory_request_ready_o (dcache_memory_request_ready),
        .memory_response_valid_o(dcache_memory_response_valid),
        .memory_read_data_o     (dcache_memory_read_data)
    );

    task automatic check_value(
        input [8*48-1:0] test_name_i,
        input [31:0] actual_value_i,
        input [31:0] expected_value_i
    );
        begin
        if (actual_value_i === expected_value_i) begin
            pass_count = pass_count + 1;
            $display("[PASS] %-36s value=0x%08h", test_name_i, actual_value_i);
        end else begin
            fail_count = fail_count + 1;
            $display("[FAIL] %-36s expected=0x%08h actual=0x%08h",
                     test_name_i,
                     expected_value_i,
                     actual_value_i);
        end
        end
    endtask

    task automatic icache_read_and_check(
        input [31:0] address_i,
        input [31:0] expected_data_i,
        input [8*48-1:0] test_name_i
    );
        begin
        @(negedge clock);
        icache_cpu_address       = address_i;
        icache_cpu_request_valid = 1'b1;

        while (!icache_cpu_request_ready) begin
            @(negedge clock);
        end

        @(posedge clock);
        @(negedge clock);
        icache_cpu_request_valid = 1'b0;

        wait (icache_cpu_response_valid === 1'b1);
        #1;
        check_value(test_name_i, icache_cpu_read_data, expected_data_i);
        end
    endtask

    task automatic dcache_read_and_check(
        input [31:0] address_i,
        input [31:0] expected_data_i,
        input [8*48-1:0] test_name_i
    );
        begin
        @(negedge clock);
        dcache_cpu_address       = address_i;
        dcache_cpu_write         = 1'b0;
        dcache_cpu_write_data    = 32'b0;
        dcache_cpu_write_strobe  = 4'b0000;
        dcache_cpu_request_valid = 1'b1;

        while (!dcache_cpu_request_ready) begin
            @(negedge clock);
        end

        @(posedge clock);
        @(negedge clock);
        dcache_cpu_request_valid = 1'b0;

        wait (dcache_cpu_response_valid === 1'b1);
        #1;
        check_value(test_name_i, dcache_cpu_read_data, expected_data_i);
        end
    endtask

    task automatic dcache_write(
        input [31:0] address_i,
        input [31:0] write_data_i,
        input [3:0] write_strobe_i
    );
        begin
        @(negedge clock);
        dcache_cpu_address       = address_i;
        dcache_cpu_write         = 1'b1;
        dcache_cpu_write_data    = write_data_i;
        dcache_cpu_write_strobe  = write_strobe_i;
        dcache_cpu_request_valid = 1'b1;

        while (!dcache_cpu_request_ready) begin
            @(negedge clock);
        end

        @(posedge clock);
        @(negedge clock);
        dcache_cpu_request_valid = 1'b0;

        wait (dcache_cpu_response_valid === 1'b1);
        #1;
        end
    endtask

    task automatic flush_dcache();
        begin
        while (!dcache_cpu_request_ready) begin
            @(negedge clock);
        end

        @(negedge clock);
        dcache_flush = 1'b1;
        @(posedge clock);
        @(negedge clock);
        dcache_flush = 1'b0;
        wait (dcache_flush_done === 1'b1);
        #1;
        end
    endtask

    initial begin
        clock                       = 1'b0;
        reset_n                     = 1'b0;
        pass_count                  = 0;
        fail_count                  = 0;
        icache_cpu_request_valid    = 1'b0;
        icache_cpu_address          = 32'b0;
        icache_invalidate           = 1'b0;
        icache_memory_ready_enable  = 1'b1;
        dcache_cpu_request_valid    = 1'b0;
        dcache_cpu_write            = 1'b0;
        dcache_cpu_address          = 32'b0;
        dcache_cpu_write_data       = 32'b0;
        dcache_cpu_write_strobe     = 4'b0000;
        dcache_flush                = 1'b0;
        dcache_memory_ready_enable  = 1'b1;

        for (memory_index = 0; memory_index < MEMORY_WORD_COUNT; memory_index = memory_index + 1) begin
            instruction_memory.memory[memory_index] = 32'ha0000000 + memory_index;
            data_memory.memory[memory_index]        = 32'hb0000000 + memory_index;
        end

        repeat (4) @(posedge clock);
        @(negedge clock);
        reset_n = 1'b1;

        $display("\n========== FULLY-ASSOCIATIVE L1 I-CACHE TESTS ==========");
        icache_read_and_check(32'h00000000, 32'ha0000000, "I-cache cold miss");
        icache_read_and_check(32'h00000004, 32'ha0000001, "I-cache same-line hit");
        icache_read_and_check(32'h00000000, 32'ha0000000, "I-cache repeated hit");

        icache_memory_ready_enable = 1'b0;
        fork
            begin
                repeat (3) @(posedge clock);
                icache_memory_ready_enable = 1'b1;
            end
            begin
                icache_read_and_check(32'h00000010, 32'ha0000004,
                                      "I-cache miss with memory backpressure");
            end
        join

        icache_read_and_check(32'h00000020, 32'ha0000008, "I-cache round-robin replacement");
        icache_read_and_check(32'h00000000, 32'ha0000000, "I-cache evicted line re-miss");

        while (!icache_cpu_request_ready) begin
            @(negedge clock);
        end
        @(negedge clock);
        icache_invalidate = 1'b1;
        @(posedge clock);
        @(negedge clock);
        icache_invalidate = 1'b0;
        icache_read_and_check(32'h00000004, 32'ha0000001, "I-cache invalidate forces miss");
        check_value("I-cache hit counter", icache_hit_count, 32'd2);
        check_value("I-cache miss counter", icache_miss_count, 32'd5);

        $display("\n========== FULLY-ASSOCIATIVE L1 D-CACHE TESTS ==========");
        dcache_read_and_check(32'h00000000, 32'hb0000000, "D-cache cold load miss");
        dcache_read_and_check(32'h00000004, 32'hb0000001, "D-cache same-line load hit");

        dcache_write(32'h00000000, 32'h000000aa, 4'b0001);
        dcache_read_and_check(32'h00000000, 32'hb00000aa, "D-cache byte-strobe merge");
        dcache_write(32'h00000000, 32'h12340000, 4'b1100);
        dcache_read_and_check(32'h00000000, 32'h123400aa, "D-cache halfword-strobe merge");

        dcache_memory_ready_enable = 1'b0;
        fork
            begin
                repeat (3) @(posedge clock);
                dcache_memory_ready_enable = 1'b1;
            end
            begin
                dcache_read_and_check(32'h00000010, 32'hb0000004,
                                      "D-cache miss with memory backpressure");
            end
        join

        dcache_read_and_check(32'h00000020, 32'hb0000008, "D-cache dirty-victim replacement");
        check_value("D-cache dirty line writeback", data_memory.memory[0], 32'h123400aa);

        dcache_write(32'h00000030, 32'hdeadbeef, 4'b1111);
        dcache_read_and_check(32'h00000030, 32'hdeadbeef, "D-cache write-allocate hit replay");
        check_value("D-cache write-back deferred", data_memory.memory[12], 32'hb000000c);

        flush_dcache();
        check_value("D-cache flush writes dirty line", data_memory.memory[12], 32'hdeadbeef);
        dcache_read_and_check(32'h00000030, 32'hdeadbeef, "D-cache post-flush miss");
        check_value("D-cache hit counter", dcache_hit_count, 32'd6);
        check_value("D-cache miss counter", dcache_miss_count, 32'd5);
        check_value("D-cache eviction writeback count", dcache_writeback_count, 32'd1);

        $display("\n=========================================================");
        $display("CACHE TEST SUMMARY: PASS=%0d FAIL=%0d TOTAL=%0d",
                 pass_count,
                 fail_count,
                 pass_count + fail_count);
        $display("=========================================================\n");

        if (fail_count != 0) begin
            $display("ERROR: Cache regression failed with %0d error(s)", fail_count);
            $finish;
        end

        $finish;
    end

    initial begin
        #100000;
        $display("ERROR: Cache testbench timeout");
        $finish;
    end

`ifdef VERILATOR
    initial begin
        $dumpfile("cache_l1_tb.vcd");
        $dumpvars(0, cache_l1_tb);
    end
`endif
endmodule
