`timescale 1ns/1ps

module tage_tagged_table_tb;

    localparam ENTRY_COUNT   = 8;
    localparam INDEX_WIDTH   = 3;
    localparam TAG_WIDTH     = 4;
    localparam COUNTER_WIDTH = 3;
    localparam USEFUL_WIDTH  = 1;
    localparam CLOCK_PERIOD  = 10;

    reg                      clk_i;
    reg                      rstn_i;
    reg  [INDEX_WIDTH-1:0]   predict_index_i;
    reg  [TAG_WIDTH-1:0]     predict_tag_i;
    wire                     predict_hit_o;
    wire [COUNTER_WIDTH-1:0] predict_counter_o;
    wire [USEFUL_WIDTH-1:0]  predict_useful_o;
    reg  [INDEX_WIDTH-1:0]   update_index_i;
    reg  [TAG_WIDTH-1:0]     update_tag_i;
    wire                     update_hit_o;
    wire [USEFUL_WIDTH-1:0]  update_useful_o;
    reg                      train_valid_i;
    reg                      train_taken_i;
    reg                      train_useful_valid_i;
    reg                      train_useful_increment_i;
    reg                      allocate_valid_i;
    reg                      allocate_taken_i;
    reg                      age_valid_i;
    wire                     retained_predict_hit_o;
    wire [COUNTER_WIDTH-1:0] retained_predict_counter_o;
    wire [USEFUL_WIDTH-1:0]  retained_predict_useful_o;
    wire                     retained_update_hit_o;
    wire [USEFUL_WIDTH-1:0]  retained_update_useful_o;

    integer pass_count;
    integer fail_count;

    tage_tagged_table #(
        .ENTRY_COUNT         (ENTRY_COUNT),
        .INDEX_WIDTH         (INDEX_WIDTH),
        .TAG_WIDTH           (TAG_WIDTH),
        .COUNTER_WIDTH       (COUNTER_WIDTH),
        .USEFUL_WIDTH        (USEFUL_WIDTH),
        .RESET_ON_SOFT_RESET (1)
    ) dut (
        .clk_i                    (clk_i),
        .rstn_i                   (rstn_i),
        .predict_index_i          (predict_index_i),
        .predict_tag_i            (predict_tag_i),
        .predict_hit_o            (predict_hit_o),
        .predict_counter_o        (predict_counter_o),
        .predict_useful_o         (predict_useful_o),
        .update_index_i           (update_index_i),
        .update_tag_i             (update_tag_i),
        .update_hit_o             (update_hit_o),
        .update_useful_o          (update_useful_o),
        .train_valid_i            (train_valid_i),
        .train_taken_i            (train_taken_i),
        .train_useful_valid_i     (train_useful_valid_i),
        .train_useful_increment_i (train_useful_increment_i),
        .allocate_valid_i         (allocate_valid_i),
        .allocate_taken_i         (allocate_taken_i),
        .age_valid_i              (age_valid_i)
    );

    tage_tagged_table #(
        .ENTRY_COUNT         (ENTRY_COUNT),
        .INDEX_WIDTH         (INDEX_WIDTH),
        .TAG_WIDTH           (TAG_WIDTH),
        .COUNTER_WIDTH       (COUNTER_WIDTH),
        .USEFUL_WIDTH        (USEFUL_WIDTH),
        .RESET_ON_SOFT_RESET (0)
    ) retained_dut (
        .clk_i                    (clk_i),
        .rstn_i                   (rstn_i),
        .predict_index_i          (predict_index_i),
        .predict_tag_i            (predict_tag_i),
        .predict_hit_o            (retained_predict_hit_o),
        .predict_counter_o        (retained_predict_counter_o),
        .predict_useful_o         (retained_predict_useful_o),
        .update_index_i           (update_index_i),
        .update_tag_i             (update_tag_i),
        .update_hit_o             (retained_update_hit_o),
        .update_useful_o          (retained_update_useful_o),
        .train_valid_i            (train_valid_i),
        .train_taken_i            (train_taken_i),
        .train_useful_valid_i     (train_useful_valid_i),
        .train_useful_increment_i (train_useful_increment_i),
        .allocate_valid_i         (allocate_valid_i),
        .allocate_taken_i         (allocate_taken_i),
        .age_valid_i              (age_valid_i)
    );

    always #(CLOCK_PERIOD/2) begin
        clk_i = ~clk_i;
    end

    task clear_write_controls;
        begin
            train_valid_i            = 1'b0;
            train_taken_i            = 1'b0;
            train_useful_valid_i     = 1'b0;
            train_useful_increment_i = 1'b0;
            allocate_valid_i         = 1'b0;
            allocate_taken_i         = 1'b0;
            age_valid_i              = 1'b0;
        end
    endtask

    task check_retained_entry;
        input [8*56-1:0]          test_name;
        input [INDEX_WIDTH-1:0]   entry_index;
        input [TAG_WIDTH-1:0]     entry_tag;
        input                     expected_hit;
        input [COUNTER_WIDTH-1:0] expected_counter;
        input [USEFUL_WIDTH-1:0]  expected_useful;
        begin
            predict_index_i = entry_index;
            predict_tag_i   = entry_tag;
            update_index_i  = entry_index;
            update_tag_i    = entry_tag;
            #1;

            if ((retained_predict_hit_o === expected_hit) &&
                (retained_update_hit_o === expected_hit) &&
                (retained_predict_counter_o === expected_counter) &&
                (retained_predict_useful_o === expected_useful) &&
                (retained_update_useful_o === expected_useful)) begin
                pass_count = pass_count + 1;
                $display(
                    "[PASS] %-56s hit=%b counter=%03b useful=%b",
                    test_name,
                    retained_predict_hit_o,
                    retained_predict_counter_o,
                    retained_predict_useful_o
                );
            end else begin
                fail_count = fail_count + 1;
                $display(
                    "[FAIL] %-56s exp(hit,counter,u)=%b,%03b,%b got=%b,%03b,%b",
                    test_name,
                    expected_hit,
                    expected_counter,
                    expected_useful,
                    retained_predict_hit_o,
                    retained_predict_counter_o,
                    retained_predict_useful_o
                );
            end
        end
    endtask

    task apply_reset;
        begin
            @(negedge clk_i);
            rstn_i = 1'b0;
            clear_write_controls;

            repeat (2) begin
                @(posedge clk_i);
            end

            @(negedge clk_i);
            rstn_i = 1'b1;
            #1;
        end
    endtask

    task pulse_allocate;
        input [INDEX_WIDTH-1:0] entry_index;
        input [TAG_WIDTH-1:0]   entry_tag;
        input                   entry_taken;
        begin
            @(negedge clk_i);
            update_index_i   = entry_index;
            update_tag_i     = entry_tag;
            allocate_taken_i = entry_taken;
            allocate_valid_i = 1'b1;

            @(posedge clk_i);
            #1;
            allocate_valid_i = 1'b0;
        end
    endtask

    task pulse_train;
        input [INDEX_WIDTH-1:0] entry_index;
        input [TAG_WIDTH-1:0]   entry_tag;
        input                   actual_taken;
        input                   useful_update_valid;
        input                   useful_increment;
        begin
            @(negedge clk_i);
            update_index_i           = entry_index;
            update_tag_i             = entry_tag;
            train_taken_i            = actual_taken;
            train_useful_valid_i     = useful_update_valid;
            train_useful_increment_i = useful_increment;
            train_valid_i            = 1'b1;

            @(posedge clk_i);
            #1;
            train_valid_i        = 1'b0;
            train_useful_valid_i = 1'b0;
        end
    endtask

    task pulse_age;
        input [INDEX_WIDTH-1:0] entry_index;
        input [TAG_WIDTH-1:0]   entry_tag;
        begin
            @(negedge clk_i);
            update_index_i = entry_index;
            update_tag_i   = entry_tag;
            age_valid_i    = 1'b1;

            @(posedge clk_i);
            #1;
            age_valid_i = 1'b0;
        end
    endtask

    task check_entry;
        input [8*56-1:0]          test_name;
        input [INDEX_WIDTH-1:0]   entry_index;
        input [TAG_WIDTH-1:0]     entry_tag;
        input                     expected_hit;
        input [COUNTER_WIDTH-1:0] expected_counter;
        input [USEFUL_WIDTH-1:0]  expected_useful;
        begin
            predict_index_i = entry_index;
            predict_tag_i   = entry_tag;
            update_index_i  = entry_index;
            update_tag_i    = entry_tag;
            #1;

            if ((predict_hit_o === expected_hit) &&
                (update_hit_o === expected_hit) &&
                (predict_counter_o === expected_counter) &&
                (predict_useful_o === expected_useful) &&
                (update_useful_o === expected_useful)) begin
                pass_count = pass_count + 1;
                $display(
                    "[PASS] %-56s hit=%b counter=%03b useful=%b",
                    test_name,
                    predict_hit_o,
                    predict_counter_o,
                    predict_useful_o
                );
            end else begin
                fail_count = fail_count + 1;
                $display(
                    "[FAIL] %-56s exp(hit,counter,u)=%b,%03b,%b got=%b,%03b,%b update_hit=%b update_u=%b",
                    test_name,
                    expected_hit,
                    expected_counter,
                    expected_useful,
                    predict_hit_o,
                    predict_counter_o,
                    predict_useful_o,
                    update_hit_o,
                    update_useful_o
                );
            end
        end
    endtask

    initial begin
        clk_i                     = 1'b0;
        rstn_i                    = 1'b1;
        predict_index_i           = {INDEX_WIDTH{1'b0}};
        predict_tag_i             = {TAG_WIDTH{1'b0}};
        update_index_i            = {INDEX_WIDTH{1'b0}};
        update_tag_i              = {TAG_WIDTH{1'b0}};
        pass_count                = 0;
        fail_count                = 0;
        clear_write_controls;

        apply_reset;

        check_entry(
            "cold entry is invalid",
            3'd0,
            4'h0,
            1'b0,
            3'b011,
            1'b0
        );

        /*
         * Allocation installs a valid tag with a weak prediction in the
         * requested direction. A different tag at the same index must miss.
         */
        pulse_allocate(3'd1, 4'ha, 1'b1);
        check_entry(
            "allocate taken creates weakly-taken entry",
            3'd1,
            4'ha,
            1'b1,
            3'b100,
            1'b0
        );
        check_entry(
            "same index with a different tag misses",
            3'd1,
            4'hb,
            1'b0,
            3'b100,
            1'b0
        );

        /*
         * A train request with a mismatching tag must not update the entry.
         */
        pulse_train(3'd1, 4'hb, 1'b0, 1'b1, 1'b1);
        check_entry(
            "tag mismatch blocks counter and usefulness training",
            3'd1,
            4'ha,
            1'b1,
            3'b100,
            1'b0
        );

        /*
         * Traverse all eight three-bit counter states and verify saturation
         * at both ends.
         */
        pulse_allocate(3'd2, 4'h5, 1'b0);
        check_entry("counter starts at 011", 3'd2, 4'h5, 1'b1, 3'b011, 1'b0);

        pulse_train(3'd2, 4'h5, 1'b0, 1'b0, 1'b0);
        check_entry("counter decrements to 010", 3'd2, 4'h5, 1'b1, 3'b010, 1'b0);

        pulse_train(3'd2, 4'h5, 1'b0, 1'b0, 1'b0);
        check_entry("counter decrements to 001", 3'd2, 4'h5, 1'b1, 3'b001, 1'b0);

        pulse_train(3'd2, 4'h5, 1'b0, 1'b0, 1'b0);
        check_entry("counter decrements to 000", 3'd2, 4'h5, 1'b1, 3'b000, 1'b0);

        pulse_train(3'd2, 4'h5, 1'b0, 1'b0, 1'b0);
        check_entry("counter saturates at 000", 3'd2, 4'h5, 1'b1, 3'b000, 1'b0);

        pulse_train(3'd2, 4'h5, 1'b1, 1'b0, 1'b0);
        check_entry("counter increments to 001", 3'd2, 4'h5, 1'b1, 3'b001, 1'b0);

        pulse_train(3'd2, 4'h5, 1'b1, 1'b0, 1'b0);
        check_entry("counter increments to 010", 3'd2, 4'h5, 1'b1, 3'b010, 1'b0);

        pulse_train(3'd2, 4'h5, 1'b1, 1'b0, 1'b0);
        check_entry("counter increments to 011", 3'd2, 4'h5, 1'b1, 3'b011, 1'b0);

        pulse_train(3'd2, 4'h5, 1'b1, 1'b0, 1'b0);
        check_entry("counter increments to 100", 3'd2, 4'h5, 1'b1, 3'b100, 1'b0);

        pulse_train(3'd2, 4'h5, 1'b1, 1'b0, 1'b0);
        check_entry("counter increments to 101", 3'd2, 4'h5, 1'b1, 3'b101, 1'b0);

        pulse_train(3'd2, 4'h5, 1'b1, 1'b0, 1'b0);
        check_entry("counter increments to 110", 3'd2, 4'h5, 1'b1, 3'b110, 1'b0);

        pulse_train(3'd2, 4'h5, 1'b1, 1'b0, 1'b0);
        check_entry("counter increments to 111", 3'd2, 4'h5, 1'b1, 3'b111, 1'b0);

        pulse_train(3'd2, 4'h5, 1'b1, 1'b0, 1'b0);
        check_entry("counter saturates at 111", 3'd2, 4'h5, 1'b1, 3'b111, 1'b0);

        /*
         * Useful state is updated only when train_useful_valid_i is asserted.
         * With one useful bit, increment and decrement saturate at 1 and 0.
         */
        pulse_allocate(3'd3, 4'hc, 1'b0);
        check_entry("usefulness starts at zero", 3'd3, 4'hc, 1'b1, 3'b011, 1'b0);

        pulse_train(3'd3, 4'hc, 1'b0, 1'b1, 1'b1);
        check_entry("usefulness increments to one", 3'd3, 4'hc, 1'b1, 3'b010, 1'b1);

        pulse_train(3'd3, 4'hc, 1'b0, 1'b1, 1'b1);
        check_entry("usefulness saturates at one", 3'd3, 4'hc, 1'b1, 3'b001, 1'b1);

        pulse_train(3'd3, 4'hc, 1'b1, 1'b1, 1'b0);
        check_entry("usefulness decrements to zero", 3'd3, 4'hc, 1'b1, 3'b010, 1'b0);

        pulse_train(3'd3, 4'hc, 1'b1, 1'b1, 1'b0);
        check_entry("usefulness saturates at zero", 3'd3, 4'hc, 1'b1, 3'b011, 1'b0);

        /*
         * Aging clears usefulness without changing valid, tag, or counter.
         */
        pulse_train(3'd3, 4'hc, 1'b1, 1'b1, 1'b1);
        check_entry("prepare useful entry for aging", 3'd3, 4'hc, 1'b1, 3'b100, 1'b1);

        pulse_age(3'd3, 4'hc);
        check_entry("aging clears usefulness only", 3'd3, 4'hc, 1'b1, 3'b100, 1'b0);

        pulse_age(3'd3, 4'hc);
        check_entry("aging at zero preserves the entry", 3'd3, 4'hc, 1'b1, 3'b100, 1'b0);

        /*
         * ASIC reset invalidates the separate validity plane for both values
         * of the compatibility parameter. Tag/counter storage is not reset.
         */
        apply_reset;
        check_entry(
            "ASIC reset invalidates tagged entry",
            3'd3,
            4'hc,
            1'b0,
            3'b011,
            1'b0
        );

        check_retained_entry(
            "ASIC reset invalidates compatibility mode",
            3'd3,
            4'hc,
            1'b0,
            3'b011,
            1'b0
        );

        pulse_allocate(3'd3, 4'hc, 1'b0);
        check_entry(
            "allocation revalidates entry after reset",
            3'd3,
            4'hc,
            1'b1,
            3'b011,
            1'b0
        );

        $display("");
        $display(
            "TAGE TAGGED TABLE TEST SUMMARY: PASS=%0d FAIL=%0d TOTAL=%0d",
            pass_count,
            fail_count,
            pass_count + fail_count
        );

        if (fail_count == 0) begin
            $display("PASS: tage_tagged_table regression");
        end else begin
            $display("FAIL: tage_tagged_table errors=%0d", fail_count);
        end

        $finish;
    end

    initial begin
        #20000;
        $display("FAIL: tage_tagged_table timeout");
        $finish;
    end

`ifdef VERILATOR
    initial begin
        $dumpfile("tage_tagged_table_tb.vcd");
        $dumpvars(0, tage_tagged_table_tb);
    end
`endif

endmodule
