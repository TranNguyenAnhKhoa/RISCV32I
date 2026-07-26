module tage_hash #(
    parameter INDEX_WIDTH = 5,
    parameter TAG_WIDTH = 6,
    parameter HISTORY_WIDTH = 32,
    parameter HISTORY_LENGTH = 4,
    parameter TABLE_ID = 1
) (
    input [31:0] pc_i,
    input [HISTORY_WIDTH-1:0] history_i,
    output [INDEX_WIDTH-1:0] index_o,
    output [TAG_WIDTH-1:0] tag_o
);

    localparam INDEX_SHIFT_00 = 0;
    localparam INDEX_SHIFT_01 = INDEX_WIDTH;
    localparam INDEX_SHIFT_02 = INDEX_SHIFT_01 + INDEX_WIDTH;
    localparam INDEX_SHIFT_03 = INDEX_SHIFT_02 + INDEX_WIDTH;
    localparam INDEX_SHIFT_04 = INDEX_SHIFT_03 + INDEX_WIDTH;
    localparam INDEX_SHIFT_05 = INDEX_SHIFT_04 + INDEX_WIDTH;
    localparam INDEX_SHIFT_06 = INDEX_SHIFT_05 + INDEX_WIDTH;
    localparam INDEX_SHIFT_07 = INDEX_SHIFT_06 + INDEX_WIDTH;
    localparam INDEX_SHIFT_08 = INDEX_SHIFT_07 + INDEX_WIDTH;
    localparam INDEX_SHIFT_09 = INDEX_SHIFT_08 + INDEX_WIDTH;
    localparam INDEX_SHIFT_10 = INDEX_SHIFT_09 + INDEX_WIDTH;
    localparam INDEX_SHIFT_11 = INDEX_SHIFT_10 + INDEX_WIDTH;
    localparam INDEX_SHIFT_12 = INDEX_SHIFT_11 + INDEX_WIDTH;
    localparam INDEX_SHIFT_13 = INDEX_SHIFT_12 + INDEX_WIDTH;
    localparam INDEX_SHIFT_14 = INDEX_SHIFT_13 + INDEX_WIDTH;
    localparam INDEX_SHIFT_15 = INDEX_SHIFT_14 + INDEX_WIDTH;

    localparam TAG_SHIFT_00 = 0;
    localparam TAG_SHIFT_01 = TAG_WIDTH;
    localparam TAG_SHIFT_02 = TAG_SHIFT_01 + TAG_WIDTH;
    localparam TAG_SHIFT_03 = TAG_SHIFT_02 + TAG_WIDTH;
    localparam TAG_SHIFT_04 = TAG_SHIFT_03 + TAG_WIDTH;
    localparam TAG_SHIFT_05 = TAG_SHIFT_04 + TAG_WIDTH;
    localparam TAG_SHIFT_06 = TAG_SHIFT_05 + TAG_WIDTH;
    localparam TAG_SHIFT_07 = TAG_SHIFT_06 + TAG_WIDTH;
    localparam TAG_SHIFT_08 = TAG_SHIFT_07 + TAG_WIDTH;
    localparam TAG_SHIFT_09 = TAG_SHIFT_08 + TAG_WIDTH;
    localparam TAG_SHIFT_10 = TAG_SHIFT_09 + TAG_WIDTH;
    localparam TAG_SHIFT_11 = TAG_SHIFT_10 + TAG_WIDTH;
    localparam TAG_SHIFT_12 = TAG_SHIFT_11 + TAG_WIDTH;
    localparam TAG_SHIFT_13 = TAG_SHIFT_12 + TAG_WIDTH;
    localparam TAG_SHIFT_14 = TAG_SHIFT_13 + TAG_WIDTH;
    localparam TAG_SHIFT_15 = TAG_SHIFT_14 + TAG_WIDTH;

    localparam INDEX_ROTATE = TABLE_ID % INDEX_WIDTH;
    localparam TAG_PC_ROTATE = TABLE_ID % TAG_WIDTH;
    localparam TAG_HISTORY_ROTATE_00 =
        (TABLE_ID + TABLE_ID) % TAG_WIDTH;
    localparam TAG_HISTORY_ROTATE_01 =
        (TABLE_ID + TABLE_ID + 1) % TAG_WIDTH;
    localparam TAG_HISTORY_ROTATE_02 =
        (TABLE_ID + TABLE_ID + 2) % TAG_WIDTH;
    localparam TAG_HISTORY_ROTATE_03 =
        (TABLE_ID + TABLE_ID + 3) % TAG_WIDTH;
    localparam TAG_HISTORY_ROTATE_04 =
        (TABLE_ID + TABLE_ID + 4) % TAG_WIDTH;
    localparam TAG_HISTORY_ROTATE_05 =
        (TABLE_ID + TABLE_ID + 5) % TAG_WIDTH;
    localparam TAG_HISTORY_ROTATE_06 =
        (TABLE_ID + TABLE_ID + 6) % TAG_WIDTH;
    localparam TAG_HISTORY_ROTATE_07 =
        (TABLE_ID + TABLE_ID + 7) % TAG_WIDTH;
    localparam TAG_HISTORY_ROTATE_08 =
        (TABLE_ID + TABLE_ID + 8) % TAG_WIDTH;
    localparam TAG_HISTORY_ROTATE_09 =
        (TABLE_ID + TABLE_ID + 9) % TAG_WIDTH;
    localparam TAG_HISTORY_ROTATE_10 =
        (TABLE_ID + TABLE_ID + 10) % TAG_WIDTH;
    localparam TAG_HISTORY_ROTATE_11 =
        (TABLE_ID + TABLE_ID + 11) % TAG_WIDTH;
    localparam TAG_HISTORY_ROTATE_12 =
        (TABLE_ID + TABLE_ID + 12) % TAG_WIDTH;
    localparam TAG_HISTORY_ROTATE_13 =
        (TABLE_ID + TABLE_ID + 13) % TAG_WIDTH;
    localparam TAG_HISTORY_ROTATE_14 =
        (TABLE_ID + TABLE_ID + 14) % TAG_WIDTH;
    localparam TAG_HISTORY_ROTATE_15 =
        (TABLE_ID + TABLE_ID + 15) % TAG_WIDTH;

    wire [31:0] pc_word_w;
    wire [31:0] history_low_w;
    wire [31:0] history_mask_w;
    wire [31:0] history_used_w;

    wire [INDEX_WIDTH-1:0] pc_index_fold_w;
    wire [INDEX_WIDTH-1:0] history_index_fold_w;
    wire [INDEX_WIDTH-1:0] pc_index_rotated_w;
    wire [INDEX_WIDTH-1:0] history_index_rotated_w;
    wire [INDEX_WIDTH-1:0] index_salt_w;

    wire [TAG_WIDTH-1:0] pc_tag_fold_w;
    wire [TAG_WIDTH-1:0] pc_tag_rotated_w;
    wire [TAG_WIDTH-1:0] history_tag_fold_w;
    wire [TAG_WIDTH-1:0] tag_salt_w;

    function [INDEX_WIDTH-1:0] fold_index;
        input [31:0] value_i;
        begin
            fold_index =
                (value_i >> INDEX_SHIFT_00) ^
                (value_i >> INDEX_SHIFT_01) ^
                (value_i >> INDEX_SHIFT_02) ^
                (value_i >> INDEX_SHIFT_03) ^
                (value_i >> INDEX_SHIFT_04) ^
                (value_i >> INDEX_SHIFT_05) ^
                (value_i >> INDEX_SHIFT_06) ^
                (value_i >> INDEX_SHIFT_07) ^
                (value_i >> INDEX_SHIFT_08) ^
                (value_i >> INDEX_SHIFT_09) ^
                (value_i >> INDEX_SHIFT_10) ^
                (value_i >> INDEX_SHIFT_11) ^
                (value_i >> INDEX_SHIFT_12) ^
                (value_i >> INDEX_SHIFT_13) ^
                (value_i >> INDEX_SHIFT_14) ^
                (value_i >> INDEX_SHIFT_15);
        end
    endfunction

    function [TAG_WIDTH-1:0] fold_tag;
        input [31:0] value_i;
        begin
            fold_tag =
                (value_i >> TAG_SHIFT_00) ^
                (value_i >> TAG_SHIFT_01) ^
                (value_i >> TAG_SHIFT_02) ^
                (value_i >> TAG_SHIFT_03) ^
                (value_i >> TAG_SHIFT_04) ^
                (value_i >> TAG_SHIFT_05) ^
                (value_i >> TAG_SHIFT_06) ^
                (value_i >> TAG_SHIFT_07) ^
                (value_i >> TAG_SHIFT_08) ^
                (value_i >> TAG_SHIFT_09) ^
                (value_i >> TAG_SHIFT_10) ^
                (value_i >> TAG_SHIFT_11) ^
                (value_i >> TAG_SHIFT_12) ^
                (value_i >> TAG_SHIFT_13) ^
                (value_i >> TAG_SHIFT_14) ^
                (value_i >> TAG_SHIFT_15);
        end
    endfunction

    function [INDEX_WIDTH-1:0] rotate_index;
        input [INDEX_WIDTH-1:0] value_i;
        input integer amount_i;
        begin
            if (amount_i == 0) begin
                rotate_index = value_i;
            end else begin
                rotate_index =
                    (value_i << amount_i) |
                    (value_i >> (INDEX_WIDTH - amount_i));
            end
        end
    endfunction

    function [TAG_WIDTH-1:0] rotate_tag;
        input [TAG_WIDTH-1:0] value_i;
        input integer amount_i;
        begin
            if (amount_i == 0) begin
                rotate_tag = value_i;
            end else begin
                rotate_tag =
                    (value_i << amount_i) |
                    (value_i >> (TAG_WIDTH - amount_i));
            end
        end
    endfunction

    assign pc_word_w = pc_i >> 2;
    assign history_low_w = history_i;
    assign history_mask_w = 32'hffffffff >> (32 - HISTORY_LENGTH);
    assign history_used_w = history_low_w & history_mask_w;

    assign pc_index_fold_w = fold_index(pc_word_w);
    assign history_index_fold_w = fold_index(history_used_w);
    assign pc_index_rotated_w =
        rotate_index(pc_index_fold_w, INDEX_ROTATE);
    assign history_index_rotated_w =
        rotate_index(history_index_fold_w, INDEX_ROTATE);
    assign index_salt_w = TABLE_ID;

    assign pc_tag_fold_w = fold_tag(pc_word_w);
    assign pc_tag_rotated_w = rotate_tag(pc_tag_fold_w, TAG_PC_ROTATE);
    assign tag_salt_w = TABLE_ID;

    assign history_tag_fold_w =
        rotate_tag(
            history_used_w >> TAG_SHIFT_00,
            TAG_HISTORY_ROTATE_00
        ) ^
        rotate_tag(
            history_used_w >> TAG_SHIFT_01,
            TAG_HISTORY_ROTATE_01
        ) ^
        rotate_tag(
            history_used_w >> TAG_SHIFT_02,
            TAG_HISTORY_ROTATE_02
        ) ^
        rotate_tag(
            history_used_w >> TAG_SHIFT_03,
            TAG_HISTORY_ROTATE_03
        ) ^
        rotate_tag(
            history_used_w >> TAG_SHIFT_04,
            TAG_HISTORY_ROTATE_04
        ) ^
        rotate_tag(
            history_used_w >> TAG_SHIFT_05,
            TAG_HISTORY_ROTATE_05
        ) ^
        rotate_tag(
            history_used_w >> TAG_SHIFT_06,
            TAG_HISTORY_ROTATE_06
        ) ^
        rotate_tag(
            history_used_w >> TAG_SHIFT_07,
            TAG_HISTORY_ROTATE_07
        ) ^
        rotate_tag(
            history_used_w >> TAG_SHIFT_08,
            TAG_HISTORY_ROTATE_08
        ) ^
        rotate_tag(
            history_used_w >> TAG_SHIFT_09,
            TAG_HISTORY_ROTATE_09
        ) ^
        rotate_tag(
            history_used_w >> TAG_SHIFT_10,
            TAG_HISTORY_ROTATE_10
        ) ^
        rotate_tag(
            history_used_w >> TAG_SHIFT_11,
            TAG_HISTORY_ROTATE_11
        ) ^
        rotate_tag(
            history_used_w >> TAG_SHIFT_12,
            TAG_HISTORY_ROTATE_12
        ) ^
        rotate_tag(
            history_used_w >> TAG_SHIFT_13,
            TAG_HISTORY_ROTATE_13
        ) ^
        rotate_tag(
            history_used_w >> TAG_SHIFT_14,
            TAG_HISTORY_ROTATE_14
        ) ^
        rotate_tag(
            history_used_w >> TAG_SHIFT_15,
            TAG_HISTORY_ROTATE_15
        );

    assign index_o =
        index_salt_w ^
        pc_index_rotated_w ^
        history_index_rotated_w;

    assign tag_o =
        tag_salt_w ^
        pc_tag_rotated_w ^
        history_tag_fold_w;

endmodule
