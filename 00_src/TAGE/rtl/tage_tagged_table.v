module tage_tagged_table #(
    parameter ENTRY_COUNT         = 32,
    parameter INDEX_WIDTH         = 5,
    parameter TAG_WIDTH           = 6,
    parameter COUNTER_WIDTH       = 3,
    parameter USEFUL_WIDTH        = 1,
    parameter RESET_ON_SOFT_RESET = 0
) (
    input                      clk_i,
    input                      rstn_i,
    input  [INDEX_WIDTH-1:0]   predict_index_i,
    input  [TAG_WIDTH-1:0]     predict_tag_i,
    output                     predict_hit_o,
    output [COUNTER_WIDTH-1:0] predict_counter_o,
    output [USEFUL_WIDTH-1:0]  predict_useful_o,
    input  [INDEX_WIDTH-1:0]   update_index_i,
    input  [TAG_WIDTH-1:0]     update_tag_i,
    output                     update_hit_o,
    output [USEFUL_WIDTH-1:0]  update_useful_o,
    input                      train_valid_i,
    input                      train_taken_i,
    input                      train_useful_valid_i,
    input                      train_useful_increment_i,
    input                      allocate_valid_i,
    input                      allocate_taken_i,
    input                      age_valid_i
);

    localparam USEFUL_LSB = 0;
    localparam USEFUL_MSB = USEFUL_WIDTH - 1;
    localparam COUNTER_LSB = USEFUL_WIDTH;
    localparam COUNTER_MSB = USEFUL_WIDTH + COUNTER_WIDTH - 1;
    localparam TAG_LSB = USEFUL_WIDTH + COUNTER_WIDTH;
    localparam TAG_MSB = USEFUL_WIDTH + COUNTER_WIDTH + TAG_WIDTH - 1;
    localparam ENTRY_WIDTH = USEFUL_WIDTH + COUNTER_WIDTH + TAG_WIDTH;

    localparam [COUNTER_WIDTH-1:0] WEAKLY_NOT_TAKEN = {
        1'b0,
        {COUNTER_WIDTH-1{1'b1}}
    };

    localparam [COUNTER_WIDTH-1:0] WEAKLY_TAKEN = {
        1'b1,
        {COUNTER_WIDTH-1{1'b0}}
    };

    /*
     * Tag, prediction counter and usefulness storage are intentionally not
     * reset. entry_valid_q is the only resettable metadata plane.
     */
    reg [ENTRY_WIDTH-1:0] entry_table_q [0:ENTRY_COUNT-1];
    reg [ENTRY_COUNT-1:0] entry_valid_q;

    wire [ENTRY_WIDTH-1:0] predict_entry_w;
    wire [ENTRY_WIDTH-1:0] update_entry_w;
    wire                   predict_entry_active_w;
    wire                   update_entry_active_w;
    wire                   update_tag_match_w;
    wire                   train_write_valid_w;
    wire                   age_write_valid_w;
    wire                   table_write_valid_w;
    wire [COUNTER_WIDTH-1:0] update_counter_w;
    wire [COUNTER_WIDTH-1:0] trained_counter_w;
    wire [USEFUL_WIDTH-1:0] update_useful_w;
    wire [USEFUL_WIDTH-1:0] trained_useful_w;

    reg [ENTRY_WIDTH-1:0] table_write_data_r;

    function [COUNTER_WIDTH-1:0] update_counter;
        input [COUNTER_WIDTH-1:0] current_value_i;
        input                     taken_value_i;
        begin
            if (taken_value_i) begin
                if (&current_value_i) begin
                    update_counter = current_value_i;
                end else begin
                    update_counter = current_value_i + 1'b1;
                end
            end else begin
                if (!(|current_value_i)) begin
                    update_counter = current_value_i;
                end else begin
                    update_counter = current_value_i - 1'b1;
                end
            end
        end
    endfunction

    function [USEFUL_WIDTH-1:0] update_useful;
        input [USEFUL_WIDTH-1:0] current_value_i;
        input                    increment_value_i;
        begin
            if (increment_value_i) begin
                if (&current_value_i) begin
                    update_useful = current_value_i;
                end else begin
                    update_useful = current_value_i + 1'b1;
                end
            end else begin
                if (!(|current_value_i)) begin
                    update_useful = current_value_i;
                end else begin
                    update_useful = current_value_i - 1'b1;
                end
            end
        end
    endfunction

    assign predict_entry_w        = entry_table_q[predict_index_i];
    assign update_entry_w         = entry_table_q[update_index_i];
    assign predict_entry_active_w = entry_valid_q[predict_index_i];
    assign update_entry_active_w  = entry_valid_q[update_index_i];

    assign predict_hit_o = predict_entry_active_w &&
                           (predict_entry_w[TAG_MSB:TAG_LSB] ==
                            predict_tag_i);

    assign predict_counter_o =
        predict_entry_active_w
        ? predict_entry_w[COUNTER_MSB:COUNTER_LSB]
        : WEAKLY_NOT_TAKEN;

    assign predict_useful_o =
        predict_entry_active_w
        ? predict_entry_w[USEFUL_MSB:USEFUL_LSB]
        : {USEFUL_WIDTH{1'b0}};

    assign update_useful_o =
        update_entry_active_w
        ? update_entry_w[USEFUL_MSB:USEFUL_LSB]
        : {USEFUL_WIDTH{1'b0}};

    assign update_tag_match_w =
        update_entry_active_w &&
        (update_entry_w[TAG_MSB:TAG_LSB] == update_tag_i);

    assign update_hit_o = update_tag_match_w;

    assign update_counter_w =
        update_entry_active_w
        ? update_entry_w[COUNTER_MSB:COUNTER_LSB]
        : WEAKLY_NOT_TAKEN;

    assign update_useful_w =
        update_entry_active_w
        ? update_entry_w[USEFUL_MSB:USEFUL_LSB]
        : {USEFUL_WIDTH{1'b0}};

    assign trained_counter_w =
        update_counter(update_counter_w, train_taken_i);

    assign trained_useful_w =
        update_useful(update_useful_w, train_useful_increment_i);

    assign train_write_valid_w = train_valid_i && update_tag_match_w;

    assign age_write_valid_w = age_valid_i &&
                               update_entry_active_w &&
                               (|update_useful_w);

    assign table_write_valid_w = rstn_i &&
                                 (allocate_valid_i ||
                                  train_write_valid_w ||
                                  age_write_valid_w);

    always @* begin
        table_write_data_r = update_entry_w;

        if (allocate_valid_i) begin
            table_write_data_r = {ENTRY_WIDTH{1'b0}};
            table_write_data_r[TAG_MSB:TAG_LSB] = update_tag_i;
            table_write_data_r[COUNTER_MSB:COUNTER_LSB] =
                allocate_taken_i
                ? WEAKLY_TAKEN
                : WEAKLY_NOT_TAKEN;
            table_write_data_r[USEFUL_MSB:USEFUL_LSB] =
                {USEFUL_WIDTH{1'b0}};
        end else if (train_write_valid_w) begin
            table_write_data_r[COUNTER_MSB:COUNTER_LSB] =
                trained_counter_w;

            if (train_useful_valid_i) begin
                table_write_data_r[USEFUL_MSB:USEFUL_LSB] =
                    trained_useful_w;
            end
        end else if (age_write_valid_w) begin
            table_write_data_r[USEFUL_MSB:USEFUL_LSB] =
                update_useful_w >> 1;
        end
    end

    /*
     * RESET_ON_SOFT_RESET is kept to preserve source compatibility. This ASIC
     * implementation both parameter values invalidate all metadata whenever
     * rstn_i is low; tag/counter/usefulness storage is never reset.
     */
    always @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            entry_valid_q <= {ENTRY_COUNT{1'b0}};
        end else if (allocate_valid_i) begin
            entry_valid_q[update_index_i] <= 1'b1;
        end
    end

    always @(posedge clk_i) begin
        if (table_write_valid_w) begin
            entry_table_q[update_index_i] <= table_write_data_r;
        end
    end

endmodule
