module forwarding(

    input             i_reg_write_EXMEM  ,
    input             i_reg_write_MEMWB  ,
    input       [4:0] i_rs1_IDEX         ,
    input       [4:0] i_rs2_IDEX         ,
    input       [4:0] i_rd_EXMEM         ,
    input       [4:0] i_rd_MEMWB         ,

    output reg  [1:0] o_mux_ALU1         , 
    output reg  [1:0] o_mux_ALU2

);
    always @(*) begin

        if ((i_reg_write_EXMEM) && (i_rd_EXMEM != 0) && (i_rd_EXMEM == i_rs1_IDEX)) begin
            o_mux_ALU1 = 2'b01;
        end else if ((i_reg_write_MEMWB) && (i_rd_MEMWB != 0) && (i_rd_MEMWB == i_rs1_IDEX)) begin
            o_mux_ALU1 = 2'b10;
        end else begin
            o_mux_ALU1 = 2'b00;
        end

        if ((i_reg_write_EXMEM) && (i_rd_EXMEM != 0) && (i_rd_MEMWB == i_rs2_IDEX)) begin
            o_mux_ALU2 = 2'b01;
        end else if ((i_reg_write_MEMWB) && (i_rd_MEMWB != 0) && (i_rd_MEMWB == i_rs2_IDEX)) begin
            o_mux_ALU2 = 2'b10;
        end else begin
            o_mux_ALU2 = 2'b00;
        end
    end
        


endmodule
