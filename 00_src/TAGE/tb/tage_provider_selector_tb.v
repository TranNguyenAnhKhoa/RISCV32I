`timescale 1ns/1ps

module tage_provider_selector_tb;

    localparam COUNTER_WIDTH = 3;
    localparam USEFUL_WIDTH  = 1;

    reg                      base_taken_i;
    reg                      table1_hit_i;
    reg  [COUNTER_WIDTH-1:0] table1_counter_i;
    reg  [USEFUL_WIDTH-1:0]  table1_useful_i;
    reg                      table2_hit_i;
    reg  [COUNTER_WIDTH-1:0] table2_counter_i;
    reg  [USEFUL_WIDTH-1:0]  table2_useful_i;
    reg                      table3_hit_i;
    reg  [COUNTER_WIDTH-1:0] table3_counter_i;
    reg  [USEFUL_WIDTH-1:0]  table3_useful_i;
    wire                     predict_taken_o;
    wire [1:0]               provider_table_o;
    wire                     provider_taken_o;
    wire                     alternate_taken_o;

    integer pass_count;
    integer fail_count;

    tage_provider_selector #(
        .COUNTER_WIDTH (COUNTER_WIDTH),
        .USEFUL_WIDTH  (USEFUL_WIDTH)
    ) dut (
        .base_taken_i          (base_taken_i),
        .table1_hit_i          (table1_hit_i),
        .table1_counter_i      (table1_counter_i),
        .table1_useful_i       (table1_useful_i),
        .table2_hit_i          (table2_hit_i),
        .table2_counter_i      (table2_counter_i),
        .table2_useful_i       (table2_useful_i),
        .table3_hit_i          (table3_hit_i),
        .table3_counter_i      (table3_counter_i),
        .table3_useful_i       (table3_useful_i),
        .predict_taken_o       (predict_taken_o),
        .provider_table_o      (provider_table_o),
        .provider_taken_o      (provider_taken_o),
        .alternate_taken_o     (alternate_taken_o)
    );

    task set_default_inputs;
        begin
            base_taken_i     = 1'b0;
            table1_hit_i     = 1'b0;
            table1_counter_i = 3'b000;
            table1_useful_i  = 1'b0;
            table2_hit_i     = 1'b0;
            table2_counter_i = 3'b000;
            table2_useful_i  = 1'b0;
            table3_hit_i     = 1'b0;
            table3_counter_i = 3'b000;
            table3_useful_i  = 1'b0;
        end
    endtask

    task check_outputs;
        input [8*60-1:0] test_name;
        input            expected_prediction;
        input [1:0]      expected_provider_table;
        input            expected_provider_prediction;
        input            expected_alternate_prediction;
        begin
            #1;

            if ((predict_taken_o === expected_prediction) &&
                (provider_table_o === expected_provider_table) &&
                (provider_taken_o === expected_provider_prediction) &&
                (alternate_taken_o === expected_alternate_prediction)) begin
                pass_count = pass_count + 1;
                $display(
                    "[PASS] %-60s final=%b provider=%0d raw=%b alt=%b",
                    test_name,
                    predict_taken_o,
                    provider_table_o,
                    provider_taken_o,
                    alternate_taken_o
                );
            end else begin
                fail_count = fail_count + 1;
                $display(
                    "[FAIL] %-60s exp(final,p,raw,alt)=%b,%0d,%b,%b got=%b,%0d,%b,%b",
                    test_name,
                    expected_prediction,
                    expected_provider_table,
                    expected_provider_prediction,
                    expected_alternate_prediction,
                    predict_taken_o,
                    provider_table_o,
                    provider_taken_o,
                    alternate_taken_o
                );
            end
        end
    endtask

    initial begin
        pass_count = 0;
        fail_count = 0;
        set_default_inputs;

        /*
         * With no tagged hit, the base table supplies final, provider, and
         * alternate predictions.
         */
        base_taken_i = 1'b0;
        check_outputs(
            "no tagged hit selects not-taken base",
            1'b0,
            2'd0,
            1'b0,
            1'b0
        );

        base_taken_i = 1'b1;
        check_outputs(
            "no tagged hit selects taken base",
            1'b1,
            2'd0,
            1'b1,
            1'b1
        );

        /*
         * Table 1 is the provider when it is the only hit. Its alternate is
         * always the base prediction.
         */
        set_default_inputs;
        base_taken_i     = 1'b0;
        table1_hit_i     = 1'b1;
        table1_counter_i = 3'b111;
        table1_useful_i  = 1'b0;
        check_outputs(
            "table1 strong taken overrides not-taken base",
            1'b1,
            2'd1,
            1'b1,
            1'b0
        );

        set_default_inputs;
        base_taken_i     = 1'b1;
        table1_hit_i     = 1'b1;
        table1_counter_i = 3'b000;
        table1_useful_i  = 1'b0;
        check_outputs(
            "table1 strong not-taken overrides taken base",
            1'b0,
            2'd1,
            1'b0,
            1'b1
        );

        /*
         * Weak 011/100 providers with usefulness zero must use alternate.
         */
        set_default_inputs;
        base_taken_i     = 1'b0;
        table1_hit_i     = 1'b1;
        table1_counter_i = 3'b100;
        table1_useful_i  = 1'b0;
        check_outputs(
            "weak taken table1 with u0 uses not-taken base alternate",
            1'b0,
            2'd1,
            1'b1,
            1'b0
        );

        set_default_inputs;
        base_taken_i     = 1'b1;
        table1_hit_i     = 1'b1;
        table1_counter_i = 3'b011;
        table1_useful_i  = 1'b0;
        check_outputs(
            "weak not-taken table1 with u0 uses taken base alternate",
            1'b1,
            2'd1,
            1'b0,
            1'b1
        );

        /*
         * Useful weak providers and non-weak providers use their own raw
         * direction instead of the alternate.
         */
        set_default_inputs;
        base_taken_i     = 1'b0;
        table1_hit_i     = 1'b1;
        table1_counter_i = 3'b100;
        table1_useful_i  = 1'b1;
        check_outputs(
            "weak taken table1 with u1 uses provider",
            1'b1,
            2'd1,
            1'b1,
            1'b0
        );

        set_default_inputs;
        base_taken_i     = 1'b1;
        table1_hit_i     = 1'b1;
        table1_counter_i = 3'b010;
        table1_useful_i  = 1'b0;
        check_outputs(
            "non-weak not-taken table1 with u0 uses provider",
            1'b0,
            2'd1,
            1'b0,
            1'b1
        );

        set_default_inputs;
        base_taken_i     = 1'b0;
        table1_hit_i     = 1'b1;
        table1_counter_i = 3'b101;
        table1_useful_i  = 1'b0;
        check_outputs(
            "non-weak taken table1 with u0 uses provider",
            1'b1,
            2'd1,
            1'b1,
            1'b0
        );

        /*
         * Table 2 has priority over table 1. Table 1 becomes its alternate.
         */
        set_default_inputs;
        base_taken_i     = 1'b1;
        table1_hit_i     = 1'b1;
        table1_counter_i = 3'b001;
        table1_useful_i  = 1'b1;
        table2_hit_i     = 1'b1;
        table2_counter_i = 3'b110;
        table2_useful_i  = 1'b0;
        check_outputs(
            "table2 wins priority and table1 is alternate",
            1'b1,
            2'd2,
            1'b1,
            1'b0
        );

        set_default_inputs;
        base_taken_i     = 1'b1;
        table1_hit_i     = 1'b1;
        table1_counter_i = 3'b001;
        table1_useful_i  = 1'b1;
        table2_hit_i     = 1'b1;
        table2_counter_i = 3'b100;
        table2_useful_i  = 1'b0;
        check_outputs(
            "weak table2 with u0 selects table1 alternate",
            1'b0,
            2'd2,
            1'b1,
            1'b0
        );

        set_default_inputs;
        base_taken_i     = 1'b0;
        table1_hit_i     = 1'b0;
        table2_hit_i     = 1'b1;
        table2_counter_i = 3'b111;
        table2_useful_i  = 1'b0;
        check_outputs(
            "table2 without table1 uses base as alternate",
            1'b1,
            2'd2,
            1'b1,
            1'b0
        );

        /*
         * Table 3 has highest priority. Its alternate is table 2 when table 2
         * hits, otherwise table 1, otherwise base.
         */
        set_default_inputs;
        base_taken_i     = 1'b0;
        table1_hit_i     = 1'b1;
        table1_counter_i = 3'b111;
        table1_useful_i  = 1'b1;
        table2_hit_i     = 1'b1;
        table2_counter_i = 3'b001;
        table2_useful_i  = 1'b1;
        table3_hit_i     = 1'b1;
        table3_counter_i = 3'b110;
        table3_useful_i  = 1'b1;
        check_outputs(
            "table3 wins and nearest table2 supplies alternate",
            1'b1,
            2'd3,
            1'b1,
            1'b0
        );

        set_default_inputs;
        base_taken_i     = 1'b0;
        table1_hit_i     = 1'b1;
        table1_counter_i = 3'b111;
        table1_useful_i  = 1'b1;
        table2_hit_i     = 1'b0;
        table3_hit_i     = 1'b1;
        table3_counter_i = 3'b000;
        table3_useful_i  = 1'b1;
        check_outputs(
            "table3 falls back to table1 when table2 misses",
            1'b0,
            2'd3,
            1'b0,
            1'b1
        );

        set_default_inputs;
        base_taken_i     = 1'b1;
        table1_hit_i     = 1'b0;
        table2_hit_i     = 1'b0;
        table3_hit_i     = 1'b1;
        table3_counter_i = 3'b000;
        table3_useful_i  = 1'b1;
        check_outputs(
            "table3 falls back to base when shorter tables miss",
            1'b0,
            2'd3,
            1'b0,
            1'b1
        );

        set_default_inputs;
        base_taken_i     = 1'b0;
        table1_hit_i     = 1'b1;
        table1_counter_i = 3'b111;
        table1_useful_i  = 1'b1;
        table2_hit_i     = 1'b1;
        table2_counter_i = 3'b000;
        table2_useful_i  = 1'b1;
        table3_hit_i     = 1'b1;
        table3_counter_i = 3'b100;
        table3_useful_i  = 1'b0;
        check_outputs(
            "weak table3 with u0 selects nearest table2 alternate",
            1'b0,
            2'd3,
            1'b1,
            1'b0
        );

        set_default_inputs;
        base_taken_i     = 1'b0;
        table1_hit_i     = 1'b1;
        table1_counter_i = 3'b000;
        table1_useful_i  = 1'b1;
        table2_hit_i     = 1'b0;
        table3_hit_i     = 1'b1;
        table3_counter_i = 3'b011;
        table3_useful_i  = 1'b0;
        check_outputs(
            "weak table3 with u0 selects table1 alternate",
            1'b0,
            2'd3,
            1'b0,
            1'b0
        );

        $display("");
        $display(
            "TAGE PROVIDER SELECTOR TEST SUMMARY: PASS=%0d FAIL=%0d TOTAL=%0d",
            pass_count,
            fail_count,
            pass_count + fail_count
        );

        if (fail_count == 0) begin
            $display("PASS: tage_provider_selector regression");
        end else begin
            $display("FAIL: tage_provider_selector errors=%0d", fail_count);
        end

        $finish;
    end

endmodule
