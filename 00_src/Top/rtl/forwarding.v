module forwarding(
    input        reg_write_EXMEM_i,
    input        reg_write_MEMWB_i,
    input  [4:0] rs1_IDEX_i,
    input  [4:0] rs2_IDEX_i,
    input  [4:0] rd_EXMEM_i,
    input  [4:0] rd_MEMWB_i,
    output reg [1:0] mux_ALU1_o,
    output reg [1:0] mux_ALU2_o
);

    always @(*) begin
        mux_ALU1_o = 2'b00;
        mux_ALU2_o = 2'b00;

        if (
            reg_write_EXMEM_i &&
            (rd_EXMEM_i != 5'd0) &&
            (rd_EXMEM_i == rs1_IDEX_i)
        ) begin
            mux_ALU1_o = 2'b01;
        end else if (
            reg_write_MEMWB_i &&
            (rd_MEMWB_i != 5'd0) &&
            (rd_MEMWB_i == rs1_IDEX_i)
        ) begin
            mux_ALU1_o = 2'b10;
        end

        if (
            reg_write_EXMEM_i &&
            (rd_EXMEM_i != 5'd0) &&
            (rd_EXMEM_i == rs2_IDEX_i)
        ) begin
            mux_ALU2_o = 2'b01;
        end else if (
            reg_write_MEMWB_i &&
            (rd_MEMWB_i != 5'd0) &&
            (rd_MEMWB_i == rs2_IDEX_i)
        ) begin
            mux_ALU2_o = 2'b10;
        end
    end

endmodule
