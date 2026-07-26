(* use_dsp = "no" *)
module tage_base_table #(
    parameter ENTRY_COUNT         = 64,
    parameter RESET_ON_SOFT_RESET = 0
) (
    input         clk_i,
    input         rstn_i,
    input  [31:0] predict_pc_i,
    output        predict_taken_o,
    output [1:0]  predict_counter_o,
    input         update_valid_i,
    input  [31:0] update_pc_i,
    input         update_taken_i
);

    function integer clog2;
        input integer value;
        integer temporary_value;
        begin
            temporary_value = value - 1;
            for (clog2 = 0; temporary_value > 0; clog2 = clog2 + 1) begin
                temporary_value = temporary_value >> 1;
            end
        end
    endfunction

    localparam INDEX_WIDTH = (ENTRY_COUNT <= 1) ? 1 : clog2(ENTRY_COUNT);

    localparam [1:0] WEAKLY_NOT_TAKEN = 2'b01;

    (* ram_style = "distributed" *)
    reg [1:0] counter_table_q [0:ENTRY_COUNT-1];

    wire [INDEX_WIDTH-1:0] predict_index_w;
    wire [INDEX_WIDTH-1:0] update_index_w;
    wire                   predict_entry_valid_w;
    wire                   update_entry_valid_w;
    wire [1:0]             predict_counter_stored_w;
    wire [1:0]             update_counter_stored_w;
    wire [1:0]             update_counter_current_w;
    wire [1:0]             update_counter_next_w;

    integer entry_index;

    assign predict_index_w          = predict_pc_i[INDEX_WIDTH+1:2];
    assign update_index_w           = update_pc_i[INDEX_WIDTH+1:2];
    assign predict_counter_stored_w = counter_table_q[predict_index_w];
    assign update_counter_stored_w  = counter_table_q[update_index_w];

    assign predict_counter_o = predict_entry_valid_w
                             ? predict_counter_stored_w
                             : WEAKLY_NOT_TAKEN;

    assign update_counter_current_w = update_entry_valid_w
                                    ? update_counter_stored_w
                                    : WEAKLY_NOT_TAKEN;

    assign predict_taken_o = predict_counter_o[1];

    assign update_counter_next_w[1] = update_taken_i
                                    ? (update_counter_current_w[1] |
                                       update_counter_current_w[0])
                                    : (update_counter_current_w[1] &
                                       update_counter_current_w[0]);

    assign update_counter_next_w[0] = update_taken_i
                                    ? (update_counter_current_w[1] |
                                       ~update_counter_current_w[0])
                                    : (update_counter_current_w[1] &
                                       ~update_counter_current_w[0]);

    generate
        if (RESET_ON_SOFT_RESET != 0) begin : generate_soft_reset
            reg [ENTRY_COUNT-1:0] counter_valid_q;

            initial begin
                counter_valid_q = {ENTRY_COUNT{1'b0}};
            end

            always @(posedge clk_i or negedge rstn_i) begin
                if (!rstn_i) begin
                    counter_valid_q <= {ENTRY_COUNT{1'b0}};
                end else if (update_valid_i) begin
                    counter_valid_q[update_index_w] <= 1'b1;
                end
            end

            assign predict_entry_valid_w =
                counter_valid_q[predict_index_w];

            assign update_entry_valid_w =
                counter_valid_q[update_index_w];
        end else begin : generate_retain_history
            assign predict_entry_valid_w = 1'b1;
            assign update_entry_valid_w  = 1'b1;
        end
    endgenerate

    initial begin
        for (entry_index = 0;
             entry_index < ENTRY_COUNT;
             entry_index = entry_index + 1) begin
            counter_table_q[entry_index] = WEAKLY_NOT_TAKEN;
        end
    end

    always @(posedge clk_i) begin
        if (rstn_i && update_valid_i) begin
            counter_table_q[update_index_w] <= update_counter_next_w;
        end
    end

    // synthesis translate_off
    initial begin
        if ((ENTRY_COUNT < 2) ||
            ((ENTRY_COUNT & (ENTRY_COUNT - 1)) != 0) ||
            (INDEX_WIDTH > 30) ||
            ((RESET_ON_SOFT_RESET != 0) &&
             (RESET_ON_SOFT_RESET != 1))) begin
            $display("ERROR: invalid tage_base_table parameter");
            $finish;
        end
    end
    // synthesis translate_on

endmodule
