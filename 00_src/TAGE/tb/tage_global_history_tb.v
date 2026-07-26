`timescale 1ns/1ps

module tage_global_history_tb;

    localparam HISTORY_WIDTH = 8;

    reg                      clk_r;
    reg                      rstn_r;

    reg                      committed_predict_accept_r;
    reg                      committed_predict_taken_r;
    reg                      committed_history_recover_valid_r;
    reg  [HISTORY_WIDTH-1:0] committed_history_recover_r;
    reg                      committed_update_valid_r;
    reg                      committed_update_mispredict_r;
    reg                      committed_update_taken_r;
    reg  [HISTORY_WIDTH-1:0] committed_update_history_r;
    wire [HISTORY_WIDTH-1:0] committed_history_w;

    reg                      speculative_predict_accept_r;
    reg                      speculative_predict_taken_r;
    reg                      speculative_history_recover_valid_r;
    reg  [HISTORY_WIDTH-1:0] speculative_history_recover_r;
    reg                      speculative_update_valid_r;
    reg                      speculative_update_mispredict_r;
    reg                      speculative_update_taken_r;
    reg  [HISTORY_WIDTH-1:0] speculative_update_history_r;
    wire [HISTORY_WIDTH-1:0] speculative_history_w;

    integer check_count;
    integer error_count;

    tage_global_history #(
        .HISTORY_WIDTH       (HISTORY_WIDTH),
        .SPECULATIVE_HISTORY (0)
    ) committed_history_inst (
        .clk_i               (clk_r),
        .rstn_i              (rstn_r),
        .predict_accept_i    (committed_predict_accept_r),
        .predict_taken_i     (committed_predict_taken_r),
        .history_recover_valid_i
                             (committed_history_recover_valid_r),
        .history_recover_i   (committed_history_recover_r),
        .update_valid_i      (committed_update_valid_r),
        .update_mispredict_i (committed_update_mispredict_r),
        .update_taken_i      (committed_update_taken_r),
        .update_history_i    (committed_update_history_r),
        .history_o           (committed_history_w)
    );

    tage_global_history #(
        .HISTORY_WIDTH       (HISTORY_WIDTH),
        .SPECULATIVE_HISTORY (1)
    ) speculative_history_inst (
        .clk_i               (clk_r),
        .rstn_i              (rstn_r),
        .predict_accept_i    (speculative_predict_accept_r),
        .predict_taken_i     (speculative_predict_taken_r),
        .history_recover_valid_i
                             (speculative_history_recover_valid_r),
        .history_recover_i   (speculative_history_recover_r),
        .update_valid_i      (speculative_update_valid_r),
        .update_mispredict_i (speculative_update_mispredict_r),
        .update_taken_i      (speculative_update_taken_r),
        .update_history_i    (speculative_update_history_r),
        .history_o           (speculative_history_w)
    );

    always #5 clk_r = ~clk_r;

    task clear_controls;
        begin
            committed_predict_accept_r       = 1'b0;
            committed_predict_taken_r        = 1'b0;
            committed_history_recover_valid_r =
                1'b0;
            committed_history_recover_r       =
                {HISTORY_WIDTH{1'b0}};
            committed_update_valid_r         = 1'b0;
            committed_update_mispredict_r    = 1'b0;
            committed_update_taken_r         = 1'b0;
            committed_update_history_r       = {HISTORY_WIDTH{1'b0}};
            speculative_predict_accept_r     = 1'b0;
            speculative_predict_taken_r      = 1'b0;
            speculative_history_recover_valid_r =
                1'b0;
            speculative_history_recover_r    =
                {HISTORY_WIDTH{1'b0}};
            speculative_update_valid_r       = 1'b0;
            speculative_update_mispredict_r  = 1'b0;
            speculative_update_taken_r       = 1'b0;
            speculative_update_history_r     = {HISTORY_WIDTH{1'b0}};
        end
    endtask

    task run_external_recovery_cycle;
        input [HISTORY_WIDTH-1:0] recover_history;
        input [HISTORY_WIDTH-1:0] expected_history;
        input integer             check_id;
        begin
            @(negedge clk_r);
            speculative_predict_accept_r        = 1'b1;
            speculative_predict_taken_r         = 1'b0;
            speculative_history_recover_valid_r = 1'b1;
            speculative_history_recover_r       = recover_history;
            speculative_update_valid_r          = 1'b1;
            speculative_update_mispredict_r     = 1'b1;
            speculative_update_taken_r          = 1'b1;
            speculative_update_history_r        = 8'h55;

            @(posedge clk_r);
            check_speculative_history(expected_history, check_id);

            @(negedge clk_r);
            speculative_predict_accept_r        = 1'b0;
            speculative_history_recover_valid_r = 1'b0;
            speculative_update_valid_r          = 1'b0;
            speculative_update_mispredict_r     = 1'b0;
        end
    endtask

    task check_committed_history;
        input [HISTORY_WIDTH-1:0] expected_history;
        input integer             check_id;
        begin
            #1;
            check_count = check_count + 1;

            if (committed_history_w !== expected_history) begin
                $display(
                    "ERROR: committed check=%0d expected=%h actual=%h",
                    check_id,
                    expected_history,
                    committed_history_w
                );
                error_count = error_count + 1;
            end
        end
    endtask

    task check_speculative_history;
        input [HISTORY_WIDTH-1:0] expected_history;
        input integer             check_id;
        begin
            #1;
            check_count = check_count + 1;

            if (speculative_history_w !== expected_history) begin
                $display(
                    "ERROR: speculative check=%0d expected=%h actual=%h",
                    check_id,
                    expected_history,
                    speculative_history_w
                );
                error_count = error_count + 1;
            end
        end
    endtask

    task apply_reset;
        begin
            @(negedge clk_r);
            clear_controls();
            rstn_r = 1'b0;

            check_committed_history(8'h00, 1);
            check_speculative_history(8'h00, 2);

            repeat (2) @(posedge clk_r);
            @(negedge clk_r);
            rstn_r = 1'b1;
        end
    endtask

    task run_committed_cycle;
        input                      predict_accept;
        input                      predict_taken;
        input                      update_valid;
        input                      update_mispredict;
        input                      update_taken;
        input  [HISTORY_WIDTH-1:0] update_history;
        input  [HISTORY_WIDTH-1:0] expected_history;
        input integer              check_id;
        begin
            @(negedge clk_r);
            committed_predict_accept_r    = predict_accept;
            committed_predict_taken_r     = predict_taken;
            committed_update_valid_r      = update_valid;
            committed_update_mispredict_r = update_mispredict;
            committed_update_taken_r      = update_taken;
            committed_update_history_r    = update_history;

            @(posedge clk_r);
            check_committed_history(expected_history, check_id);

            @(negedge clk_r);
            committed_predict_accept_r    = 1'b0;
            committed_update_valid_r      = 1'b0;
            committed_update_mispredict_r = 1'b0;
        end
    endtask

    task run_speculative_cycle;
        input                      predict_accept;
        input                      predict_taken;
        input                      update_valid;
        input                      update_mispredict;
        input                      update_taken;
        input  [HISTORY_WIDTH-1:0] update_history;
        input  [HISTORY_WIDTH-1:0] expected_history;
        input integer              check_id;
        begin
            @(negedge clk_r);
            speculative_predict_accept_r    = predict_accept;
            speculative_predict_taken_r     = predict_taken;
            speculative_update_valid_r      = update_valid;
            speculative_update_mispredict_r = update_mispredict;
            speculative_update_taken_r      = update_taken;
            speculative_update_history_r    = update_history;

            @(posedge clk_r);
            check_speculative_history(expected_history, check_id);

            @(negedge clk_r);
            speculative_predict_accept_r    = 1'b0;
            speculative_update_valid_r      = 1'b0;
            speculative_update_mispredict_r = 1'b0;
        end
    endtask

    initial begin
        clk_r         = 1'b0;
        rstn_r        = 1'b1;
        check_count   = 0;
        error_count   = 0;

        clear_controls();
        apply_reset();

        /*
         * Committed mode ignores speculative accepts and shifts only resolved
         * outcomes. update_history_i and update_mispredict_i have no effect.
         */
        run_committed_cycle(
            1'b1,
            1'b1,
            1'b0,
            1'b0,
            1'b0,
            8'h00,
            8'h00,
            3
        );

        run_committed_cycle(
            1'b0,
            1'b0,
            1'b1,
            1'b0,
            1'b1,
            8'h00,
            8'h01,
            4
        );

        run_committed_cycle(
            1'b0,
            1'b0,
            1'b1,
            1'b0,
            1'b0,
            8'h00,
            8'h02,
            5
        );

        run_committed_cycle(
            1'b1,
            1'b0,
            1'b0,
            1'b1,
            1'b1,
            8'h55,
            8'h02,
            6
        );

        run_committed_cycle(
            1'b1,
            1'b0,
            1'b1,
            1'b1,
            1'b1,
            8'h55,
            8'h05,
            7
        );

        apply_reset();

        /*
         * Speculative mode appends every accepted prediction. Rolling back
         * branch A from checkpoint zero must discard younger branches B/C.
         */
        run_speculative_cycle(
            1'b1,
            1'b1,
            1'b0,
            1'b0,
            1'b0,
            8'h00,
            8'h01,
            8
        );

        run_speculative_cycle(
            1'b1,
            1'b0,
            1'b0,
            1'b0,
            1'b0,
            8'h00,
            8'h02,
            9
        );

        run_speculative_cycle(
            1'b1,
            1'b1,
            1'b0,
            1'b0,
            1'b0,
            8'h00,
            8'h05,
            10
        );

        run_speculative_cycle(
            1'b0,
            1'b0,
            1'b1,
            1'b1,
            1'b0,
            8'h00,
            8'h00,
            11
        );

        /*
         * A second multi-outstanding sequence verifies that recovery of B
         * preserves older A, appends B's actual result, and discards C.
         */
        run_speculative_cycle(
            1'b1,
            1'b1,
            1'b0,
            1'b0,
            1'b0,
            8'h00,
            8'h01,
            12
        );

        run_speculative_cycle(
            1'b1,
            1'b0,
            1'b0,
            1'b0,
            1'b0,
            8'h00,
            8'h02,
            13
        );

        run_speculative_cycle(
            1'b1,
            1'b0,
            1'b0,
            1'b0,
            1'b0,
            8'h00,
            8'h04,
            14
        );

        run_speculative_cycle(
            1'b0,
            1'b0,
            1'b1,
            1'b1,
            1'b1,
            8'h01,
            8'h03,
            15
        );

        /*
         * Explicit external recovery has priority over both a simultaneous
         * misprediction recovery and a new prediction accept.
         */
        run_external_recovery_cycle(
            8'hd3,
            8'hd3,
            16
        );

        /*
         * A correctly predicted resolve does not append the outcome twice.
         * A simultaneous accepted prediction still advances the history.
         */
        run_speculative_cycle(
            1'b0,
            1'b0,
            1'b1,
            1'b0,
            1'b1,
            8'h00,
            8'hd3,
            17
        );

        run_speculative_cycle(
            1'b1,
            1'b0,
            1'b1,
            1'b0,
            1'b1,
            8'h00,
            8'ha6,
            18
        );

        apply_reset();

        if (error_count == 0) begin
            $display(
                "PASS: tage_global_history checks=%0d",
                check_count
            );
        end else begin
            $display(
                "FAIL: tage_global_history checks=%0d errors=%0d",
                check_count,
                error_count
            );
        end

        $finish;
    end

endmodule
