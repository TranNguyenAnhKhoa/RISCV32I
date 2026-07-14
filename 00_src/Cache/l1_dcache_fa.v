`timescale 1ns/1ps

module l1_dcache_fa #(
    parameter ADDRESS_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter LINE_COUNT = 4,
    parameter WORDS_PER_LINE = 4
) (
    input  wire                     clk_i,
    input  wire                     rstn_i,

    input  wire                     cpu_request_valid_i,
    input  wire                     cpu_write_i,
    input  wire [ADDRESS_WIDTH-1:0] cpu_address_i,
    input  wire [DATA_WIDTH-1:0]    cpu_write_data_i,
    input  wire [3:0]               cpu_write_strobe_i,
    output reg                      cpu_request_ready_o,
    output reg                      cpu_response_valid_o,
    output reg  [DATA_WIDTH-1:0]    cpu_read_data_o,

    input  wire                     flush_i,
    output reg                      flush_busy_o,
    output reg                      flush_done_o,

    output reg                      memory_request_valid_o,
    output reg                      memory_write_o,
    output reg  [ADDRESS_WIDTH-1:0] memory_address_o,
    output reg  [DATA_WIDTH-1:0]    memory_write_data_o,
    output reg  [3:0]               memory_write_strobe_o,
    input  wire                     memory_request_ready_i,
    input  wire                     memory_response_valid_i,
    input  wire [DATA_WIDTH-1:0]    memory_read_data_i,

    output reg  [31:0]              hit_count_o,
    output reg  [31:0]              miss_count_o,
    output reg  [31:0]              writeback_count_o
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

    localparam BYTE_OFFSET_WIDTH = 2;
    localparam LINE_WORD_OFFSET_WIDTH = clog2(WORDS_PER_LINE);
    localparam WORD_INDEX_WIDTH = (WORDS_PER_LINE <= 1) ? 1 : clog2(WORDS_PER_LINE);
    localparam LINE_INDEX_WIDTH = (LINE_COUNT <= 1) ? 1 : clog2(LINE_COUNT);
    localparam TAG_WIDTH = ADDRESS_WIDTH - BYTE_OFFSET_WIDTH - LINE_WORD_OFFSET_WIDTH;
    localparam DATA_ENTRY_COUNT = LINE_COUNT * WORDS_PER_LINE;

    localparam [3:0] DCACHE_IDLE                    = 4'd0;
    localparam [3:0] DCACHE_LOOKUP                  = 4'd1;
    localparam [3:0] DCACHE_WRITEBACK_REQUEST       = 4'd2;
    localparam [3:0] DCACHE_REFILL_REQUEST          = 4'd3;
    localparam [3:0] DCACHE_REFILL_WAIT             = 4'd4;
    localparam [3:0] DCACHE_RESPOND                 = 4'd5;
    localparam [3:0] DCACHE_FLUSH_SCAN              = 4'd6;
    localparam [3:0] DCACHE_FLUSH_WRITEBACK_REQUEST = 4'd7;
    localparam [3:0] DCACHE_FLUSH_DONE              = 4'd8;

    reg [3:0] state_r;

    reg [TAG_WIDTH-1:0] tag_array [0:LINE_COUNT-1];
    reg                 valid_array [0:LINE_COUNT-1];
    reg                 dirty_array [0:LINE_COUNT-1];
    reg [DATA_WIDTH-1:0] data_array [0:DATA_ENTRY_COUNT-1];

    reg [ADDRESS_WIDTH-1:0] request_address_r;
    reg                     request_write_r;
    reg [DATA_WIDTH-1:0]    request_write_data_r;
    reg [3:0]               request_write_strobe_r;
    reg [DATA_WIDTH-1:0]    response_data_r;
    reg                     replay_after_miss_r;

    reg [LINE_INDEX_WIDTH-1:0] victim_index_r;
    reg [LINE_INDEX_WIDTH-1:0] replacement_pointer_r;
    reg [LINE_INDEX_WIDTH-1:0] flush_line_r;
    reg [WORD_INDEX_WIDTH-1:0] transfer_word_r;

    reg lookup_hit;
    reg [LINE_INDEX_WIDTH-1:0] lookup_hit_index;
    reg [LINE_INDEX_WIDTH-1:0] selected_victim_index;
    reg invalid_line_found;
    wire [TAG_WIDTH-1:0] request_tag;
    reg [WORD_INDEX_WIDTH-1:0] request_word_index;

    integer lookup_line_index;
    integer victim_search_index;
    integer sequential_line_index;
    integer byte_index;

    assign request_tag = request_address_r >>
                         (BYTE_OFFSET_WIDTH + LINE_WORD_OFFSET_WIDTH);

    always @(*) begin
        request_word_index = {WORD_INDEX_WIDTH{1'b0}};
        if (WORDS_PER_LINE > 1) begin
            request_word_index = request_address_r >> BYTE_OFFSET_WIDTH;
        end
    end

    always @(*) begin
        lookup_hit       = 1'b0;
        lookup_hit_index = {LINE_INDEX_WIDTH{1'b0}};

        for (lookup_line_index = 0;
             lookup_line_index < LINE_COUNT;
             lookup_line_index = lookup_line_index + 1) begin
            if (valid_array[lookup_line_index] &&
                (tag_array[lookup_line_index] == request_tag)) begin
                lookup_hit       = 1'b1;
                lookup_hit_index = lookup_line_index;
            end
        end
    end

    always @(*) begin
        selected_victim_index = replacement_pointer_r;
        invalid_line_found    = 1'b0;

        for (victim_search_index = 0;
             victim_search_index < LINE_COUNT;
             victim_search_index = victim_search_index + 1) begin
            if (!invalid_line_found && !valid_array[victim_search_index]) begin
                selected_victim_index = victim_search_index;
                invalid_line_found    = 1'b1;
            end
        end
    end

    always @(*) begin
        cpu_request_ready_o    = (state_r == DCACHE_IDLE) && !flush_i;
        cpu_response_valid_o   = (state_r == DCACHE_RESPOND);
        cpu_read_data_o        = response_data_r;
        flush_busy_o           = (state_r == DCACHE_FLUSH_SCAN) ||
                                 (state_r == DCACHE_FLUSH_WRITEBACK_REQUEST);
        flush_done_o           = (state_r == DCACHE_FLUSH_DONE);

        memory_request_valid_o = 1'b0;
        memory_write_o         = 1'b0;
        memory_address_o       = {ADDRESS_WIDTH{1'b0}};
        memory_write_data_o    = {DATA_WIDTH{1'b0}};
        memory_write_strobe_o  = 4'b0000;

        case (state_r)
            DCACHE_WRITEBACK_REQUEST: begin
                memory_request_valid_o = 1'b1;
                memory_write_o         = 1'b1;
                memory_write_data_o    = data_array[(victim_index_r * WORDS_PER_LINE) +
                                                     transfer_word_r];
                memory_write_strobe_o  = 4'b1111;
                memory_address_o       = (tag_array[victim_index_r] <<
                                          LINE_WORD_OFFSET_WIDTH) <<
                                          BYTE_OFFSET_WIDTH;
                memory_address_o       = memory_address_o |
                                          (transfer_word_r << BYTE_OFFSET_WIDTH);
            end

            DCACHE_REFILL_REQUEST: begin
                memory_request_valid_o = 1'b1;
                memory_write_o         = 1'b0;
                memory_address_o       = (request_address_r >>
                                         (BYTE_OFFSET_WIDTH + LINE_WORD_OFFSET_WIDTH)) <<
                                         (BYTE_OFFSET_WIDTH + LINE_WORD_OFFSET_WIDTH);
                memory_address_o       = memory_address_o |
                                         (transfer_word_r << BYTE_OFFSET_WIDTH);
            end

            DCACHE_FLUSH_WRITEBACK_REQUEST: begin
                memory_request_valid_o = 1'b1;
                memory_write_o         = 1'b1;
                memory_write_data_o    = data_array[(flush_line_r * WORDS_PER_LINE) +
                                                     transfer_word_r];
                memory_write_strobe_o  = 4'b1111;
                memory_address_o       = (tag_array[flush_line_r] <<
                                          LINE_WORD_OFFSET_WIDTH) <<
                                          BYTE_OFFSET_WIDTH;
                memory_address_o       = memory_address_o |
                                          (transfer_word_r << BYTE_OFFSET_WIDTH);
            end

            default: begin
                memory_request_valid_o = 1'b0;
            end
        endcase
    end

    always @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            state_r                <= DCACHE_IDLE;
            request_address_r      <= {ADDRESS_WIDTH{1'b0}};
            request_write_r        <= 1'b0;
            request_write_data_r   <= {DATA_WIDTH{1'b0}};
            request_write_strobe_r <= 4'b0000;
            response_data_r        <= {DATA_WIDTH{1'b0}};
            replay_after_miss_r    <= 1'b0;
            victim_index_r         <= {LINE_INDEX_WIDTH{1'b0}};
            replacement_pointer_r  <= {LINE_INDEX_WIDTH{1'b0}};
            flush_line_r           <= {LINE_INDEX_WIDTH{1'b0}};
            transfer_word_r        <= {WORD_INDEX_WIDTH{1'b0}};
            hit_count_o            <= 32'b0;
            miss_count_o           <= 32'b0;
            writeback_count_o      <= 32'b0;

            for (sequential_line_index = 0;
                 sequential_line_index < LINE_COUNT;
                 sequential_line_index = sequential_line_index + 1) begin
                valid_array[sequential_line_index] <= 1'b0;
                dirty_array[sequential_line_index] <= 1'b0;
                tag_array[sequential_line_index]   <= {TAG_WIDTH{1'b0}};
            end
        end else begin
            case (state_r)
                DCACHE_IDLE: begin
                    if (flush_i) begin
                        flush_line_r <= {LINE_INDEX_WIDTH{1'b0}};
                        state_r      <= DCACHE_FLUSH_SCAN;
                    end else if (cpu_request_valid_i) begin
                        request_address_r      <= cpu_address_i;
                        request_write_r        <= cpu_write_i;
                        request_write_data_r   <= cpu_write_data_i;
                        request_write_strobe_r <= cpu_write_strobe_i;
                        replay_after_miss_r    <= 1'b0;
                        state_r                <= DCACHE_LOOKUP;
                    end
                end

                DCACHE_LOOKUP: begin
                    if (lookup_hit) begin
                        if (!replay_after_miss_r) begin
                            hit_count_o <= hit_count_o + 1'b1;
                        end

                        if (request_write_r) begin
                            for (byte_index = 0; byte_index < 4; byte_index = byte_index + 1) begin
                                if (request_write_strobe_r[byte_index]) begin
                                    data_array[(lookup_hit_index * WORDS_PER_LINE) +
                                               request_word_index][byte_index*8 +: 8]
                                        <= request_write_data_r[byte_index*8 +: 8];
                                end
                            end
                            dirty_array[lookup_hit_index] <= 1'b1;
                            response_data_r               <= {DATA_WIDTH{1'b0}};
                        end else begin
                            response_data_r <= data_array[(lookup_hit_index * WORDS_PER_LINE) +
                                                          request_word_index];
                        end

                        replay_after_miss_r <= 1'b0;
                        state_r             <= DCACHE_RESPOND;
                    end else begin
                        victim_index_r      <= selected_victim_index;
                        transfer_word_r     <= {WORD_INDEX_WIDTH{1'b0}};
                        replay_after_miss_r <= 1'b1;
                        miss_count_o        <= miss_count_o + 1'b1;

                        if (selected_victim_index == LINE_COUNT-1) begin
                            replacement_pointer_r <= {LINE_INDEX_WIDTH{1'b0}};
                        end else begin
                            replacement_pointer_r <= selected_victim_index + 1'b1;
                        end

                        if (valid_array[selected_victim_index] &&
                            dirty_array[selected_victim_index]) begin
                            writeback_count_o <= writeback_count_o + 1'b1;
                            state_r           <= DCACHE_WRITEBACK_REQUEST;
                        end else begin
                            valid_array[selected_victim_index] <= 1'b0;
                            dirty_array[selected_victim_index] <= 1'b0;
                            tag_array[selected_victim_index]   <= request_tag;
                            state_r                            <= DCACHE_REFILL_REQUEST;
                        end
                    end
                end

                DCACHE_WRITEBACK_REQUEST: begin
                    if (memory_request_ready_i) begin
                        if (transfer_word_r == WORDS_PER_LINE-1) begin
                            valid_array[victim_index_r] <= 1'b0;
                            dirty_array[victim_index_r] <= 1'b0;
                            tag_array[victim_index_r]   <= request_tag;
                            transfer_word_r             <= {WORD_INDEX_WIDTH{1'b0}};
                            state_r                     <= DCACHE_REFILL_REQUEST;
                        end else begin
                            transfer_word_r <= transfer_word_r + 1'b1;
                        end
                    end
                end

                DCACHE_REFILL_REQUEST: begin
                    if (memory_request_ready_i) begin
                        state_r <= DCACHE_REFILL_WAIT;
                    end
                end

                DCACHE_REFILL_WAIT: begin
                    if (memory_response_valid_i) begin
                        data_array[(victim_index_r * WORDS_PER_LINE) + transfer_word_r]
                            <= memory_read_data_i;

                        if (transfer_word_r == WORDS_PER_LINE-1) begin
                            valid_array[victim_index_r] <= 1'b1;
                            dirty_array[victim_index_r] <= 1'b0;
                            transfer_word_r             <= {WORD_INDEX_WIDTH{1'b0}};
                            state_r                     <= DCACHE_LOOKUP;
                        end else begin
                            transfer_word_r <= transfer_word_r + 1'b1;
                            state_r         <= DCACHE_REFILL_REQUEST;
                        end
                    end
                end

                DCACHE_RESPOND: begin
                    state_r <= DCACHE_IDLE;
                end

                DCACHE_FLUSH_SCAN: begin
                    if (valid_array[flush_line_r] && dirty_array[flush_line_r]) begin
                        transfer_word_r <= {WORD_INDEX_WIDTH{1'b0}};
                        state_r         <= DCACHE_FLUSH_WRITEBACK_REQUEST;
                    end else begin
                        valid_array[flush_line_r] <= 1'b0;
                        dirty_array[flush_line_r] <= 1'b0;

                        if (flush_line_r == LINE_COUNT-1) begin
                            state_r <= DCACHE_FLUSH_DONE;
                        end else begin
                            flush_line_r <= flush_line_r + 1'b1;
                        end
                    end
                end

                DCACHE_FLUSH_WRITEBACK_REQUEST: begin
                    if (memory_request_ready_i) begin
                        if (transfer_word_r == WORDS_PER_LINE-1) begin
                            valid_array[flush_line_r] <= 1'b0;
                            dirty_array[flush_line_r] <= 1'b0;
                            transfer_word_r           <= {WORD_INDEX_WIDTH{1'b0}};

                            if (flush_line_r == LINE_COUNT-1) begin
                                state_r <= DCACHE_FLUSH_DONE;
                            end else begin
                                flush_line_r <= flush_line_r + 1'b1;
                                state_r      <= DCACHE_FLUSH_SCAN;
                            end
                        end else begin
                            transfer_word_r <= transfer_word_r + 1'b1;
                        end
                    end
                end

                DCACHE_FLUSH_DONE: begin
                    state_r <= DCACHE_IDLE;
                end

                default: begin
                    state_r <= DCACHE_IDLE;
                end
            endcase
        end
    end

    initial begin
        if ((DATA_WIDTH != 32) ||
            (LINE_COUNT < 1) ||
            (WORDS_PER_LINE < 1) ||
            ((WORDS_PER_LINE & (WORDS_PER_LINE-1)) != 0)) begin
            $display("ERROR: invalid l1_dcache_fa parameters");
            $finish;
        end
    end
endmodule
