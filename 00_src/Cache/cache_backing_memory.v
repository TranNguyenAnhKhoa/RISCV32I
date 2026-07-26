`timescale 1ns/1ps

/*
 * Behavioral backing memory used by cache_l1_tb.
 *
 * The memory array is intentionally not reset. This matches a macro-oriented
 * ASIC style and avoids creating a reset tree across every stored data bit.
 */
module cache_backing_memory #(
    parameter ADDRESS_WIDTH = 32,
    parameter DATA_WIDTH = 32,
    parameter WORD_COUNT = 256,
    parameter READ_LATENCY = 2
) (
    input  wire                     clk_i,
    input  wire                     rstn_i,
    input  wire                     ready_enable_i,
    input  wire                     memory_request_valid_i,
    input  wire                     memory_write_i,
    input  wire [ADDRESS_WIDTH-1:0] memory_address_i,
    input  wire [DATA_WIDTH-1:0]    memory_write_data_i,
    input  wire [3:0]               memory_write_strobe_i,
    output wire                     memory_request_ready_o,
    output reg                      memory_response_valid_o,
    output reg  [DATA_WIDTH-1:0]    memory_read_data_o
);

    localparam MEMORY_INDEX_WIDTH =
        (WORD_COUNT <= 2)     ? 1  :
        (WORD_COUNT <= 4)     ? 2  :
        (WORD_COUNT <= 8)     ? 3  :
        (WORD_COUNT <= 16)    ? 4  :
        (WORD_COUNT <= 32)    ? 5  :
        (WORD_COUNT <= 64)    ? 6  :
        (WORD_COUNT <= 128)   ? 7  :
        (WORD_COUNT <= 256)   ? 8  :
        (WORD_COUNT <= 512)   ? 9  :
        (WORD_COUNT <= 1024)  ? 10 :
        (WORD_COUNT <= 2048)  ? 11 :
        (WORD_COUNT <= 4096)  ? 12 :
        (WORD_COUNT <= 8192)  ? 13 :
        (WORD_COUNT <= 16384) ? 14 :
        (WORD_COUNT <= 32768) ? 15 : 16;

    localparam LATENCY_COUNTER_WIDTH =
        (READ_LATENCY <= 2)   ? 1 :
        (READ_LATENCY <= 4)   ? 2 :
        (READ_LATENCY <= 8)   ? 3 :
        (READ_LATENCY <= 16)  ? 4 :
        (READ_LATENCY <= 32)  ? 5 :
        (READ_LATENCY <= 64)  ? 6 :
        (READ_LATENCY <= 128) ? 7 : 8;

    reg [DATA_WIDTH-1:0] memory [0:WORD_COUNT-1];
    reg                  pending_read_q;
    reg [MEMORY_INDEX_WIDTH-1:0] pending_index_q;
    reg [LATENCY_COUNTER_WIDTH-1:0] latency_counter_q;

    wire [MEMORY_INDEX_WIDTH-1:0] request_index_w;
    wire                          request_handshake_w;

    assign request_index_w =
        memory_address_i[MEMORY_INDEX_WIDTH+1:2];

    assign memory_request_ready_o =
        ready_enable_i && !pending_read_q;

    assign request_handshake_w =
        memory_request_valid_i && memory_request_ready_o;

    always @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            pending_read_q          <= 1'b0;
            pending_index_q         <= {MEMORY_INDEX_WIDTH{1'b0}};
            latency_counter_q       <= {LATENCY_COUNTER_WIDTH{1'b0}};
            memory_response_valid_o <= 1'b0;
            memory_read_data_o      <= {DATA_WIDTH{1'b0}};
        end else begin
            memory_response_valid_o <= 1'b0;

            if (pending_read_q) begin
                if (latency_counter_q == 0) begin
                    memory_read_data_o      <= memory[pending_index_q];
                    memory_response_valid_o <= 1'b1;
                    pending_read_q          <= 1'b0;
                end else begin
                    latency_counter_q <= latency_counter_q - 1'b1;
                end
            end

            if (request_handshake_w) begin
                if (memory_write_i) begin
                    if (memory_write_strobe_i[0]) begin
                        memory[request_index_w][7:0] <=
                            memory_write_data_i[7:0];
                    end

                    if (memory_write_strobe_i[1]) begin
                        memory[request_index_w][15:8] <=
                            memory_write_data_i[15:8];
                    end

                    if (memory_write_strobe_i[2]) begin
                        memory[request_index_w][23:16] <=
                            memory_write_data_i[23:16];
                    end

                    if (memory_write_strobe_i[3]) begin
                        memory[request_index_w][31:24] <=
                            memory_write_data_i[31:24];
                    end
                end else begin
                    pending_read_q    <= 1'b1;
                    pending_index_q   <= request_index_w;
                    latency_counter_q <= READ_LATENCY - 1;
                end
            end
        end
    end

endmodule
