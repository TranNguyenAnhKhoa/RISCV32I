(* use_dsp = "no" *)
module branch_predictor_2bit #(
    parameter ENTRY_COUNT         = 64,
    parameter RESET_ON_SOFT_RESET = 0
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

    localparam [1:0] WEAKLY_NOT_TAKEN = 2'b01;

    /*
     * An asynchronous lookup and a synchronous write match FPGA distributed
     * RAM. Keeping reset out of this process prevents the prediction table
     * from becoming a bank of resettable flip-flops and large read muxes.
     */
    (* ram_style = "distributed" *)
    reg [1:0] counter_table_q [0:ENTRY_COUNT-1];

    wire [INDEX_WIDTH-1:0] predict_index_w;
    wire [INDEX_WIDTH-1:0] update_index_w;
    wire                   update_entry_valid_w;
    wire [1:0]             counter_stored_w;
    wire [1:0]             counter_current_w;
    wire [1:0]             counter_next_w;

    integer entry_index;

    assign predict_index_w  = predict_pc_i[INDEX_WIDTH+1:2];
    assign update_index_w   = update_pc_i[INDEX_WIDTH+1:2];
    assign counter_stored_w  = counter_table_q[update_index_w];
    assign counter_current_w = update_entry_valid_w
                             ? counter_stored_w
                             : WEAKLY_NOT_TAKEN;

    /*
     * Two three-input Boolean equations implement the complete saturating
     * counter transition table. They avoid an adder/subtractor and cannot
     * infer a DSP block.
     */
    assign counter_next_w[1] = update_taken_i
                             ? (counter_current_w[1] | counter_current_w[0])
                             : (counter_current_w[1] & counter_current_w[0]);

    assign counter_next_w[0] = update_taken_i
                             ? (counter_current_w[1] | ~counter_current_w[0])
                             : (counter_current_w[1] & ~counter_current_w[0]);

    generate
        if (RESET_ON_SOFT_RESET != 0) begin : generate_soft_reset
            /*
             * Reset only a one-bit validity plane. The 2-bit state plane stays
             * LUTRAM, while every invalid entry behaves exactly as 2'b01.
             */
            reg [ENTRY_COUNT-1:0] counter_valid_q;

            always @(posedge clk_i or negedge rstn_i) begin
                if (!rstn_i) begin
                    counter_valid_q <= {ENTRY_COUNT{1'b0}};
                end else if (update_valid_i) begin
                    counter_valid_q[update_index_w] <= 1'b1;
                end
            end

            assign update_entry_valid_w = counter_valid_q[update_index_w];
            assign predict_taken_o      = counter_valid_q[predict_index_w] &&
                                          counter_table_q[predict_index_w][1];
        end else begin : generate_retain_history
            /*
             * Lowest-resource FPGA mode: lookup is one LUTRAM read with no
             * validity mux. Soft reset retains non-architectural history.
             */
            assign update_entry_valid_w = 1'b1;
            assign predict_taken_o      =
                counter_table_q[predict_index_w][1];
        end
    endgenerate

    /*
     * FPGA configuration initializes LUTRAM to weakly-not-taken. A soft CPU
     * reset disables training. With RESET_ON_SOFT_RESET=0 (default), history
     * is intentionally retained because predictor state is non-architectural.
     * Set RESET_ON_SOFT_RESET=1 when every soft reset must logically clear it.
     */
    initial begin
        for (entry_index = 0;
             entry_index < ENTRY_COUNT;
             entry_index = entry_index + 1) begin
            counter_table_q[entry_index] = WEAKLY_NOT_TAKEN;
        end
    end

    always @(posedge clk_i) begin
        if (rstn_i && update_valid_i) begin
            counter_table_q[update_index_w] <= counter_next_w;
        end
    end

    // synthesis translate_off
    initial begin
        if ((ENTRY_COUNT < 2) ||
            ((ENTRY_COUNT & (ENTRY_COUNT - 1)) != 0) ||
            (INDEX_WIDTH > 30) ||
            ((RESET_ON_SOFT_RESET != 0) &&
             (RESET_ON_SOFT_RESET != 1))) begin
            $display("ERROR: invalid branch_predictor_2bit parameter");
            $finish;
        end
    end
    // synthesis translate_on

endmodule
