(* use_dsp = "no" *)
module tage_hash #(
    parameter INDEX_WIDTH    = 5,
    parameter TAG_WIDTH      = 6,
    parameter HISTORY_WIDTH  = 32,
    parameter HISTORY_LENGTH = 4,
    parameter TABLE_ID       = 1
) (
    input  [31:0]                pc_i,
    input  [HISTORY_WIDTH-1:0]   history_i,
    output [INDEX_WIDTH-1:0]     index_o,
    output [TAG_WIDTH-1:0]       tag_o
);

    function [INDEX_WIDTH-1:0] make_index;
        input [31:0]              pc_value;
        input [HISTORY_WIDTH-1:0] history_value;
        integer pc_bit;
        integer history_bit;
        integer folded_bit;
        reg [INDEX_WIDTH-1:0] hash_value;
        begin
            hash_value = TABLE_ID;

            for (pc_bit = 2;
                 pc_bit < 32;
                 pc_bit = pc_bit + 1) begin
                folded_bit =
                    (pc_bit - 2 + TABLE_ID) % INDEX_WIDTH;
                hash_value[folded_bit] =
                    hash_value[folded_bit] ^ pc_value[pc_bit];
            end

            for (history_bit = 0;
                 history_bit < HISTORY_LENGTH;
                 history_bit = history_bit + 1) begin
                folded_bit = (history_bit + TABLE_ID) % INDEX_WIDTH;
                hash_value[folded_bit] =
                    hash_value[folded_bit] ^ history_value[history_bit];
            end

            make_index = hash_value;
        end
    endfunction

    function [TAG_WIDTH-1:0] make_tag;
        input [31:0]              pc_value;
        input [HISTORY_WIDTH-1:0] history_value;
        integer pc_bit;
        integer history_bit;
        integer folded_bit;
        reg [TAG_WIDTH-1:0] hash_value;
        begin
            hash_value = TABLE_ID;

            for (pc_bit = 2;
                 pc_bit < 32;
                 pc_bit = pc_bit + 1) begin
                folded_bit =
                    (pc_bit - 2 + TABLE_ID) % TAG_WIDTH;
                hash_value[folded_bit] =
                    hash_value[folded_bit] ^ pc_value[pc_bit];
            end

            for (history_bit = 0;
                 history_bit < HISTORY_LENGTH;
                 history_bit = history_bit + 1) begin
                folded_bit =
                    (history_bit +
                     (history_bit / TAG_WIDTH) +
                     (TABLE_ID * 2)) % TAG_WIDTH;
                hash_value[folded_bit] =
                    hash_value[folded_bit] ^ history_value[history_bit];
            end

            make_tag = hash_value;
        end
    endfunction

    assign index_o = make_index(pc_i, history_i);
    assign tag_o   = make_tag(pc_i, history_i);

    // synthesis translate_off
    initial begin
        if ((INDEX_WIDTH < 2) ||
            (TAG_WIDTH < 2) ||
            (HISTORY_WIDTH < 2) ||
            (HISTORY_LENGTH < 1) ||
            (HISTORY_LENGTH > HISTORY_WIDTH) ||
            (TABLE_ID < 1)) begin
            $display("ERROR: invalid tage_hash parameter");
            $finish;
        end
    end
    // synthesis translate_on

endmodule
