`timescale 1ns/1ps

module l1_icache_fa #(
    parameter ADDRESS_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter LINE_COUNT = 4,
    parameter WORDS_PER_LINE = 4
) (
    input wire clk_i,
    input wire rstn_i,
    input wire cpu_request_valid_i,
    input wire [ADDRESS_WIDTH-1:0] cpu_address_i,
    output reg cpu_request_ready_o,
    output reg cpu_response_valid_o,
    output reg [DATA_WIDTH-1:0] cpu_read_data_o,
    input wire invalidate_i,
    output reg busy_o,
    output reg memory_request_valid_o,
    output reg [ADDRESS_WIDTH-1:0] memory_address_o,
    input wire memory_request_ready_i,
    input wire memory_response_valid_i,
    input wire [DATA_WIDTH-1:0] memory_read_data_i,
    output reg [31:0] hit_count_o,
    output reg [31:0] miss_count_o
);

    localparam BYTE_OFFSET_WIDTH = 2;
    localparam LINE_WORD_OFFSET_WIDTH =
        (WORDS_PER_LINE == 1)  ? 0 :
        (WORDS_PER_LINE == 2)  ? 1 :
        (WORDS_PER_LINE == 4)  ? 2 :
        (WORDS_PER_LINE == 8)  ? 3 : 4;
    localparam WORD_INDEX_WIDTH =
        (WORDS_PER_LINE == 1)  ? 1 :
        (WORDS_PER_LINE == 2)  ? 1 :
        (WORDS_PER_LINE == 4)  ? 2 :
        (WORDS_PER_LINE == 8)  ? 3 : 4;
    localparam LINE_INDEX_WIDTH = 2;
    localparam LINE_OFFSET_WIDTH =
        BYTE_OFFSET_WIDTH + LINE_WORD_OFFSET_WIDTH;
    localparam TAG_WIDTH = ADDRESS_WIDTH - LINE_OFFSET_WIDTH;

    localparam [2:0] ICACHE_IDLE = 3'd0;
    localparam [2:0] ICACHE_LOOKUP = 3'd1;
    localparam [2:0] ICACHE_REFILL_REQUEST = 3'd2;
    localparam [2:0] ICACHE_REFILL_WAIT = 3'd3;
    localparam [2:0] ICACHE_RESPOND = 3'd4;

    reg [2:0] state_q;

    reg [TAG_WIDTH-1:0] tag_way0_q;
    reg [TAG_WIDTH-1:0] tag_way1_q;
    reg [TAG_WIDTH-1:0] tag_way2_q;
    reg [TAG_WIDTH-1:0] tag_way3_q;

    reg valid_way0_q;
    reg valid_way1_q;
    reg valid_way2_q;
    reg valid_way3_q;

    reg [DATA_WIDTH-1:0] data_way0_q [0:WORDS_PER_LINE-1];
    reg [DATA_WIDTH-1:0] data_way1_q [0:WORDS_PER_LINE-1];
    reg [DATA_WIDTH-1:0] data_way2_q [0:WORDS_PER_LINE-1];
    reg [DATA_WIDTH-1:0] data_way3_q [0:WORDS_PER_LINE-1];

    reg [ADDRESS_WIDTH-1:0] request_address_q;
    reg [LINE_INDEX_WIDTH-1:0] victim_index_q;
    reg [WORD_INDEX_WIDTH-1:0] refill_word_q;
    reg [LINE_INDEX_WIDTH-1:0] replacement_pointer_q;
    reg invalidate_pending_q;

    reg lookup_hit_r;
    reg [LINE_INDEX_WIDTH-1:0] lookup_hit_index_r;
    reg [LINE_INDEX_WIDTH-1:0] selected_victim_index_r;

    wire [TAG_WIDTH-1:0] request_tag_w;
    wire [WORD_INDEX_WIDTH-1:0] request_word_index_w;
    wire [ADDRESS_WIDTH-1:0] line_base_address_w;
    wire [ADDRESS_WIDTH-1:0] refill_word_offset_w;

    assign request_tag_w = request_address_q >> LINE_OFFSET_WIDTH;

    assign request_word_index_w =
        (WORDS_PER_LINE == 1) ?
        {WORD_INDEX_WIDTH{1'b0}} :
        request_address_q >> BYTE_OFFSET_WIDTH;

    assign line_base_address_w =
        (request_address_q >> LINE_OFFSET_WIDTH) << LINE_OFFSET_WIDTH;

    assign refill_word_offset_w =
        {{(ADDRESS_WIDTH-WORD_INDEX_WIDTH){1'b0}}, refill_word_q}
        << BYTE_OFFSET_WIDTH;

    always @(*) begin
        lookup_hit_r = 1'b0;
        lookup_hit_index_r = 2'd0;

        if ((LINE_COUNT >= 1) &&
            valid_way0_q &&
            (tag_way0_q == request_tag_w)) begin
            lookup_hit_r = 1'b1;
            lookup_hit_index_r = 2'd0;
        end else if ((LINE_COUNT >= 2) &&
                     valid_way1_q &&
                     (tag_way1_q == request_tag_w)) begin
            lookup_hit_r = 1'b1;
            lookup_hit_index_r = 2'd1;
        end else if ((LINE_COUNT >= 3) &&
                     valid_way2_q &&
                     (tag_way2_q == request_tag_w)) begin
            lookup_hit_r = 1'b1;
            lookup_hit_index_r = 2'd2;
        end else if ((LINE_COUNT >= 4) &&
                     valid_way3_q &&
                     (tag_way3_q == request_tag_w)) begin
            lookup_hit_r = 1'b1;
            lookup_hit_index_r = 2'd3;
        end
    end

    always @(*) begin
        selected_victim_index_r = replacement_pointer_q;

        if ((LINE_COUNT >= 1) && !valid_way0_q) begin
            selected_victim_index_r = 2'd0;
        end else if ((LINE_COUNT >= 2) && !valid_way1_q) begin
            selected_victim_index_r = 2'd1;
        end else if ((LINE_COUNT >= 3) && !valid_way2_q) begin
            selected_victim_index_r = 2'd2;
        end else if ((LINE_COUNT >= 4) && !valid_way3_q) begin
            selected_victim_index_r = 2'd3;
        end
    end

    always @(*) begin
        cpu_request_ready_o = 1'b0;
        cpu_response_valid_o = 1'b0;
        cpu_read_data_o = {DATA_WIDTH{1'b0}};
        busy_o = 1'b1;
        memory_request_valid_o = 1'b0;
        memory_address_o = {ADDRESS_WIDTH{1'b0}};

        case (state_q)
            ICACHE_IDLE: begin
                cpu_request_ready_o =
                    !invalidate_i && !invalidate_pending_q;
                busy_o = invalidate_i || invalidate_pending_q;
            end

            ICACHE_REFILL_REQUEST: begin
                memory_request_valid_o = 1'b1;
                memory_address_o =
                    line_base_address_w | refill_word_offset_w;
            end

            ICACHE_RESPOND: begin
                cpu_response_valid_o = 1'b1;

                case (victim_index_q)
                    2'd0: begin
                        cpu_read_data_o =
                            data_way0_q[request_word_index_w];
                    end

                    2'd1: begin
                        cpu_read_data_o =
                            data_way1_q[request_word_index_w];
                    end

                    2'd2: begin
                        cpu_read_data_o =
                            data_way2_q[request_word_index_w];
                    end

                    2'd3: begin
                        cpu_read_data_o =
                            data_way3_q[request_word_index_w];
                    end

                    default: begin
                        cpu_read_data_o = {DATA_WIDTH{1'b0}};
                    end
                endcase
            end

            default: begin
                cpu_request_ready_o = 1'b0;
            end
        endcase
    end

    always @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            state_q <= ICACHE_IDLE;
            valid_way0_q <= 1'b0;
            valid_way1_q <= 1'b0;
            valid_way2_q <= 1'b0;
            valid_way3_q <= 1'b0;
            replacement_pointer_q <= 2'd0;
            invalidate_pending_q <= 1'b0;
            hit_count_o <= 32'd0;
            miss_count_o <= 32'd0;
        end else begin
            case (state_q)
                ICACHE_IDLE: begin
                    if (invalidate_i || invalidate_pending_q) begin
                        valid_way0_q <= 1'b0;
                        valid_way1_q <= 1'b0;
                        valid_way2_q <= 1'b0;
                        valid_way3_q <= 1'b0;
                        invalidate_pending_q <= 1'b0;
                    end else if (cpu_request_valid_i) begin
                        request_address_q <= cpu_address_i;
                        state_q <= ICACHE_LOOKUP;
                    end
                end

                ICACHE_LOOKUP: begin
                    if (lookup_hit_r) begin
                        victim_index_q <= lookup_hit_index_r;
                        hit_count_o <= hit_count_o + 1'b1;
                        state_q <= ICACHE_RESPOND;
                    end else begin
                        victim_index_q <= selected_victim_index_r;
                        refill_word_q <= {WORD_INDEX_WIDTH{1'b0}};
                        miss_count_o <= miss_count_o + 1'b1;

                        case (selected_victim_index_r)
                            2'd0: begin
                                valid_way0_q <= 1'b0;
                                tag_way0_q <= request_tag_w;
                            end

                            2'd1: begin
                                valid_way1_q <= 1'b0;
                                tag_way1_q <= request_tag_w;
                            end

                            2'd2: begin
                                valid_way2_q <= 1'b0;
                                tag_way2_q <= request_tag_w;
                            end

                            2'd3: begin
                                valid_way3_q <= 1'b0;
                                tag_way3_q <= request_tag_w;
                            end

                            default: begin
                                valid_way0_q <= 1'b0;
                                tag_way0_q <= request_tag_w;
                            end
                        endcase

                        case (selected_victim_index_r)
                            2'd0: begin
                                if (LINE_COUNT >= 2) begin
                                    replacement_pointer_q <= 2'd1;
                                end else begin
                                    replacement_pointer_q <= 2'd0;
                                end
                            end

                            2'd1: begin
                                if (LINE_COUNT >= 3) begin
                                    replacement_pointer_q <= 2'd2;
                                end else begin
                                    replacement_pointer_q <= 2'd0;
                                end
                            end

                            2'd2: begin
                                if (LINE_COUNT >= 4) begin
                                    replacement_pointer_q <= 2'd3;
                                end else begin
                                    replacement_pointer_q <= 2'd0;
                                end
                            end

                            default: begin
                                replacement_pointer_q <= 2'd0;
                            end
                        endcase

                        state_q <= ICACHE_REFILL_REQUEST;
                    end
                end

                ICACHE_REFILL_REQUEST: begin
                    if (memory_request_ready_i) begin
                        state_q <= ICACHE_REFILL_WAIT;
                    end
                end

                ICACHE_REFILL_WAIT: begin
                    if (memory_response_valid_i) begin
                        case (victim_index_q)
                            2'd0: begin
                                data_way0_q[refill_word_q] <=
                                    memory_read_data_i;
                            end

                            2'd1: begin
                                data_way1_q[refill_word_q] <=
                                    memory_read_data_i;
                            end

                            2'd2: begin
                                data_way2_q[refill_word_q] <=
                                    memory_read_data_i;
                            end

                            2'd3: begin
                                data_way3_q[refill_word_q] <=
                                    memory_read_data_i;
                            end

                            default: begin
                                data_way0_q[refill_word_q] <=
                                    memory_read_data_i;
                            end
                        endcase

                        if (refill_word_q == WORDS_PER_LINE-1) begin
                            case (victim_index_q)
                                2'd0: begin
                                    valid_way0_q <= 1'b1;
                                end

                                2'd1: begin
                                    valid_way1_q <= 1'b1;
                                end

                                2'd2: begin
                                    valid_way2_q <= 1'b1;
                                end

                                2'd3: begin
                                    valid_way3_q <= 1'b1;
                                end

                                default: begin
                                    valid_way0_q <= 1'b1;
                                end
                            endcase

                            state_q <= ICACHE_RESPOND;
                        end else begin
                            refill_word_q <= refill_word_q + 1'b1;
                            state_q <= ICACHE_REFILL_REQUEST;
                        end
                    end
                end

                ICACHE_RESPOND: begin
                    state_q <= ICACHE_IDLE;
                end

                default: begin
                    state_q <= ICACHE_IDLE;
                    valid_way0_q <= 1'b0;
                    valid_way1_q <= 1'b0;
                    valid_way2_q <= 1'b0;
                    valid_way3_q <= 1'b0;
                end
            endcase

            if (invalidate_i && (state_q != ICACHE_IDLE)) begin
                invalidate_pending_q <= 1'b1;
            end
        end
    end

endmodule
