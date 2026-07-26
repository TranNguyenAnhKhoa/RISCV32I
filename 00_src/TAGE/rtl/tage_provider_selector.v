(* use_dsp = "no" *)
module tage_provider_selector #(
    parameter COUNTER_WIDTH = 3,
    parameter USEFUL_WIDTH  = 1
) (
    input                      base_taken_i,
    input                      table1_hit_i,
    input  [COUNTER_WIDTH-1:0] table1_counter_i,
    input  [USEFUL_WIDTH-1:0]  table1_useful_i,
    input                      table2_hit_i,
    input  [COUNTER_WIDTH-1:0] table2_counter_i,
    input  [USEFUL_WIDTH-1:0]  table2_useful_i,
    input                      table3_hit_i,
    input  [COUNTER_WIDTH-1:0] table3_counter_i,
    input  [USEFUL_WIDTH-1:0]  table3_useful_i,
    output                     predict_taken_o,
    output [1:0]               provider_table_o,
    output                     provider_taken_o,
    output                     alternate_taken_o
);

    localparam [COUNTER_WIDTH-1:0] WEAKLY_NOT_TAKEN = {
        1'b0,
        {COUNTER_WIDTH-1{1'b1}}
    };

    localparam [COUNTER_WIDTH-1:0] WEAKLY_TAKEN = {
        1'b1,
        {COUNTER_WIDTH-1{1'b0}}
    };

    reg                     predict_taken_r;
    reg [1:0]               provider_table_r;
    reg                     provider_taken_r;
    reg                     alternate_taken_r;
    reg [COUNTER_WIDTH-1:0] provider_counter_r;
    reg [USEFUL_WIDTH-1:0]  provider_useful_r;
    reg                     provider_weak_r;

    wire table1_taken_w;
    wire table2_taken_w;
    wire table3_taken_w;

    assign table1_taken_w = table1_counter_i[COUNTER_WIDTH-1];
    assign table2_taken_w = table2_counter_i[COUNTER_WIDTH-1];
    assign table3_taken_w = table3_counter_i[COUNTER_WIDTH-1];

    assign predict_taken_o    = predict_taken_r;
    assign provider_table_o   = provider_table_r;
    assign provider_taken_o   = provider_taken_r;
    assign alternate_taken_o  = alternate_taken_r;

    always @* begin
        provider_table_r   = 2'd0;
        provider_taken_r   = base_taken_i;
        alternate_taken_r  = base_taken_i;
        provider_counter_r = {COUNTER_WIDTH{1'b0}};
        provider_useful_r  = {USEFUL_WIDTH{1'b0}};

        if (table3_hit_i) begin
            provider_table_r   = 2'd3;
            provider_taken_r   = table3_taken_w;
            provider_counter_r = table3_counter_i;
            provider_useful_r  = table3_useful_i;

            if (table2_hit_i) begin
                alternate_taken_r = table2_taken_w;
            end else if (table1_hit_i) begin
                alternate_taken_r = table1_taken_w;
            end
        end else if (table2_hit_i) begin
            provider_table_r   = 2'd2;
            provider_taken_r   = table2_taken_w;
            provider_counter_r = table2_counter_i;
            provider_useful_r  = table2_useful_i;

            if (table1_hit_i) begin
                alternate_taken_r = table1_taken_w;
            end
        end else if (table1_hit_i) begin
            provider_table_r   = 2'd1;
            provider_taken_r   = table1_taken_w;
            provider_counter_r = table1_counter_i;
            provider_useful_r  = table1_useful_i;
        end

        provider_weak_r =
            (provider_counter_r == WEAKLY_NOT_TAKEN) ||
            (provider_counter_r == WEAKLY_TAKEN);

        if ((provider_table_r != 2'd0) &&
            !(|provider_useful_r) &&
            provider_weak_r) begin
            predict_taken_r = alternate_taken_r;
        end else begin
            predict_taken_r = provider_taken_r;
        end
    end

    // synthesis translate_off
    initial begin
        if ((COUNTER_WIDTH < 2) || (USEFUL_WIDTH < 1)) begin
            $display("ERROR: invalid tage_provider_selector parameter");
            $finish;
        end
    end
    // synthesis translate_on

endmodule
