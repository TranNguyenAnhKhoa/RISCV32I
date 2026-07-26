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

    /*
     * Constant elaboration helper without procedural loops. ENTRY_COUNT must
     * remain a power of two. The range matches the former 30-bit index guard.
     */
    function integer clog2;
        input integer value_i;
        begin
            if      (value_i <= 2)          clog2 = 1;
            else if (value_i <= 4)          clog2 = 2;
            else if (value_i <= 8)          clog2 = 3;
            else if (value_i <= 16)         clog2 = 4;
            else if (value_i <= 32)         clog2 = 5;
            else if (value_i <= 64)         clog2 = 6;
            else if (value_i <= 128)        clog2 = 7;
            else if (value_i <= 256)        clog2 = 8;
            else if (value_i <= 512)        clog2 = 9;
            else if (value_i <= 1024)       clog2 = 10;
            else if (value_i <= 2048)       clog2 = 11;
            else if (value_i <= 4096)       clog2 = 12;
            else if (value_i <= 8192)       clog2 = 13;
            else if (value_i <= 16384)      clog2 = 14;
            else if (value_i <= 32768)      clog2 = 15;
            else if (value_i <= 65536)      clog2 = 16;
            else if (value_i <= 131072)     clog2 = 17;
            else if (value_i <= 262144)     clog2 = 18;
            else if (value_i <= 524288)     clog2 = 19;
            else if (value_i <= 1048576)    clog2 = 20;
            else if (value_i <= 2097152)    clog2 = 21;
            else if (value_i <= 4194304)    clog2 = 22;
            else if (value_i <= 8388608)    clog2 = 23;
            else if (value_i <= 16777216)   clog2 = 24;
            else if (value_i <= 33554432)   clog2 = 25;
            else if (value_i <= 67108864)   clog2 = 26;
            else if (value_i <= 134217728)  clog2 = 27;
            else if (value_i <= 268435456)  clog2 = 28;
            else if (value_i <= 536870912)  clog2 = 29;
            else                            clog2 = 30;
        end
    endfunction

    localparam INDEX_WIDTH = (ENTRY_COUNT <= 1) ? 1 : clog2(ENTRY_COUNT);

    localparam [1:0] WEAKLY_NOT_TAKEN = 2'b01;

    /*
     * The counter array is intentionally not reset. ASIC SRAM/register-file
     * data does not need reset because counter_valid_q masks every cold entry.
     */
    reg [1:0] counter_table_q [0:ENTRY_COUNT-1];
    reg [ENTRY_COUNT-1:0] counter_valid_q;

    wire [INDEX_WIDTH-1:0] predict_index_w;
    wire [INDEX_WIDTH-1:0] update_index_w;
    wire                   predict_entry_valid_w;
    wire                   update_entry_valid_w;
    wire [1:0]             predict_counter_stored_w;
    wire [1:0]             update_counter_stored_w;
    wire [1:0]             update_counter_current_w;
    wire [1:0]             update_counter_next_w;

    assign predict_index_w          = predict_pc_i[INDEX_WIDTH+1:2];
    assign update_index_w           = update_pc_i[INDEX_WIDTH+1:2];
    assign predict_entry_valid_w    = counter_valid_q[predict_index_w];
    assign update_entry_valid_w     = counter_valid_q[update_index_w];
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

    /*
     * RESET_ON_SOFT_RESET is kept to preserve source compatibility. This ASIC
     * implementation both parameter values invalidate all metadata whenever
     * rstn_i is low; the counter storage itself is never reset.
     */
    always @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            counter_valid_q <= {ENTRY_COUNT{1'b0}};
        end else if (update_valid_i) begin
            counter_valid_q[update_index_w] <= 1'b1;
        end
    end

    always @(posedge clk_i) begin
        if (rstn_i && update_valid_i) begin
            counter_table_q[update_index_w] <= update_counter_next_w;
        end
    end

endmodule
