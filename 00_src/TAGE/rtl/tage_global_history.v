module tage_global_history #(
    parameter HISTORY_WIDTH = 32,
    parameter SPECULATIVE_HISTORY = 0
) (
    input clk_i,
    input rstn_i,
    input predict_accept_i,
    input predict_taken_i,
    input history_recover_valid_i,
    input [HISTORY_WIDTH-1:0] history_recover_i,
    input update_valid_i,
    input update_mispredict_i,
    input update_taken_i,
    input [HISTORY_WIDTH-1:0] update_history_i,
    output [HISTORY_WIDTH-1:0] history_o
);

    reg [HISTORY_WIDTH-1:0] history_q;

    assign history_o = history_q;

    generate
        if (SPECULATIVE_HISTORY != 0) begin : generate_speculative_history
            always @(posedge clk_i or negedge rstn_i) begin
                if (!rstn_i) begin
                    history_q <= {HISTORY_WIDTH{1'b0}};
                end else if (history_recover_valid_i) begin
                    history_q <= history_recover_i;
                end else if (update_valid_i && update_mispredict_i) begin
                    history_q <= {
                        update_history_i[HISTORY_WIDTH-2:0],
                        update_taken_i
                    };
                end else if (predict_accept_i) begin
                    history_q <= {
                        history_q[HISTORY_WIDTH-2:0],
                        predict_taken_i
                    };
                end
            end
        end else begin : generate_committed_history
            always @(posedge clk_i or negedge rstn_i) begin
                if (!rstn_i) begin
                    history_q <= {HISTORY_WIDTH{1'b0}};
                end else if (update_valid_i) begin
                    history_q <= {
                        history_q[HISTORY_WIDTH-2:0],
                        update_taken_i
                    };
                end
            end
        end
    endgenerate

endmodule
