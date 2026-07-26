(* use_dsp = "no" *)
module tage_predictor #(
    parameter BASE_ENTRY_COUNT      = 64,
    parameter TAGGED_ENTRY_COUNT    = 32,
    parameter TAGGED_INDEX_WIDTH    = 5,
    parameter TABLE1_TAG_WIDTH      = 6,
    parameter TABLE2_TAG_WIDTH      = 7,
    parameter TABLE3_TAG_WIDTH      = 8,
    parameter COUNTER_WIDTH         = 3,
    parameter USEFUL_WIDTH          = 1,
    parameter HISTORY_WIDTH         = 32,
    parameter TABLE1_HISTORY_LENGTH = 4,
    parameter TABLE2_HISTORY_LENGTH = 12,
    parameter TABLE3_HISTORY_LENGTH = 32,
    parameter RESET_ON_SOFT_RESET   = 0,
    parameter SPECULATIVE_HISTORY   = 0
) (
    input                                             clk_i,
    input                                             rstn_i,
    input                                             predict_accept_i,
    input  [31:0]                                     predict_pc_i,
    input                                             history_recover_valid_i,
    input  [HISTORY_WIDTH-1:0]                        history_recover_i,
    output                                            predict_taken_o,
    output [1:0]                                      predict_provider_table_o,
    output                                            predict_provider_taken_o,
    output                                            predict_alternate_taken_o,
    output [(3*TAGGED_INDEX_WIDTH)-1:0]               predict_indices_o,
    output [(TABLE1_TAG_WIDTH+TABLE2_TAG_WIDTH+TABLE3_TAG_WIDTH)-1:0] predict_tags_o,
    output [HISTORY_WIDTH-1:0]                        predict_history_o,
    input                                             update_valid_i,
    input  [31:0]                                     update_pc_i,
    input                                             update_taken_i,
    input                                             update_prediction_i,
    input  [1:0]                                      update_provider_table_i,
    input                                             update_provider_taken_i,
    input                                             update_alternate_taken_i,
    input  [(3*TAGGED_INDEX_WIDTH)-1:0]               update_indices_i,
    input  [(TABLE1_TAG_WIDTH+TABLE2_TAG_WIDTH+TABLE3_TAG_WIDTH)-1:0] update_tags_i,
    input  [HISTORY_WIDTH-1:0]                        update_history_i
);

    wire [HISTORY_WIDTH-1:0] global_history_w;
    wire                     update_mispredict_w;

    wire                     base_taken_w;
    wire [1:0]               base_counter_w;

    wire [TAGGED_INDEX_WIDTH-1:0] predict_index1_w;
    wire [TAGGED_INDEX_WIDTH-1:0] predict_index2_w;
    wire [TAGGED_INDEX_WIDTH-1:0] predict_index3_w;
    wire [TABLE1_TAG_WIDTH-1:0]   predict_tag1_w;
    wire [TABLE2_TAG_WIDTH-1:0]   predict_tag2_w;
    wire [TABLE3_TAG_WIDTH-1:0]   predict_tag3_w;

    wire [TAGGED_INDEX_WIDTH-1:0] update_index1_w;
    wire [TAGGED_INDEX_WIDTH-1:0] update_index2_w;
    wire [TAGGED_INDEX_WIDTH-1:0] update_index3_w;
    wire [TABLE1_TAG_WIDTH-1:0]   update_tag1_w;
    wire [TABLE2_TAG_WIDTH-1:0]   update_tag2_w;
    wire [TABLE3_TAG_WIDTH-1:0]   update_tag3_w;

    wire                     table1_hit_w;
    wire                     table2_hit_w;
    wire                     table3_hit_w;
    wire [COUNTER_WIDTH-1:0] table1_counter_w;
    wire [COUNTER_WIDTH-1:0] table2_counter_w;
    wire [COUNTER_WIDTH-1:0] table3_counter_w;
    wire [USEFUL_WIDTH-1:0]  table1_predict_useful_w;
    wire [USEFUL_WIDTH-1:0]  table2_predict_useful_w;
    wire [USEFUL_WIDTH-1:0]  table3_predict_useful_w;
    wire [USEFUL_WIDTH-1:0]  table1_update_useful_w;
    wire [USEFUL_WIDTH-1:0]  table2_update_useful_w;
    wire [USEFUL_WIDTH-1:0]  table3_update_useful_w;
    wire                     table1_update_hit_w;
    wire                     table2_update_hit_w;
    wire                     table3_update_hit_w;

    wire table1_allocation_eligible_w;
    wire table2_allocation_eligible_w;
    wire table3_allocation_eligible_w;
    wire table1_train_valid_w;
    wire table2_train_valid_w;
    wire table3_train_valid_w;
    wire table1_allocate_valid_w;
    wire table2_allocate_valid_w;
    wire table3_allocate_valid_w;
    wire table1_age_valid_w;
    wire table2_age_valid_w;
    wire table3_age_valid_w;
    wire train_useful_valid_w;
    wire train_useful_increment_w;

    reg [1:0] allocation_round_robin_q;
    reg [1:0] allocation_table_r;

    assign update_mispredict_w =
        update_valid_i && (update_prediction_i != update_taken_i);

    assign predict_indices_o = {
        predict_index3_w,
        predict_index2_w,
        predict_index1_w
    };

    assign predict_tags_o = {
        predict_tag3_w,
        predict_tag2_w,
        predict_tag1_w
    };

    assign predict_history_o = global_history_w;

    assign update_index1_w =
        update_indices_i[TAGGED_INDEX_WIDTH-1:0];

    assign update_index2_w =
        update_indices_i[(2*TAGGED_INDEX_WIDTH)-1:
                         TAGGED_INDEX_WIDTH];

    assign update_index3_w =
        update_indices_i[(3*TAGGED_INDEX_WIDTH)-1:
                         (2*TAGGED_INDEX_WIDTH)];

    assign update_tag1_w =
        update_tags_i[TABLE1_TAG_WIDTH-1:0];

    assign update_tag2_w =
        update_tags_i[(TABLE1_TAG_WIDTH+TABLE2_TAG_WIDTH)-1:
                      TABLE1_TAG_WIDTH];

    assign update_tag3_w =
        update_tags_i[(TABLE1_TAG_WIDTH+
                       TABLE2_TAG_WIDTH+
                       TABLE3_TAG_WIDTH)-1:
                      (TABLE1_TAG_WIDTH+TABLE2_TAG_WIDTH)];

    assign train_useful_valid_w =
        update_provider_taken_i != update_alternate_taken_i;

    assign train_useful_increment_w =
        update_provider_taken_i == update_taken_i;

    assign table1_train_valid_w =
        update_valid_i && (update_provider_table_i == 2'd1);

    assign table2_train_valid_w =
        update_valid_i && (update_provider_table_i == 2'd2);

    assign table3_train_valid_w =
        update_valid_i && (update_provider_table_i == 2'd3);

    assign table1_allocation_eligible_w =
        (update_provider_table_i < 2'd1) &&
        !table1_update_hit_w &&
        !(|table1_update_useful_w);

    assign table2_allocation_eligible_w =
        (update_provider_table_i < 2'd2) &&
        !table2_update_hit_w &&
        !(|table2_update_useful_w);

    assign table3_allocation_eligible_w =
        (update_provider_table_i < 2'd3) &&
        !table3_update_hit_w &&
        !(|table3_update_useful_w);

    always @* begin
        allocation_table_r = 2'd0;

        case (allocation_round_robin_q)
            2'd0: begin
                if (table1_allocation_eligible_w) begin
                    allocation_table_r = 2'd1;
                end else if (table2_allocation_eligible_w) begin
                    allocation_table_r = 2'd2;
                end else if (table3_allocation_eligible_w) begin
                    allocation_table_r = 2'd3;
                end
            end

            2'd1: begin
                if (table2_allocation_eligible_w) begin
                    allocation_table_r = 2'd2;
                end else if (table3_allocation_eligible_w) begin
                    allocation_table_r = 2'd3;
                end else if (table1_allocation_eligible_w) begin
                    allocation_table_r = 2'd1;
                end
            end

            2'd2: begin
                if (table3_allocation_eligible_w) begin
                    allocation_table_r = 2'd3;
                end else if (table1_allocation_eligible_w) begin
                    allocation_table_r = 2'd1;
                end else if (table2_allocation_eligible_w) begin
                    allocation_table_r = 2'd2;
                end
            end

            default: begin
                if (table1_allocation_eligible_w) begin
                    allocation_table_r = 2'd1;
                end else if (table3_allocation_eligible_w) begin
                    allocation_table_r = 2'd3;
                end else if (table2_allocation_eligible_w) begin
                    allocation_table_r = 2'd2;
                end
            end
        endcase
    end

    assign table1_allocate_valid_w =
        update_mispredict_w && (allocation_table_r == 2'd1);

    assign table2_allocate_valid_w =
        update_mispredict_w && (allocation_table_r == 2'd2);

    assign table3_allocate_valid_w =
        update_mispredict_w && (allocation_table_r == 2'd3);

    assign table1_age_valid_w =
        update_mispredict_w &&
        (allocation_table_r == 2'd0) &&
        (update_provider_table_i < 2'd1) &&
        !table1_update_hit_w;

    assign table2_age_valid_w =
        update_mispredict_w &&
        (allocation_table_r == 2'd0) &&
        (update_provider_table_i < 2'd2) &&
        !table2_update_hit_w;

    assign table3_age_valid_w =
        update_mispredict_w &&
        (allocation_table_r == 2'd0) &&
        (update_provider_table_i < 2'd3) &&
        !table3_update_hit_w;

    initial begin
        allocation_round_robin_q = 2'd0;
    end

    always @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            allocation_round_robin_q <= 2'd0;
        end else if (update_mispredict_w) begin
            allocation_round_robin_q[0] <=
                ~allocation_round_robin_q[0];

            allocation_round_robin_q[1] <=
                allocation_round_robin_q[1] ^
                allocation_round_robin_q[0];
        end
    end

    tage_global_history #(
        .HISTORY_WIDTH       (HISTORY_WIDTH),
        .SPECULATIVE_HISTORY (SPECULATIVE_HISTORY)
    ) global_history_inst (
        .clk_i               (clk_i),
        .rstn_i              (rstn_i),
        .predict_accept_i    (predict_accept_i),
        .predict_taken_i     (predict_taken_o),
        .history_recover_valid_i (history_recover_valid_i),
        .history_recover_i       (history_recover_i),
        .update_valid_i      (update_valid_i),
        .update_mispredict_i (update_mispredict_w),
        .update_taken_i      (update_taken_i),
        .update_history_i    (update_history_i),
        .history_o           (global_history_w)
    );

    tage_hash #(
        .INDEX_WIDTH    (TAGGED_INDEX_WIDTH),
        .TAG_WIDTH      (TABLE1_TAG_WIDTH),
        .HISTORY_WIDTH  (HISTORY_WIDTH),
        .HISTORY_LENGTH (TABLE1_HISTORY_LENGTH),
        .TABLE_ID       (1)
    ) table1_hash_inst (
        .pc_i      (predict_pc_i),
        .history_i (global_history_w),
        .index_o   (predict_index1_w),
        .tag_o     (predict_tag1_w)
    );

    tage_hash #(
        .INDEX_WIDTH    (TAGGED_INDEX_WIDTH),
        .TAG_WIDTH      (TABLE2_TAG_WIDTH),
        .HISTORY_WIDTH  (HISTORY_WIDTH),
        .HISTORY_LENGTH (TABLE2_HISTORY_LENGTH),
        .TABLE_ID       (2)
    ) table2_hash_inst (
        .pc_i      (predict_pc_i),
        .history_i (global_history_w),
        .index_o   (predict_index2_w),
        .tag_o     (predict_tag2_w)
    );

    tage_hash #(
        .INDEX_WIDTH    (TAGGED_INDEX_WIDTH),
        .TAG_WIDTH      (TABLE3_TAG_WIDTH),
        .HISTORY_WIDTH  (HISTORY_WIDTH),
        .HISTORY_LENGTH (TABLE3_HISTORY_LENGTH),
        .TABLE_ID       (3)
    ) table3_hash_inst (
        .pc_i      (predict_pc_i),
        .history_i (global_history_w),
        .index_o   (predict_index3_w),
        .tag_o     (predict_tag3_w)
    );

    tage_base_table #(
        .ENTRY_COUNT         (BASE_ENTRY_COUNT),
        .RESET_ON_SOFT_RESET (RESET_ON_SOFT_RESET)
    ) base_table_inst (
        .clk_i             (clk_i),
        .rstn_i            (rstn_i),
        .predict_pc_i      (predict_pc_i),
        .predict_taken_o   (base_taken_w),
        .predict_counter_o (base_counter_w),
        .update_valid_i    (update_valid_i),
        .update_pc_i       (update_pc_i),
        .update_taken_i    (update_taken_i)
    );

    tage_tagged_table #(
        .ENTRY_COUNT         (TAGGED_ENTRY_COUNT),
        .INDEX_WIDTH         (TAGGED_INDEX_WIDTH),
        .TAG_WIDTH           (TABLE1_TAG_WIDTH),
        .COUNTER_WIDTH       (COUNTER_WIDTH),
        .USEFUL_WIDTH        (USEFUL_WIDTH),
        .RESET_ON_SOFT_RESET (RESET_ON_SOFT_RESET)
    ) table1_inst (
        .clk_i                    (clk_i),
        .rstn_i                   (rstn_i),
        .predict_index_i          (predict_index1_w),
        .predict_tag_i            (predict_tag1_w),
        .predict_hit_o            (table1_hit_w),
        .predict_counter_o        (table1_counter_w),
        .predict_useful_o         (table1_predict_useful_w),
        .update_index_i           (update_index1_w),
        .update_tag_i             (update_tag1_w),
        .update_hit_o              (table1_update_hit_w),
        .update_useful_o          (table1_update_useful_w),
        .train_valid_i            (table1_train_valid_w),
        .train_taken_i            (update_taken_i),
        .train_useful_valid_i     (train_useful_valid_w),
        .train_useful_increment_i (train_useful_increment_w),
        .allocate_valid_i         (table1_allocate_valid_w),
        .allocate_taken_i         (update_taken_i),
        .age_valid_i              (table1_age_valid_w)
    );

    tage_tagged_table #(
        .ENTRY_COUNT         (TAGGED_ENTRY_COUNT),
        .INDEX_WIDTH         (TAGGED_INDEX_WIDTH),
        .TAG_WIDTH           (TABLE2_TAG_WIDTH),
        .COUNTER_WIDTH       (COUNTER_WIDTH),
        .USEFUL_WIDTH        (USEFUL_WIDTH),
        .RESET_ON_SOFT_RESET (RESET_ON_SOFT_RESET)
    ) table2_inst (
        .clk_i                    (clk_i),
        .rstn_i                   (rstn_i),
        .predict_index_i          (predict_index2_w),
        .predict_tag_i            (predict_tag2_w),
        .predict_hit_o            (table2_hit_w),
        .predict_counter_o        (table2_counter_w),
        .predict_useful_o         (table2_predict_useful_w),
        .update_index_i           (update_index2_w),
        .update_tag_i             (update_tag2_w),
        .update_hit_o              (table2_update_hit_w),
        .update_useful_o          (table2_update_useful_w),
        .train_valid_i            (table2_train_valid_w),
        .train_taken_i            (update_taken_i),
        .train_useful_valid_i     (train_useful_valid_w),
        .train_useful_increment_i (train_useful_increment_w),
        .allocate_valid_i         (table2_allocate_valid_w),
        .allocate_taken_i         (update_taken_i),
        .age_valid_i              (table2_age_valid_w)
    );

    tage_tagged_table #(
        .ENTRY_COUNT         (TAGGED_ENTRY_COUNT),
        .INDEX_WIDTH         (TAGGED_INDEX_WIDTH),
        .TAG_WIDTH           (TABLE3_TAG_WIDTH),
        .COUNTER_WIDTH       (COUNTER_WIDTH),
        .USEFUL_WIDTH        (USEFUL_WIDTH),
        .RESET_ON_SOFT_RESET (RESET_ON_SOFT_RESET)
    ) table3_inst (
        .clk_i                    (clk_i),
        .rstn_i                   (rstn_i),
        .predict_index_i          (predict_index3_w),
        .predict_tag_i            (predict_tag3_w),
        .predict_hit_o            (table3_hit_w),
        .predict_counter_o        (table3_counter_w),
        .predict_useful_o         (table3_predict_useful_w),
        .update_index_i           (update_index3_w),
        .update_tag_i             (update_tag3_w),
        .update_hit_o              (table3_update_hit_w),
        .update_useful_o          (table3_update_useful_w),
        .train_valid_i            (table3_train_valid_w),
        .train_taken_i            (update_taken_i),
        .train_useful_valid_i     (train_useful_valid_w),
        .train_useful_increment_i (train_useful_increment_w),
        .allocate_valid_i         (table3_allocate_valid_w),
        .allocate_taken_i         (update_taken_i),
        .age_valid_i              (table3_age_valid_w)
    );

    tage_provider_selector #(
        .COUNTER_WIDTH (COUNTER_WIDTH),
        .USEFUL_WIDTH  (USEFUL_WIDTH)
    ) provider_selector_inst (
        .base_taken_i          (base_taken_w),
        .table1_hit_i          (table1_hit_w),
        .table1_counter_i      (table1_counter_w),
        .table1_useful_i       (table1_predict_useful_w),
        .table2_hit_i          (table2_hit_w),
        .table2_counter_i      (table2_counter_w),
        .table2_useful_i       (table2_predict_useful_w),
        .table3_hit_i          (table3_hit_w),
        .table3_counter_i      (table3_counter_w),
        .table3_useful_i       (table3_predict_useful_w),
        .predict_taken_o       (predict_taken_o),
        .provider_table_o      (predict_provider_table_o),
        .provider_taken_o      (predict_provider_taken_o),
        .alternate_taken_o     (predict_alternate_taken_o)
    );

    // synthesis translate_off
    initial begin
        if ((BASE_ENTRY_COUNT < 2) ||
            ((BASE_ENTRY_COUNT & (BASE_ENTRY_COUNT - 1)) != 0) ||
            (TAGGED_ENTRY_COUNT < 2) ||
            ((TAGGED_ENTRY_COUNT & (TAGGED_ENTRY_COUNT - 1)) != 0) ||
            ((1 << TAGGED_INDEX_WIDTH) != TAGGED_ENTRY_COUNT) ||
            (TABLE1_TAG_WIDTH < 2) ||
            (TABLE2_TAG_WIDTH < 2) ||
            (TABLE3_TAG_WIDTH < 2) ||
            (COUNTER_WIDTH < 2) ||
            (USEFUL_WIDTH < 1) ||
            (TABLE1_HISTORY_LENGTH < 1) ||
            (TABLE1_HISTORY_LENGTH >= TABLE2_HISTORY_LENGTH) ||
            (TABLE2_HISTORY_LENGTH >= TABLE3_HISTORY_LENGTH) ||
            (TABLE3_HISTORY_LENGTH > HISTORY_WIDTH) ||
            ((RESET_ON_SOFT_RESET != 0) &&
             (RESET_ON_SOFT_RESET != 1)) ||
            ((SPECULATIVE_HISTORY != 0) &&
             (SPECULATIVE_HISTORY != 1))) begin
            $display("ERROR: invalid tage_predictor parameter");
            $finish;
        end
    end
    // synthesis translate_on

endmodule
