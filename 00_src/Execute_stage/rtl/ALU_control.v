module ALU_control(
    input       [1:0] ALUOp_i,
    input       [2:0] funct3_i,
    input             funct7_30_i,

    output reg  [3:0] ALUctrl_o
);

    assign ALUctrl_o =  (ALUOp_i == 2'b00) ? 4'b0000 :
                        (ALUOp_i == 2'b01) ? 4'b1000 :
                        (ALUOp_i == 2'b10) ? (
                                                (funct3_i == 3'b000) ? {funct7_30_i, funct3_i} :
                                                (funct3_i == 3'b001) ? 4'b0001                 :
                                                (funct3_i == 3'b100) ? 4'b0100                 :
                                                (funct3_i == 3'b101) ? {funct7_30_i, funct3_i} :
                                                (funct3_i == 3'b110) ? 4'b0110 : 4'b0000        
                                              ) :
                        (ALUOp_i == 2'b11) ?  4'b1111 : 
                        4'b0000;
    // always @(*) begin
    //     case (ALUOp_i)
    //         2'b00: begin // lw/sw
    //             ALUctrl_o  = 4'b0000;
    //         end
            
    //         2'b01: begin //branch
    //             ALUctrl_o  = 4'b1000; // sub
    //         end
            
    //         2'b10: begin // R-type/I-type
    //             case (funct3_i)
    //                 3'b000: ALUctrl_o = {funct7_30_i, funct3_i};
    //                 3'b001: ALUctrl_o = 4'b0001;
    //                 //3'b010: 
    //                 //3'b011:
    //                 3'b100: ALUctrl_o = 4'b0100;
    //                 3'b101: ALUctrl_o = {funct7_30_i, funct3_i};
    //                 3'b110: ALUctrl_o = 4'b0110;
    //                 default: ALUctrl_o = 4'b0000;
    //             endcase
    //         end
            
    //         2'b11: begin // jump/add
    //                 ALUctrl_o = 4'b1111;
    //         end

    //         default: ALUctrl_o  = 4'b0000;
    //     endcase
    // end

endmodule
