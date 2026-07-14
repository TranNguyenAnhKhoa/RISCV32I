module ALU(
    input  [31:0] A_i,
    input  [31:0] B_i,
    input  [3:0]  ALUCtrl_i,
    output reg [31:0] result_o
);

    always @(*) begin
        case (ALUCtrl_i)
            4'b0000: result_o = A_i + B_i;
            4'b0001: result_o = A_i << B_i[4:0];
            4'b0010: result_o = ($signed(A_i) < $signed(B_i)) ? 32'd1 : 32'd0;
            4'b0011: result_o = (A_i < B_i) ? 32'd1 : 32'd0;
            4'b0100: result_o = A_i ^ B_i;
            4'b0101: result_o = A_i >> B_i[4:0];
            4'b0110: result_o = A_i | B_i;
            4'b0111: result_o = A_i & B_i;
            4'b1000: result_o = A_i - B_i;
            4'b1101: result_o = $signed(A_i) >>> B_i[4:0];
            4'b1111: result_o = B_i;
            default: result_o = 32'h0000_0000;
        endcase
    end

endmodule
