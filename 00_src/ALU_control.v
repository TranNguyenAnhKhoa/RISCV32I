module ALU_control(
    input       [1:0] i_ALUOp,
    input       [2:0] i_funct3,
    input             i_funct7_30,

    output reg  [3:0] o_ALUCtrl
);

    always @(*) begin
        case (i_ALUOp)
            2'b00: begin // lw/sw
                o_ALUCtrl  = 4'b0000;
            end
            
            2'b01: begin //branch
                o_ALUCtrl  = 4'b1000; // sub
            end
            
            2'b10: begin // R-type/I-type
                case (i_funct3)
                    3'b000: o_ALUCtrl = {i_funct7_30, i_funct3};
                    3'b001: o_ALUCtrl = 4'b0001;
                    //3'b010: 
                    //3'b011:
                    3'b100: o_ALUCtrl = 4'b0100;
                    3'b101: o_ALUCtrl = {i_funct7_30, i_funct3};
                    3'b110: o_ALUCtrl = 4'b0110;
                    default: o_ALUCtrl = 4'b0000;
                endcase
            end
            
            2'b11: begin // jump/add
                    o_ALUCtrl = 4'b1111;
            end

            default: o_ALUCtrl  = 4'b0000;
        endcase
    end

endmodule
