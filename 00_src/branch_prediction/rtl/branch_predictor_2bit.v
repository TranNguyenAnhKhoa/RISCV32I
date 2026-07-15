module branch_predictor_2bit #(
    parameter ENTRY_COUNT = 64
) (
    input         clk_i,
    input         rstn_i,
    input  [31:0] predict_pc_i,
    output        predict_taken_o,
    input         update_valid_i,
    input  [31:0] update_pc_i,
    input         update_taken_i
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

    localparam INDEX_WIDTH = (ENTRY_COUNT <= 1) ? 1 : clog2(ENTRY_COUNT);

    localparam [1:0] STRONGLY_NOT_TAKEN = 2'b00;
    localparam [1:0] WEAKLY_NOT_TAKEN   = 2'b01;
    localparam [1:0] WEAKLY_TAKEN       = 2'b10;
    localparam [1:0] STRONGLY_TAKEN     = 2'b11;

    reg [1:0] counter_table_q [0:ENTRY_COUNT-1];

    wire [INDEX_WIDTH-1:0] predict_index_w;
    wire [INDEX_WIDTH-1:0] update_index_w;

    integer entry_index;

    assign predict_index_w = predict_pc_i[INDEX_WIDTH+1:2];
    assign update_index_w  = update_pc_i[INDEX_WIDTH+1:2];
    assign predict_taken_o = counter_table_q[predict_index_w][1];

    always @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            for (entry_index = 0;
                 entry_index < ENTRY_COUNT;
                 entry_index = entry_index + 1) begin
                counter_table_q[entry_index] <= WEAKLY_NOT_TAKEN;
            end
        end else if (update_valid_i) begin
            case (counter_table_q[update_index_w])
                STRONGLY_NOT_TAKEN: begin
                    if (update_taken_i) begin
                        counter_table_q[update_index_w] <= WEAKLY_NOT_TAKEN;
                    end else begin
                        counter_table_q[update_index_w] <= STRONGLY_NOT_TAKEN;
                    end
                end

                WEAKLY_NOT_TAKEN: begin
                    if (update_taken_i) begin
                        counter_table_q[update_index_w] <= WEAKLY_TAKEN;
                    end else begin
                        counter_table_q[update_index_w] <= STRONGLY_NOT_TAKEN;
                    end
                end

                WEAKLY_TAKEN: begin
                    if (update_taken_i) begin
                        counter_table_q[update_index_w] <= STRONGLY_TAKEN;
                    end else begin
                        counter_table_q[update_index_w] <= WEAKLY_NOT_TAKEN;
                    end
                end

                STRONGLY_TAKEN: begin
                    if (update_taken_i) begin
                        counter_table_q[update_index_w] <= STRONGLY_TAKEN;
                    end else begin
                        counter_table_q[update_index_w] <= WEAKLY_TAKEN;
                    end
                end

                default: begin
                    counter_table_q[update_index_w] <= WEAKLY_NOT_TAKEN;
                end
            endcase
        end
    end

    initial begin
        if ((ENTRY_COUNT < 2) ||
            ((ENTRY_COUNT & (ENTRY_COUNT - 1)) != 0) ||
            (INDEX_WIDTH > 30)) begin
            $display("ERROR: invalid branch_predictor_2bit ENTRY_COUNT");
            $finish;
        end
    end

endmodule
