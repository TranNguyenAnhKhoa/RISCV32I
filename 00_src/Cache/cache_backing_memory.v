`timescale 1ns/1ps

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

    localparam MEMORY_INDEX_WIDTH = (WORD_COUNT <= 1) ? 1 : clog2(WORD_COUNT);
    localparam LATENCY_COUNTER_WIDTH = (READ_LATENCY <= 1) ? 1 : clog2(READ_LATENCY);

    reg [DATA_WIDTH-1:0] memory [0:WORD_COUNT-1];
    reg                  pending_read_r;
    reg [MEMORY_INDEX_WIDTH-1:0] pending_index_r;
    reg [LATENCY_COUNTER_WIDTH-1:0] latency_counter_r;

    integer byte_index;

    assign memory_request_ready_o = ready_enable_i && !pending_read_r;

    always @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            pending_read_r          <= 1'b0;
            pending_index_r         <= {MEMORY_INDEX_WIDTH{1'b0}};
            latency_counter_r       <= {LATENCY_COUNTER_WIDTH{1'b0}};
            memory_response_valid_o <= 1'b0;
            memory_read_data_o      <= {DATA_WIDTH{1'b0}};
        end else begin
            memory_response_valid_o <= 1'b0;

            if (pending_read_r) begin
                if (latency_counter_r == 0) begin
                    memory_read_data_o      <= memory[pending_index_r];
                    memory_response_valid_o <= 1'b1;
                    pending_read_r          <= 1'b0;
                end else begin
                    latency_counter_r <= latency_counter_r - 1'b1;
                end
            end

            if (memory_request_valid_i && memory_request_ready_o) begin
                if (memory_write_i) begin
                    for (byte_index = 0; byte_index < 4; byte_index = byte_index + 1) begin
                        if (memory_write_strobe_i[byte_index]) begin
                            memory[memory_address_i[MEMORY_INDEX_WIDTH+1:2]][byte_index*8 +: 8]
                                <= memory_write_data_i[byte_index*8 +: 8];
                        end
                    end
                end else begin
                    pending_read_r    <= 1'b1;
                    pending_index_r   <= memory_address_i[MEMORY_INDEX_WIDTH+1:2];
                    latency_counter_r <= READ_LATENCY-1;
                end
            end
        end
    end

    initial begin
        if ((DATA_WIDTH != 32) ||
            (WORD_COUNT < 1) ||
            (READ_LATENCY < 1)) begin
            $display("ERROR: invalid cache_backing_memory parameters");
            $finish;
        end
    end
endmodule
