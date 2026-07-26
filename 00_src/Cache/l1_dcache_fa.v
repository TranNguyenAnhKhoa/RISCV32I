`timescale 1ns/1ps

module l1_dcache_fa #(
    parameter ADDRESS_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter LINE_COUNT = 4,
    parameter WORDS_PER_LINE = 4
) (
    input wire clk_i,
    input wire rstn_i,
    input wire cpu_request_valid_i,
    input wire cpu_write_i,
    input wire [ADDRESS_WIDTH-1:0] cpu_address_i,
    input wire [DATA_WIDTH-1:0] cpu_write_data_i,
    input wire [3:0] cpu_write_strobe_i,
    output reg cpu_request_ready_o,
    output reg cpu_response_valid_o,
    output reg [DATA_WIDTH-1:0] cpu_read_data_o,
    input wire flush_i,
    output reg flush_busy_o,
    output reg flush_done_o,
    output reg memory_request_valid_o,
    output reg memory_write_o,
    output reg [ADDRESS_WIDTH-1:0] memory_address_o,
    output reg [DATA_WIDTH-1:0] memory_write_data_o,
    output reg [3:0] memory_write_strobe_o,
    input wire memory_request_ready_i,
    input wire memory_response_valid_i,
    input wire [DATA_WIDTH-1:0] memory_read_data_i,
    output reg [31:0] hit_count_o,
    output reg [31:0] miss_count_o,
    output reg [31:0] writeback_count_o
);

    localparam integer BYTE_OFFSET_WIDTH = 2;
    localparam integer LINE_WORD_OFFSET_WIDTH =
        (WORDS_PER_LINE == 1)  ? 0 :
        (WORDS_PER_LINE == 2)  ? 1 :
        (WORDS_PER_LINE == 4)  ? 2 :
        (WORDS_PER_LINE == 8)  ? 3 : 4;
    localparam integer WORD_INDEX_WIDTH =
        (WORDS_PER_LINE == 1)  ? 1 :
        (WORDS_PER_LINE == 2)  ? 1 :
        (WORDS_PER_LINE == 4)  ? 2 :
        (WORDS_PER_LINE == 8)  ? 3 : 4;
    localparam integer LINE_ADDRESS_OFFSET_WIDTH =
        BYTE_OFFSET_WIDTH + LINE_WORD_OFFSET_WIDTH;
    localparam integer TAG_WIDTH =
        ADDRESS_WIDTH - LINE_ADDRESS_OFFSET_WIDTH;

    localparam [3:0] DCACHE_IDLE                    = 4'd0;
    localparam [3:0] DCACHE_LOOKUP                  = 4'd1;
    localparam [3:0] DCACHE_WRITEBACK_REQUEST       = 4'd2;
    localparam [3:0] DCACHE_REFILL_REQUEST          = 4'd3;
    localparam [3:0] DCACHE_REFILL_WAIT             = 4'd4;
    localparam [3:0] DCACHE_RESPOND                 = 4'd5;
    localparam [3:0] DCACHE_FLUSH_SCAN              = 4'd6;
    localparam [3:0] DCACHE_FLUSH_WRITEBACK_REQUEST = 4'd7;
    localparam [3:0] DCACHE_FLUSH_DONE              = 4'd8;

    reg [3:0] state_q;

    reg valid_way0_q;
    reg valid_way1_q;
    reg valid_way2_q;
    reg valid_way3_q;
    reg dirty_way0_q;
    reg dirty_way1_q;
    reg dirty_way2_q;
    reg dirty_way3_q;

    reg [TAG_WIDTH-1:0] tag_way0_q;
    reg [TAG_WIDTH-1:0] tag_way1_q;
    reg [TAG_WIDTH-1:0] tag_way2_q;
    reg [TAG_WIDTH-1:0] tag_way3_q;

    reg [DATA_WIDTH-1:0] data_way0_q [0:WORDS_PER_LINE-1];
    reg [DATA_WIDTH-1:0] data_way1_q [0:WORDS_PER_LINE-1];
    reg [DATA_WIDTH-1:0] data_way2_q [0:WORDS_PER_LINE-1];
    reg [DATA_WIDTH-1:0] data_way3_q [0:WORDS_PER_LINE-1];

    reg [ADDRESS_WIDTH-1:0] request_address_q;
    reg request_write_q;
    reg [DATA_WIDTH-1:0] request_write_data_q;
    reg [3:0] request_write_strobe_q;
    reg [DATA_WIDTH-1:0] response_data_q;
    reg replay_after_miss_q;
    reg flush_pending_q;

    reg [1:0] victim_way_q;
    reg [1:0] replacement_way_q;
    reg [1:0] flush_way_q;
    reg [WORD_INDEX_WIDTH-1:0] transfer_word_q;

    wire [TAG_WIDTH-1:0] request_tag_w;
    wire [WORD_INDEX_WIDTH-1:0] request_word_index_w;
    wire [ADDRESS_WIDTH-1:0] transfer_byte_offset_w;

    wire way0_hit_w;
    wire way1_hit_w;
    wire way2_hit_w;
    wire way3_hit_w;
    wire lookup_hit_w;

    reg [1:0] lookup_hit_way_r;
    reg [1:0] selected_victim_way_r;
    reg selected_victim_valid_r;
    reg selected_victim_dirty_r;
    reg [DATA_WIDTH-1:0] lookup_data_r;
    reg [TAG_WIDTH-1:0] victim_tag_r;
    reg [DATA_WIDTH-1:0] victim_data_r;
    reg flush_valid_r;
    reg flush_dirty_r;
    reg [TAG_WIDTH-1:0] flush_tag_r;
    reg [DATA_WIDTH-1:0] flush_data_r;

    function [DATA_WIDTH-1:0] merge_write_data;
        input [DATA_WIDTH-1:0] current_data_i;
        input [DATA_WIDTH-1:0] write_data_i;
        input [3:0] write_strobe_i;
        begin
            merge_write_data = current_data_i;
            if (write_strobe_i[0]) begin
                merge_write_data[7:0] = write_data_i[7:0];
            end
            if (write_strobe_i[1]) begin
                merge_write_data[15:8] = write_data_i[15:8];
            end
            if (write_strobe_i[2]) begin
                merge_write_data[23:16] = write_data_i[23:16];
            end
            if (write_strobe_i[3]) begin
                merge_write_data[31:24] = write_data_i[31:24];
            end
        end
    endfunction

    assign request_tag_w =
        request_address_q >> LINE_ADDRESS_OFFSET_WIDTH;

    assign request_word_index_w =
        (WORDS_PER_LINE == 1) ?
        {WORD_INDEX_WIDTH{1'b0}} :
        (request_address_q >> BYTE_OFFSET_WIDTH);

    assign transfer_byte_offset_w =
        {{(ADDRESS_WIDTH-WORD_INDEX_WIDTH){1'b0}}, transfer_word_q}
        << BYTE_OFFSET_WIDTH;

    assign way0_hit_w =
        valid_way0_q &&
        (tag_way0_q == request_tag_w);

    assign way1_hit_w =
        (LINE_COUNT >= 2) &&
        valid_way1_q &&
        (tag_way1_q == request_tag_w);

    assign way2_hit_w =
        (LINE_COUNT >= 3) &&
        valid_way2_q &&
        (tag_way2_q == request_tag_w);

    assign way3_hit_w =
        (LINE_COUNT >= 4) &&
        valid_way3_q &&
        (tag_way3_q == request_tag_w);

    assign lookup_hit_w =
        way0_hit_w ||
        way1_hit_w ||
        way2_hit_w ||
        way3_hit_w;

    always @(*) begin
        lookup_hit_way_r = 2'd0;

        if (way0_hit_w) begin
            lookup_hit_way_r = 2'd0;
        end else if (way1_hit_w) begin
            lookup_hit_way_r = 2'd1;
        end else if (way2_hit_w) begin
            lookup_hit_way_r = 2'd2;
        end else if (way3_hit_w) begin
            lookup_hit_way_r = 2'd3;
        end
    end

    always @(*) begin
        selected_victim_way_r = replacement_way_q;

        if (!valid_way0_q) begin
            selected_victim_way_r = 2'd0;
        end else if ((LINE_COUNT >= 2) && !valid_way1_q) begin
            selected_victim_way_r = 2'd1;
        end else if ((LINE_COUNT >= 3) && !valid_way2_q) begin
            selected_victim_way_r = 2'd2;
        end else if ((LINE_COUNT >= 4) && !valid_way3_q) begin
            selected_victim_way_r = 2'd3;
        end
    end

    always @(*) begin
        selected_victim_valid_r = 1'b0;
        selected_victim_dirty_r = 1'b0;

        case (selected_victim_way_r)
            2'd0: begin
                selected_victim_valid_r = valid_way0_q;
                selected_victim_dirty_r = dirty_way0_q;
            end

            2'd1: begin
                selected_victim_valid_r = valid_way1_q;
                selected_victim_dirty_r = dirty_way1_q;
            end

            2'd2: begin
                selected_victim_valid_r = valid_way2_q;
                selected_victim_dirty_r = dirty_way2_q;
            end

            2'd3: begin
                selected_victim_valid_r = valid_way3_q;
                selected_victim_dirty_r = dirty_way3_q;
            end

            default: begin
                selected_victim_valid_r = 1'b0;
                selected_victim_dirty_r = 1'b0;
            end
        endcase
    end

    always @(*) begin
        lookup_data_r = {DATA_WIDTH{1'b0}};

        case (lookup_hit_way_r)
            2'd0: begin
                lookup_data_r = data_way0_q[request_word_index_w];
            end

            2'd1: begin
                lookup_data_r = data_way1_q[request_word_index_w];
            end

            2'd2: begin
                lookup_data_r = data_way2_q[request_word_index_w];
            end

            2'd3: begin
                lookup_data_r = data_way3_q[request_word_index_w];
            end

            default: begin
                lookup_data_r = {DATA_WIDTH{1'b0}};
            end
        endcase
    end

    always @(*) begin
        victim_tag_r = {TAG_WIDTH{1'b0}};
        victim_data_r = {DATA_WIDTH{1'b0}};

        case (victim_way_q)
            2'd0: begin
                victim_tag_r = tag_way0_q;
                victim_data_r = data_way0_q[transfer_word_q];
            end

            2'd1: begin
                victim_tag_r = tag_way1_q;
                victim_data_r = data_way1_q[transfer_word_q];
            end

            2'd2: begin
                victim_tag_r = tag_way2_q;
                victim_data_r = data_way2_q[transfer_word_q];
            end

            2'd3: begin
                victim_tag_r = tag_way3_q;
                victim_data_r = data_way3_q[transfer_word_q];
            end

            default: begin
                victim_tag_r = {TAG_WIDTH{1'b0}};
                victim_data_r = {DATA_WIDTH{1'b0}};
            end
        endcase
    end

    always @(*) begin
        flush_valid_r = 1'b0;
        flush_dirty_r = 1'b0;
        flush_tag_r = {TAG_WIDTH{1'b0}};
        flush_data_r = {DATA_WIDTH{1'b0}};

        case (flush_way_q)
            2'd0: begin
                flush_valid_r = valid_way0_q;
                flush_dirty_r = dirty_way0_q;
                flush_tag_r = tag_way0_q;
                flush_data_r = data_way0_q[transfer_word_q];
            end

            2'd1: begin
                flush_valid_r = valid_way1_q;
                flush_dirty_r = dirty_way1_q;
                flush_tag_r = tag_way1_q;
                flush_data_r = data_way1_q[transfer_word_q];
            end

            2'd2: begin
                flush_valid_r = valid_way2_q;
                flush_dirty_r = dirty_way2_q;
                flush_tag_r = tag_way2_q;
                flush_data_r = data_way2_q[transfer_word_q];
            end

            2'd3: begin
                flush_valid_r = valid_way3_q;
                flush_dirty_r = dirty_way3_q;
                flush_tag_r = tag_way3_q;
                flush_data_r = data_way3_q[transfer_word_q];
            end

            default: begin
                flush_valid_r = 1'b0;
                flush_dirty_r = 1'b0;
                flush_tag_r = {TAG_WIDTH{1'b0}};
                flush_data_r = {DATA_WIDTH{1'b0}};
            end
        endcase
    end

    always @(*) begin
        cpu_request_ready_o = 1'b0;
        cpu_response_valid_o = 1'b0;
        cpu_read_data_o = response_data_q;
        flush_busy_o = 1'b0;
        flush_done_o = 1'b0;
        memory_request_valid_o = 1'b0;
        memory_write_o = 1'b0;
        memory_address_o = {ADDRESS_WIDTH{1'b0}};
        memory_write_data_o = {DATA_WIDTH{1'b0}};
        memory_write_strobe_o = 4'b0000;

        case (state_q)
            DCACHE_IDLE: begin
                if (!flush_i && !flush_pending_q) begin
                    cpu_request_ready_o = 1'b1;
                end
            end

            DCACHE_WRITEBACK_REQUEST: begin
                memory_request_valid_o = 1'b1;
                memory_write_o = 1'b1;
                memory_address_o = victim_tag_r;
                memory_address_o =
                    memory_address_o << LINE_ADDRESS_OFFSET_WIDTH;
                memory_address_o =
                    memory_address_o | transfer_byte_offset_w;
                memory_write_data_o = victim_data_r;
                memory_write_strobe_o = 4'b1111;
            end

            DCACHE_REFILL_REQUEST: begin
                memory_request_valid_o = 1'b1;
                memory_write_o = 1'b0;
                memory_address_o = request_address_q;
                memory_address_o =
                    memory_address_o >> LINE_ADDRESS_OFFSET_WIDTH;
                memory_address_o =
                    memory_address_o << LINE_ADDRESS_OFFSET_WIDTH;
                memory_address_o =
                    memory_address_o | transfer_byte_offset_w;
            end

            DCACHE_RESPOND: begin
                cpu_response_valid_o = 1'b1;
            end

            DCACHE_FLUSH_SCAN: begin
                flush_busy_o = 1'b1;
            end

            DCACHE_FLUSH_WRITEBACK_REQUEST: begin
                flush_busy_o = 1'b1;
                memory_request_valid_o = 1'b1;
                memory_write_o = 1'b1;
                memory_address_o = flush_tag_r;
                memory_address_o =
                    memory_address_o << LINE_ADDRESS_OFFSET_WIDTH;
                memory_address_o =
                    memory_address_o | transfer_byte_offset_w;
                memory_write_data_o = flush_data_r;
                memory_write_strobe_o = 4'b1111;
            end

            DCACHE_FLUSH_DONE: begin
                flush_done_o = 1'b1;
            end

            default: begin
                cpu_request_ready_o = 1'b0;
            end
        endcase
    end

    always @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            state_q <= DCACHE_IDLE;
            valid_way0_q <= 1'b0;
            valid_way1_q <= 1'b0;
            valid_way2_q <= 1'b0;
            valid_way3_q <= 1'b0;
            dirty_way0_q <= 1'b0;
            dirty_way1_q <= 1'b0;
            dirty_way2_q <= 1'b0;
            dirty_way3_q <= 1'b0;
            request_address_q <= {ADDRESS_WIDTH{1'b0}};
            request_write_q <= 1'b0;
            request_write_data_q <= {DATA_WIDTH{1'b0}};
            request_write_strobe_q <= 4'b0000;
            response_data_q <= {DATA_WIDTH{1'b0}};
            replay_after_miss_q <= 1'b0;
            flush_pending_q <= 1'b0;
            victim_way_q <= 2'd0;
            replacement_way_q <= 2'd0;
            flush_way_q <= 2'd0;
            transfer_word_q <= {WORD_INDEX_WIDTH{1'b0}};
            hit_count_o <= 32'd0;
            miss_count_o <= 32'd0;
            writeback_count_o <= 32'd0;
        end else begin
            if (flush_i && (state_q != DCACHE_IDLE)) begin
                flush_pending_q <= 1'b1;
            end

            case (state_q)
                DCACHE_IDLE: begin
                    if (flush_i || flush_pending_q) begin
                        flush_pending_q <= 1'b0;
                        flush_way_q <= 2'd0;
                        transfer_word_q <= {WORD_INDEX_WIDTH{1'b0}};
                        state_q <= DCACHE_FLUSH_SCAN;
                    end else if (cpu_request_valid_i) begin
                        request_address_q <= cpu_address_i;
                        request_write_q <= cpu_write_i;
                        request_write_data_q <= cpu_write_data_i;
                        request_write_strobe_q <= cpu_write_strobe_i;
                        replay_after_miss_q <= 1'b0;
                        state_q <= DCACHE_LOOKUP;
                    end
                end

                DCACHE_LOOKUP: begin
                    if (lookup_hit_w) begin
                        if (!replay_after_miss_q) begin
                            hit_count_o <= hit_count_o + 1'b1;
                        end

                        if (request_write_q) begin
                            case (lookup_hit_way_r)
                                2'd0: begin
                                    dirty_way0_q <= 1'b1;
                                end

                                2'd1: begin
                                    dirty_way1_q <= 1'b1;
                                end

                                2'd2: begin
                                    dirty_way2_q <= 1'b1;
                                end

                                2'd3: begin
                                    dirty_way3_q <= 1'b1;
                                end

                                default: begin
                                    dirty_way0_q <= dirty_way0_q;
                                end
                            endcase

                            response_data_q <= {DATA_WIDTH{1'b0}};
                        end else begin
                            response_data_q <= lookup_data_r;
                        end

                        replay_after_miss_q <= 1'b0;
                        state_q <= DCACHE_RESPOND;
                    end else begin
                        victim_way_q <= selected_victim_way_r;
                        transfer_word_q <= {WORD_INDEX_WIDTH{1'b0}};
                        replay_after_miss_q <= 1'b1;
                        miss_count_o <= miss_count_o + 1'b1;

                        if (selected_victim_way_r == LINE_COUNT-1) begin
                            replacement_way_q <= 2'd0;
                        end else begin
                            replacement_way_q <=
                                selected_victim_way_r + 1'b1;
                        end

                        if (selected_victim_valid_r &&
                            selected_victim_dirty_r) begin
                            writeback_count_o <=
                                writeback_count_o + 1'b1;
                            state_q <= DCACHE_WRITEBACK_REQUEST;
                        end else begin
                            case (selected_victim_way_r)
                                2'd0: begin
                                    valid_way0_q <= 1'b0;
                                    dirty_way0_q <= 1'b0;
                                end

                                2'd1: begin
                                    valid_way1_q <= 1'b0;
                                    dirty_way1_q <= 1'b0;
                                end

                                2'd2: begin
                                    valid_way2_q <= 1'b0;
                                    dirty_way2_q <= 1'b0;
                                end

                                2'd3: begin
                                    valid_way3_q <= 1'b0;
                                    dirty_way3_q <= 1'b0;
                                end

                                default: begin
                                    valid_way0_q <= valid_way0_q;
                                    dirty_way0_q <= dirty_way0_q;
                                end
                            endcase

                            state_q <= DCACHE_REFILL_REQUEST;
                        end
                    end
                end

                DCACHE_WRITEBACK_REQUEST: begin
                    if (memory_request_ready_i) begin
                        if (transfer_word_q == WORDS_PER_LINE-1) begin
                            case (victim_way_q)
                                2'd0: begin
                                    valid_way0_q <= 1'b0;
                                    dirty_way0_q <= 1'b0;
                                end

                                2'd1: begin
                                    valid_way1_q <= 1'b0;
                                    dirty_way1_q <= 1'b0;
                                end

                                2'd2: begin
                                    valid_way2_q <= 1'b0;
                                    dirty_way2_q <= 1'b0;
                                end

                                2'd3: begin
                                    valid_way3_q <= 1'b0;
                                    dirty_way3_q <= 1'b0;
                                end

                                default: begin
                                    valid_way0_q <= valid_way0_q;
                                    dirty_way0_q <= dirty_way0_q;
                                end
                            endcase

                            transfer_word_q <=
                                {WORD_INDEX_WIDTH{1'b0}};
                            state_q <= DCACHE_REFILL_REQUEST;
                        end else begin
                            transfer_word_q <= transfer_word_q + 1'b1;
                        end
                    end
                end

                DCACHE_REFILL_REQUEST: begin
                    if (memory_request_ready_i) begin
                        state_q <= DCACHE_REFILL_WAIT;
                    end
                end

                DCACHE_REFILL_WAIT: begin
                    if (memory_response_valid_i) begin
                        if (transfer_word_q == WORDS_PER_LINE-1) begin
                            case (victim_way_q)
                                2'd0: begin
                                    valid_way0_q <= 1'b1;
                                    dirty_way0_q <= 1'b0;
                                end

                                2'd1: begin
                                    valid_way1_q <= 1'b1;
                                    dirty_way1_q <= 1'b0;
                                end

                                2'd2: begin
                                    valid_way2_q <= 1'b1;
                                    dirty_way2_q <= 1'b0;
                                end

                                2'd3: begin
                                    valid_way3_q <= 1'b1;
                                    dirty_way3_q <= 1'b0;
                                end

                                default: begin
                                    valid_way0_q <= valid_way0_q;
                                    dirty_way0_q <= dirty_way0_q;
                                end
                            endcase

                            transfer_word_q <=
                                {WORD_INDEX_WIDTH{1'b0}};
                            state_q <= DCACHE_LOOKUP;
                        end else begin
                            transfer_word_q <= transfer_word_q + 1'b1;
                            state_q <= DCACHE_REFILL_REQUEST;
                        end
                    end
                end

                DCACHE_RESPOND: begin
                    state_q <= DCACHE_IDLE;
                end

                DCACHE_FLUSH_SCAN: begin
                    if (flush_valid_r && flush_dirty_r) begin
                        transfer_word_q <=
                            {WORD_INDEX_WIDTH{1'b0}};
                        state_q <= DCACHE_FLUSH_WRITEBACK_REQUEST;
                    end else begin
                        case (flush_way_q)
                            2'd0: begin
                                valid_way0_q <= 1'b0;
                                dirty_way0_q <= 1'b0;
                            end

                            2'd1: begin
                                valid_way1_q <= 1'b0;
                                dirty_way1_q <= 1'b0;
                            end

                            2'd2: begin
                                valid_way2_q <= 1'b0;
                                dirty_way2_q <= 1'b0;
                            end

                            2'd3: begin
                                valid_way3_q <= 1'b0;
                                dirty_way3_q <= 1'b0;
                            end

                            default: begin
                                valid_way0_q <= valid_way0_q;
                                dirty_way0_q <= dirty_way0_q;
                            end
                        endcase

                        if (flush_way_q == LINE_COUNT-1) begin
                            state_q <= DCACHE_FLUSH_DONE;
                        end else begin
                            flush_way_q <= flush_way_q + 1'b1;
                        end
                    end
                end

                DCACHE_FLUSH_WRITEBACK_REQUEST: begin
                    if (memory_request_ready_i) begin
                        if (transfer_word_q == WORDS_PER_LINE-1) begin
                            case (flush_way_q)
                                2'd0: begin
                                    valid_way0_q <= 1'b0;
                                    dirty_way0_q <= 1'b0;
                                end

                                2'd1: begin
                                    valid_way1_q <= 1'b0;
                                    dirty_way1_q <= 1'b0;
                                end

                                2'd2: begin
                                    valid_way2_q <= 1'b0;
                                    dirty_way2_q <= 1'b0;
                                end

                                2'd3: begin
                                    valid_way3_q <= 1'b0;
                                    dirty_way3_q <= 1'b0;
                                end

                                default: begin
                                    valid_way0_q <= valid_way0_q;
                                    dirty_way0_q <= dirty_way0_q;
                                end
                            endcase

                            transfer_word_q <=
                                {WORD_INDEX_WIDTH{1'b0}};

                            if (flush_way_q == LINE_COUNT-1) begin
                                state_q <= DCACHE_FLUSH_DONE;
                            end else begin
                                flush_way_q <= flush_way_q + 1'b1;
                                state_q <= DCACHE_FLUSH_SCAN;
                            end
                        end else begin
                            transfer_word_q <= transfer_word_q + 1'b1;
                        end
                    end
                end

                DCACHE_FLUSH_DONE: begin
                    state_q <= DCACHE_IDLE;
                end

                default: begin
                    state_q <= DCACHE_IDLE;
                    valid_way0_q <= 1'b0;
                    valid_way1_q <= 1'b0;
                    valid_way2_q <= 1'b0;
                    valid_way3_q <= 1'b0;
                    dirty_way0_q <= 1'b0;
                    dirty_way1_q <= 1'b0;
                    dirty_way2_q <= 1'b0;
                    dirty_way3_q <= 1'b0;
                    flush_pending_q <= 1'b0;
                end
            endcase
        end
    end

    always @(posedge clk_i) begin
        if ((state_q == DCACHE_LOOKUP) &&
            !lookup_hit_w &&
            !(selected_victim_valid_r &&
              selected_victim_dirty_r)) begin
            case (selected_victim_way_r)
                2'd0: begin
                    tag_way0_q <= request_tag_w;
                end

                2'd1: begin
                    tag_way1_q <= request_tag_w;
                end

                2'd2: begin
                    tag_way2_q <= request_tag_w;
                end

                2'd3: begin
                    tag_way3_q <= request_tag_w;
                end

                default: begin
                    tag_way0_q <= tag_way0_q;
                end
            endcase
        end else if ((state_q == DCACHE_WRITEBACK_REQUEST) &&
                     memory_request_ready_i &&
                     (transfer_word_q == WORDS_PER_LINE-1)) begin
            case (victim_way_q)
                2'd0: begin
                    tag_way0_q <= request_tag_w;
                end

                2'd1: begin
                    tag_way1_q <= request_tag_w;
                end

                2'd2: begin
                    tag_way2_q <= request_tag_w;
                end

                2'd3: begin
                    tag_way3_q <= request_tag_w;
                end

                default: begin
                    tag_way0_q <= tag_way0_q;
                end
            endcase
        end
    end

    always @(posedge clk_i) begin
        if ((state_q == DCACHE_LOOKUP) &&
            lookup_hit_w &&
            request_write_q) begin
            case (lookup_hit_way_r)
                2'd0: begin
                    data_way0_q[request_word_index_w] <=
                        merge_write_data(
                            data_way0_q[request_word_index_w],
                            request_write_data_q,
                            request_write_strobe_q
                        );
                end

                2'd1: begin
                    data_way1_q[request_word_index_w] <=
                        merge_write_data(
                            data_way1_q[request_word_index_w],
                            request_write_data_q,
                            request_write_strobe_q
                        );
                end

                2'd2: begin
                    data_way2_q[request_word_index_w] <=
                        merge_write_data(
                            data_way2_q[request_word_index_w],
                            request_write_data_q,
                            request_write_strobe_q
                        );
                end

                2'd3: begin
                    data_way3_q[request_word_index_w] <=
                        merge_write_data(
                            data_way3_q[request_word_index_w],
                            request_write_data_q,
                            request_write_strobe_q
                        );
                end

                default: begin
                    data_way0_q[request_word_index_w] <=
                        data_way0_q[request_word_index_w];
                end
            endcase
        end else if ((state_q == DCACHE_REFILL_WAIT) &&
                     memory_response_valid_i) begin
            case (victim_way_q)
                2'd0: begin
                    data_way0_q[transfer_word_q] <=
                        memory_read_data_i;
                end

                2'd1: begin
                    data_way1_q[transfer_word_q] <=
                        memory_read_data_i;
                end

                2'd2: begin
                    data_way2_q[transfer_word_q] <=
                        memory_read_data_i;
                end

                2'd3: begin
                    data_way3_q[transfer_word_q] <=
                        memory_read_data_i;
                end

                default: begin
                    data_way0_q[transfer_word_q] <=
                        data_way0_q[transfer_word_q];
                end
            endcase
        end
    end

endmodule
