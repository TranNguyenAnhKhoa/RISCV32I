`timescale 1ns/1ps

module tage_predictor_tb;

    localparam TAGGED_INDEX_WIDTH = 5;
    localparam TABLE1_TAG_WIDTH   = 6;
    localparam TABLE2_TAG_WIDTH   = 7;
    localparam TABLE3_TAG_WIDTH   = 8;
    localparam HISTORY_WIDTH      = 32;
    localparam INDEX_BUS_WIDTH    = 3 * TAGGED_INDEX_WIDTH;
    localparam TAG_BUS_WIDTH      = TABLE1_TAG_WIDTH +
                                    TABLE2_TAG_WIDTH +
                                    TABLE3_TAG_WIDTH;

    reg                          clk_i;
    reg                          rstn_i;
    reg                          predict_accept_i;
    reg  [31:0]                  predict_pc_i;
    reg                          history_recover_valid_i;
    reg  [HISTORY_WIDTH-1:0]     history_recover_i;
    wire                         predict_taken_o;
    wire [1:0]                   predict_provider_table_o;
    wire                         predict_provider_taken_o;
    wire                         predict_alternate_taken_o;
    wire [INDEX_BUS_WIDTH-1:0]    predict_indices_o;
    wire [TAG_BUS_WIDTH-1:0]      predict_tags_o;
    wire [HISTORY_WIDTH-1:0]      predict_history_o;
    reg                          update_valid_i;
    reg  [31:0]                  update_pc_i;
    reg                          update_taken_i;
    reg                          update_prediction_i;
    reg  [1:0]                   update_provider_table_i;
    reg                          update_provider_taken_i;
    reg                          update_alternate_taken_i;
    reg  [INDEX_BUS_WIDTH-1:0]    update_indices_i;
    reg  [TAG_BUS_WIDTH-1:0]      update_tags_i;
    reg  [HISTORY_WIDTH-1:0]      update_history_i;

    reg                          branch_prediction;
    reg  [1:0]                   branch_provider;
    reg                          branch_outcome;
    reg                          context_a_prediction;
    reg  [1:0]                   context_a_provider_table;
    reg                          context_a_provider_taken;
    reg                          context_a_alternate_taken;
    reg  [INDEX_BUS_WIDTH-1:0]   context_a_indices;
    reg  [TAG_BUS_WIDTH-1:0]     context_a_tags;
    reg  [HISTORY_WIDTH-1:0]     context_a_history;
    reg                          context_a_actual;
    reg                          context_b_prediction;
    reg  [HISTORY_WIDTH-1:0]     context_b_history;
    reg  [HISTORY_WIDTH-1:0]     expected_history;
    reg  [INDEX_BUS_WIDTH-1:0]   reference_indices;
    reg  [TAG_BUS_WIDTH-1:0]     reference_tags;

    integer error_count;
    integer correct_count;
    integer tagged_provider_count;
    integer iteration;

    tage_predictor #(
        .BASE_ENTRY_COUNT      (64),
        .TAGGED_ENTRY_COUNT    (32),
        .TAGGED_INDEX_WIDTH    (TAGGED_INDEX_WIDTH),
        .TABLE1_TAG_WIDTH      (TABLE1_TAG_WIDTH),
        .TABLE2_TAG_WIDTH      (TABLE2_TAG_WIDTH),
        .TABLE3_TAG_WIDTH      (TABLE3_TAG_WIDTH),
        .COUNTER_WIDTH         (3),
        .USEFUL_WIDTH          (1),
        .HISTORY_WIDTH         (HISTORY_WIDTH),
        .TABLE1_HISTORY_LENGTH (4),
        .TABLE2_HISTORY_LENGTH (12),
        .TABLE3_HISTORY_LENGTH (32),
        .RESET_ON_SOFT_RESET   (1),
        .SPECULATIVE_HISTORY   (1)
    ) dut (
        .clk_i                       (clk_i),
        .rstn_i                      (rstn_i),
        .predict_accept_i            (predict_accept_i),
        .predict_pc_i                (predict_pc_i),
        .history_recover_valid_i     (history_recover_valid_i),
        .history_recover_i           (history_recover_i),
        .predict_taken_o             (predict_taken_o),
        .predict_provider_table_o    (predict_provider_table_o),
        .predict_provider_taken_o    (predict_provider_taken_o),
        .predict_alternate_taken_o   (predict_alternate_taken_o),
        .predict_indices_o           (predict_indices_o),
        .predict_tags_o              (predict_tags_o),
        .predict_history_o           (predict_history_o),
        .update_valid_i              (update_valid_i),
        .update_pc_i                 (update_pc_i),
        .update_taken_i              (update_taken_i),
        .update_prediction_i         (update_prediction_i),
        .update_provider_table_i     (update_provider_table_i),
        .update_provider_taken_i     (update_provider_taken_i),
        .update_alternate_taken_i    (update_alternate_taken_i),
        .update_indices_i            (update_indices_i),
        .update_tags_i               (update_tags_i),
        .update_history_i            (update_history_i)
    );

    always #5 clk_i = ~clk_i;

    task apply_reset;
        begin
            @(negedge clk_i);
            rstn_i           = 1'b0;
            predict_accept_i = 1'b0;
            history_recover_valid_i = 1'b0;
            update_valid_i   = 1'b0;

            repeat (2) @(posedge clk_i);
            @(negedge clk_i);
            rstn_i = 1'b1;
            #1;
        end
    endtask

    task recover_speculative_history;
        input [HISTORY_WIDTH-1:0] recover_history;
        begin
            @(negedge clk_i);
            history_recover_i       = recover_history;
            history_recover_valid_i = 1'b1;

            @(posedge clk_i);
            #1;
            history_recover_valid_i = 1'b0;

            if (predict_history_o !== recover_history) begin
                $display(
                    "ERROR: history recovery expected=%h actual=%h",
                    recover_history,
                    predict_history_o
                );
                error_count = error_count + 1;
            end
        end
    endtask

    task check_cold_prediction;
        input [31:0] branch_pc;
        begin
            predict_pc_i = branch_pc;
            #1;

            if ((predict_taken_o !== 1'b0) ||
                (predict_provider_table_o !== 2'd0) ||
                (^predict_indices_o === 1'bx) ||
                (^predict_tags_o === 1'bx) ||
                (^predict_history_o === 1'bx)) begin
                $display(
                    "ERROR: invalid cold prediction pc=%h pred=%b provider=%0d",
                    branch_pc,
                    predict_taken_o,
                    predict_provider_table_o
                );
                error_count = error_count + 1;
            end
        end
    endtask

    task execute_branch;
        input  [31:0] branch_pc;
        input         actual_taken;
        output        predicted_taken;
        output [1:0]  provider_table;

        reg                         captured_prediction;
        reg [1:0]                   captured_provider_table;
        reg                         captured_provider_taken;
        reg                         captured_alternate_taken;
        reg [INDEX_BUS_WIDTH-1:0]   captured_indices;
        reg [TAG_BUS_WIDTH-1:0]     captured_tags;
        reg [HISTORY_WIDTH-1:0]     captured_history;
        begin
            @(negedge clk_i);
            predict_pc_i = branch_pc;
            #1;

            captured_prediction      = predict_taken_o;
            captured_provider_table  = predict_provider_table_o;
            captured_provider_taken  = predict_provider_taken_o;
            captured_alternate_taken = predict_alternate_taken_o;
            captured_indices         = predict_indices_o;
            captured_tags            = predict_tags_o;
            captured_history         = predict_history_o;

            if ((captured_indices[TAGGED_INDEX_WIDTH-1:0] !==
                 dut.predict_index1_w) ||
                (captured_indices[(2*TAGGED_INDEX_WIDTH)-1:
                                  TAGGED_INDEX_WIDTH] !==
                 dut.predict_index2_w) ||
                (captured_indices[(3*TAGGED_INDEX_WIDTH)-1:
                                  (2*TAGGED_INDEX_WIDTH)] !==
                 dut.predict_index3_w) ||
                (captured_tags[TABLE1_TAG_WIDTH-1:0] !==
                 dut.predict_tag1_w) ||
                (captured_tags[(TABLE1_TAG_WIDTH+TABLE2_TAG_WIDTH)-1:
                               TABLE1_TAG_WIDTH] !==
                 dut.predict_tag2_w) ||
                (captured_tags[TAG_BUS_WIDTH-1:
                               (TABLE1_TAG_WIDTH+TABLE2_TAG_WIDTH)] !==
                 dut.predict_tag3_w)) begin
                $display("ERROR: prediction context packing pc=%h", branch_pc);
                error_count = error_count + 1;
            end

            if ((captured_prediction !== 1'b0) &&
                (captured_prediction !== 1'b1)) begin
                $display("ERROR: X prediction pc=%h", branch_pc);
                error_count = error_count + 1;
            end

            predicted_taken = captured_prediction;
            provider_table  = captured_provider_table;

            predict_accept_i = 1'b1;
            @(posedge clk_i);
            #1;
            predict_accept_i = 1'b0;

            @(negedge clk_i);
            update_pc_i              = branch_pc;
            update_taken_i           = actual_taken;
            update_prediction_i      = captured_prediction;
            update_provider_table_i  = captured_provider_table;
            update_provider_taken_i  = captured_provider_taken;
            update_alternate_taken_i = captured_alternate_taken;
            update_indices_i         = captured_indices;
            update_tags_i            = captured_tags;
            update_history_i         = captured_history;
            update_valid_i           = 1'b1;
            #1;

            if ((dut.update_index1_w !==
                 captured_indices[TAGGED_INDEX_WIDTH-1:0]) ||
                (dut.update_index2_w !==
                 captured_indices[(2*TAGGED_INDEX_WIDTH)-1:
                                  TAGGED_INDEX_WIDTH]) ||
                (dut.update_index3_w !==
                 captured_indices[(3*TAGGED_INDEX_WIDTH)-1:
                                  (2*TAGGED_INDEX_WIDTH)]) ||
                (dut.update_tag1_w !==
                 captured_tags[TABLE1_TAG_WIDTH-1:0]) ||
                (dut.update_tag2_w !==
                 captured_tags[(TABLE1_TAG_WIDTH+TABLE2_TAG_WIDTH)-1:
                               TABLE1_TAG_WIDTH]) ||
                (dut.update_tag3_w !==
                 captured_tags[TAG_BUS_WIDTH-1:
                               (TABLE1_TAG_WIDTH+TABLE2_TAG_WIDTH)])) begin
                $display("ERROR: update context unpacking pc=%h", branch_pc);
                error_count = error_count + 1;
            end

            @(posedge clk_i);
            #1;
            update_valid_i = 1'b0;
        end
    endtask

    initial begin
        clk_i                      = 1'b0;
        rstn_i                     = 1'b1;
        predict_accept_i           = 1'b0;
        predict_pc_i               = 32'b0;
        history_recover_valid_i    = 1'b0;
        history_recover_i          = {HISTORY_WIDTH{1'b0}};
        update_valid_i             = 1'b0;
        update_pc_i                = 32'b0;
        update_taken_i             = 1'b0;
        update_prediction_i        = 1'b0;
        update_provider_table_i    = 2'd0;
        update_provider_taken_i    = 1'b0;
        update_alternate_taken_i   = 1'b0;
        update_indices_i           = {INDEX_BUS_WIDTH{1'b0}};
        update_tags_i              = {TAG_BUS_WIDTH{1'b0}};
        update_history_i           = {HISTORY_WIDTH{1'b0}};
        branch_prediction          = 1'b0;
        branch_provider            = 2'd0;
        branch_outcome             = 1'b0;
        context_a_prediction       = 1'b0;
        context_a_provider_table   = 2'd0;
        context_a_provider_taken   = 1'b0;
        context_a_alternate_taken  = 1'b0;
        context_a_indices          = {INDEX_BUS_WIDTH{1'b0}};
        context_a_tags             = {TAG_BUS_WIDTH{1'b0}};
        context_a_history          = {HISTORY_WIDTH{1'b0}};
        context_a_actual           = 1'b0;
        context_b_prediction       = 1'b0;
        context_b_history          = {HISTORY_WIDTH{1'b0}};
        expected_history           = {HISTORY_WIDTH{1'b0}};
        reference_indices          = {INDEX_BUS_WIDTH{1'b0}};
        reference_tags             = {TAG_BUS_WIDTH{1'b0}};
        error_count                = 0;
        correct_count              = 0;
        tagged_provider_count      = 0;

        apply_reset;
        check_cold_prediction(32'h0000_0100);

        /*
         * PC bit 18 must affect both index and tag folding. This catches a
         * hash implementation that only uses low PC slices.
         */
        predict_pc_i      = 32'h0000_0300;
        #1;
        reference_indices = predict_indices_o;
        reference_tags    = predict_tags_o;
        predict_pc_i      = 32'h0004_0300;
        #1;

        if ((reference_indices === predict_indices_o) ||
            (reference_tags === predict_tags_o)) begin
            $display("ERROR: high PC bits are not folded into index/tag");
            error_count = error_count + 1;
        end

        /*
         * Seed the speculative GHR, accept two unresolved branches, then
         * resolve the older branch incorrectly. Recovery must discard both
         * its predicted bit and the younger wrong-path prediction.
         */
        @(negedge clk_i);
        history_recover_i       = 32'hA5A5_5A5A;
        history_recover_valid_i = 1'b1;
        @(posedge clk_i);
        #1;
        history_recover_valid_i = 1'b0;

        if (predict_history_o !== 32'hA5A5_5A5A) begin
            $display(
                "ERROR: external history recovery actual=%h",
                predict_history_o
            );
            error_count = error_count + 1;
        end

        @(negedge clk_i);
        predict_pc_i              = 32'h0000_0080;
        #1;
        context_a_prediction      = predict_taken_o;
        context_a_provider_table  = predict_provider_table_o;
        context_a_provider_taken  = predict_provider_taken_o;
        context_a_alternate_taken = predict_alternate_taken_o;
        context_a_indices         = predict_indices_o;
        context_a_tags            = predict_tags_o;
        context_a_history         = predict_history_o;
        predict_accept_i          = 1'b1;
        @(posedge clk_i);
        #1;
        predict_accept_i          = 1'b0;

        @(negedge clk_i);
        predict_pc_i         = 32'h0000_00C0;
        #1;
        context_b_prediction = predict_taken_o;
        context_b_history    = predict_history_o;
        expected_history     = {
            context_a_history[HISTORY_WIDTH-2:0],
            context_a_prediction
        };

        if (context_b_history !== expected_history) begin
            $display(
                "ERROR: first speculative shift expected=%h actual=%h",
                expected_history,
                context_b_history
            );
            error_count = error_count + 1;
        end

        predict_accept_i = 1'b1;
        @(posedge clk_i);
        #1;
        predict_accept_i = 1'b0;
        expected_history = {
            context_b_history[HISTORY_WIDTH-2:0],
            context_b_prediction
        };

        if (predict_history_o !== expected_history) begin
            $display(
                "ERROR: second speculative shift expected=%h actual=%h",
                expected_history,
                predict_history_o
            );
            error_count = error_count + 1;
        end

        context_a_actual = ~context_a_prediction;

        @(negedge clk_i);
        predict_pc_i              = 32'h0000_0100;
        predict_accept_i          = 1'b1;
        update_pc_i               = 32'h0000_0080;
        update_taken_i            = context_a_actual;
        update_prediction_i       = context_a_prediction;
        update_provider_table_i   = context_a_provider_table;
        update_provider_taken_i   = context_a_provider_taken;
        update_alternate_taken_i  = context_a_alternate_taken;
        update_indices_i          = context_a_indices;
        update_tags_i             = context_a_tags;
        update_history_i          = context_a_history;
        update_valid_i            = 1'b1;
        @(posedge clk_i);
        #1;
        predict_accept_i          = 1'b0;
        update_valid_i            = 1'b0;
        expected_history          = {
            context_a_history[HISTORY_WIDTH-2:0],
            context_a_actual
        };

        if (predict_history_o !== expected_history) begin
            $display(
                "ERROR: multi-branch rollback expected=%h actual=%h",
                expected_history,
                predict_history_o
            );
            error_count = error_count + 1;
        end

        apply_reset;

        /*
         * Train one base-table index taken, then execute an opposite branch
         * sharing that base index. The second branch allocates a weak tagged
         * provider whose raw prediction is correct while the alternate is
         * wrong. The following update must raise provider usefulness.
         */
        execute_branch(
            32'h0000_0100,
            1'b1,
            branch_prediction,
            branch_provider
        );
        recover_speculative_history({HISTORY_WIDTH{1'b0}});

        execute_branch(
            32'h0000_0100,
            1'b1,
            branch_prediction,
            branch_provider
        );
        recover_speculative_history({HISTORY_WIDTH{1'b0}});

        execute_branch(
            32'h0000_0200,
            1'b0,
            branch_prediction,
            branch_provider
        );

        if ((branch_prediction !== 1'b1) ||
            (branch_provider !== 2'd0)) begin
            $display(
                "ERROR: usefulness setup expected base taken pred=%b provider=%0d",
                branch_prediction,
                branch_provider
            );
            error_count = error_count + 1;
        end

        execute_branch(
            32'h0000_0200,
            1'b0,
            branch_prediction,
            branch_provider
        );

        if ((branch_prediction !== 1'b1) ||
            (branch_provider !== 2'd2)) begin
            $display(
                "ERROR: weak provider did not use alternate pred=%b provider=%0d",
                branch_prediction,
                branch_provider
            );
            error_count = error_count + 1;
        end

        predict_pc_i = 32'h0000_0200;
        #1;

        if ((dut.table2_hit_w !== 1'b1) ||
            (dut.table2_counter_w !== 3'b010) ||
            (dut.table2_predict_useful_w !== 1'b1)) begin
            $display(
                "ERROR: provider training hit=%b counter=%b useful=%b",
                dut.table2_hit_w,
                dut.table2_counter_w,
                dut.table2_predict_useful_w
            );
            error_count = error_count + 1;
        end

        apply_reset;
        check_cold_prediction(32'h0000_0100);

        /*
         * Always-taken branch: after warm-up the predictor must converge.
         * A bimodal provider is sufficient on this simple pattern.
         */
        correct_count         = 0;
        tagged_provider_count = 0;

        iteration = 0;
        while (iteration < 96) begin
            execute_branch(
                32'h0000_0100,
                1'b1,
                branch_prediction,
                branch_provider
            );

            if (iteration >= 64) begin
                if (branch_prediction == 1'b1) begin
                    correct_count = correct_count + 1;
                end

                if (branch_provider != 2'd0) begin
                    tagged_provider_count = tagged_provider_count + 1;
                end
            end

            iteration = iteration + 1;
        end

        if (correct_count < 30) begin
            $display(
                "ERROR: always-taken accuracy %0d/32",
                correct_count
            );
            error_count = error_count + 1;
        end

        /*
         * Always-not-taken verifies the opposite counter saturation path.
         */
        correct_count = 0;

        iteration = 0;
        while (iteration < 48) begin
            execute_branch(
                32'h0000_0180,
                1'b0,
                branch_prediction,
                branch_provider
            );

            if ((iteration >= 24) && (branch_prediction == 1'b0)) begin
                correct_count = correct_count + 1;
            end

            iteration = iteration + 1;
        end

        if (correct_count < 23) begin
            $display(
                "ERROR: always-not-taken accuracy %0d/24",
                correct_count
            );
            error_count = error_count + 1;
        end

        /*
         * Alternating outcome defeats a PC-only bimodal predictor but is
         * learnable from the geometric global histories.
         */
        apply_reset;
        correct_count         = 0;
        tagged_provider_count = 0;

        iteration = 0;
        while (iteration < 256) begin
            branch_outcome = iteration[0];

            execute_branch(
                32'h0000_0200,
                branch_outcome,
                branch_prediction,
                branch_provider
            );

            if ((iteration >= 192) &&
                (branch_prediction == branch_outcome)) begin
                correct_count = correct_count + 1;
            end

            if ((iteration >= 192) && (branch_provider != 2'd0)) begin
                tagged_provider_count = tagged_provider_count + 1;
            end

            iteration = iteration + 1;
        end

        if (correct_count < 56) begin
            $display(
                "ERROR: alternating accuracy %0d/64",
                correct_count
            );
            error_count = error_count + 1;
        end

        if (tagged_provider_count == 0) begin
            $display("ERROR: tagged provider was never selected");
            error_count = error_count + 1;
        end

        /*
         * Opposite branches sharing one base index exercise partial tags.
         */
        apply_reset;
        correct_count = 0;

        iteration = 0;
        while (iteration < 192) begin
            execute_branch(
                32'h0000_0300,
                1'b1,
                branch_prediction,
                branch_provider
            );

            if ((iteration >= 160) && (branch_prediction == 1'b1)) begin
                correct_count = correct_count + 1;
            end

            execute_branch(
                32'h0004_0300,
                1'b0,
                branch_prediction,
                branch_provider
            );

            if ((iteration >= 160) && (branch_prediction == 1'b0)) begin
                correct_count = correct_count + 1;
            end

            iteration = iteration + 1;
        end

        if (correct_count < 60) begin
            $display(
                "ERROR: alias separation accuracy %0d/64",
                correct_count
            );
            error_count = error_count + 1;
        end

        /*
         * ASIC reset invalidates the validity metadata, so all retained table
         * data is logically cold without resetting tag/counter storage.
         */
        apply_reset;
        check_cold_prediction(32'h0000_0300);

        if (error_count == 0) begin
            $display("PASS: compact TAGE predictor regression");
        end else begin
            $display("FAIL: compact TAGE errors=%0d", error_count);
        end

        $finish;
    end

endmodule
