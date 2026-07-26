(* use_dsp = "no" *)
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
    localparam VALID_BIT = USEFUL_WIDTH + COUNTER_WIDTH + TAG_WIDTH;
    localparam ENTRY_WIDTH = VALID_BIT + 1;

    localparam [COUNTER_WIDTH-1:0] WEAKLY_NOT_TAKEN = {
        1'b0,
        {COUNTER_WIDTH-1{1'b1}}
    };

    localparam [COUNTER_WIDTH-1:0] WEAKLY_TAKEN = {
        1'b1,
        {COUNTER_WIDTH-1{1'b0}}
    };

    (* ram_style = "distributed" *)
    reg [ENTRY_WIDTH-1:0] entry_table_q [0:ENTRY_COUNT-1];

    wire [ENTRY_WIDTH-1:0] predict_entry_w;
    wire [ENTRY_WIDTH-1:0] update_entry_w;
    wire                   predict_reset_valid_w;
    wire                   update_reset_valid_w;
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

    integer entry_index;

    function [COUNTER_WIDTH-1:0] update_counter;
        input [COUNTER_WIDTH-1:0] current_value;
        input                     taken_value;
        begin
            if (taken_value) begin
                if (&current_value) begin
                    update_counter = current_value;
                end else begin
                    update_counter = current_value + 1'b1;
                end
            end else begin
                if (!(|current_value)) begin
                    update_counter = current_value;
                end else begin
                    update_counter = current_value - 1'b1;
                end
            end
        end
    endfunction

    function [USEFUL_WIDTH-1:0] update_useful;
        input [USEFUL_WIDTH-1:0] current_value;
        input                    increment_value;
        begin
            if (increment_value) begin
                if (&current_value) begin
                    update_useful = current_value;
                end else begin
                    update_useful = current_value + 1'b1;
                end
            end else begin
                if (!(|current_value)) begin
                    update_useful = current_value;
                end else begin
                    update_useful = current_value - 1'b1;
                end
            end
        end
    endfunction

    assign predict_entry_w = entry_table_q[predict_index_i];
    assign update_entry_w  = entry_table_q[update_index_i];

    assign predict_entry_active_w =
        predict_reset_valid_w && predict_entry_w[VALID_BIT];

    assign update_entry_active_w =
        update_reset_valid_w && update_entry_w[VALID_BIT];

    assign predict_hit_o = predict_entry_active_w &&
                           (predict_entry_w[TAG_MSB:TAG_LSB] ==
                            predict_tag_i);

    assign predict_counter_o =
        predict_entry_w[COUNTER_MSB:COUNTER_LSB];

    assign predict_useful_o = predict_entry_active_w
                            ? predict_entry_w[USEFUL_MSB:USEFUL_LSB]
                            : {USEFUL_WIDTH{1'b0}};

    assign update_useful_o = update_entry_active_w
                           ? update_entry_w[USEFUL_MSB:USEFUL_LSB]
                           : {USEFUL_WIDTH{1'b0}};

    assign update_tag_match_w =
        update_entry_active_w &&
        (update_entry_w[TAG_MSB:TAG_LSB] == update_tag_i);

    assign update_hit_o = update_tag_match_w;

    assign update_counter_w =
        update_entry_w[COUNTER_MSB:COUNTER_LSB];

    assign update_useful_w =
        update_entry_w[USEFUL_MSB:USEFUL_LSB];

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
            table_write_data_r[VALID_BIT] = 1'b1;
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

    generate
        if (RESET_ON_SOFT_RESET != 0) begin : generate_soft_reset
            reg [ENTRY_COUNT-1:0] entry_reset_valid_q;

            initial begin
                entry_reset_valid_q = {ENTRY_COUNT{1'b0}};
            end

            always @(posedge clk_i or negedge rstn_i) begin
                if (!rstn_i) begin
                    entry_reset_valid_q <= {ENTRY_COUNT{1'b0}};
                end else if (allocate_valid_i) begin
                    entry_reset_valid_q[update_index_i] <= 1'b1;
                end
            end

            assign predict_reset_valid_w =
                entry_reset_valid_q[predict_index_i];

            assign update_reset_valid_w =
                entry_reset_valid_q[update_index_i];
        end else begin : generate_retain_history
            assign predict_reset_valid_w = 1'b1;
            assign update_reset_valid_w  = 1'b1;
        end
    endgenerate

    initial begin
        for (entry_index = 0;
             entry_index < ENTRY_COUNT;
             entry_index = entry_index + 1) begin
            entry_table_q[entry_index] = {ENTRY_WIDTH{1'b0}};
        end
    end

    always @(posedge clk_i) begin
        if (table_write_valid_w) begin
            entry_table_q[update_index_i] <= table_write_data_r;
        end
    end

    // synthesis translate_off
    initial begin
        if ((ENTRY_COUNT < 2) ||
            ((ENTRY_COUNT & (ENTRY_COUNT - 1)) != 0) ||
            ((1 << INDEX_WIDTH) != ENTRY_COUNT) ||
            (TAG_WIDTH < 2) ||
            (COUNTER_WIDTH < 2) ||
            (USEFUL_WIDTH < 1) ||
            ((RESET_ON_SOFT_RESET != 0) &&
             (RESET_ON_SOFT_RESET != 1))) begin
            $display("ERROR: invalid tage_tagged_table parameter");
            $finish;
        end
    end
    // synthesis translate_on

endmodule
