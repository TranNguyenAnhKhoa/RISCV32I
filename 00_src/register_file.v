
module register_file(
    input          i_clk,
    input          i_rstn,
    input  [4:0]   i_read_reg1,
    input  [4:0]   i_read_reg2,
    input  [4:0]   i_write_reg,
    
    input  [31:0]  i_write_data,
    input          i_reg_write_en,

    output [31:0]  o_read_data1,
    output [31:0]  o_read_data2
);

    reg [31:0]  register [31:0];

    always @(posedge i_clk) begin
        if(i_rstn) begin
            register[0] <= 32'h0;
            register[1] <= 32'h0;
            register[2] <= 32'h0;
            register[3] <= 32'h0;
            register[4] <= 32'h0;
            register[5] <= 32'h0;
            register[6] <= 32'h0;
            register[7] <= 32'h0;
            register[8] <= 32'h0;
            register[9] <= 32'h0;
            register[10] <= 32'h0;
            register[11] <= 32'h0;
            register[12] <= 32'h0;
            register[13] <= 32'h0;
            register[14] <= 32'h0;
            register[15] <= 32'h0;
            register[16] <= 32'h0;
            register[17] <= 32'h0;
            register[18] <= 32'h0;
            register[19] <= 32'h0;
            register[20] <= 32'h0;
            register[21] <= 32'h0;
            register[22] <= 32'h0;
            register[23] <= 32'h0;
            register[24] <= 32'h0;
            register[25] <= 32'h0;
            register[26] <= 32'h0;
            register[27] <= 32'h0;
            register[28] <= 32'h0;
            register[29] <= 32'h0;
            register[30] <= 32'h0;
            register[31] <= 32'h0;
        end
        else if ( (i_reg_write_en) && (!(i_write_reg == 5'b00000)) ) begin
            register[i_write_reg] <= i_write_data;
        end
    end

    assign o_read_data1 = register[i_read_reg1];
    assign o_read_data2 = register[i_read_reg2];

endmodule
