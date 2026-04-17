// module ALU(
//     input       [31:0] i_input1, 
//     input       [31:0] i_input2,
//     input       [3:0]  i_ALUCtrl,
//     output reg  [31:0] o_resutl
// );

//     wire [31:0] w_input2n = ~ i_input2;

//     always @(*) begin
//         case (i_ALUCtrl)
//             // ---- ADD/SUB (funct3=000) --- 
//             4'b0000: o_resutl = i_input1 + i_input2; //add
//             4'b1000: o_resutl = i_input1 + w_input2n + 1; //sub
            
//             // ---- shift left (funct3=001) --- 
//             4'b0001: o_resutl = i_input1 << i_input2[4:0];//sll
            
//             // ---- compare (funct3=010, 011) --- 
//             //4'b0010: //signed
//             //4'b0011: //unsigned
            
//             // ---- XOR (funct3=100) --- 
//             4'b0100: o_resutl = i_input1 ^ i_input2; //xor
            
//             // ---- shift right (funct3=101) --- 
//             4'b0101:  o_resutl = i_input1 >> i_input2[4:0];// srl// logic
//             4'b1101:  o_resutl = i_input1 >> i_input2[4:0];// sarl arithmetic
            
//             // ---- OR (funct3=110) --- 
//             4'b0110: o_resutl = i_input1 | i_input2; //or
            
//             // ---- AND (funct3=111) --- 
//             4'b0111: o_resutl = i_input1 & i_input2; //and

//             //4'b1001:
//             //4'b1010:
//             //4'b1011:
//             //4'b1100:
//             //4'b1110:

//             4'b1111: o_resutl = i_input2; // lui

//             default: o_resutl = 32'hDEAD;
//         endcase

//     end

// endmodule

module ALU (
    input   [31:0] A_i, 
    input   [31:0] B_i,
    input   [3:0]  op_i,

    output  [31:0] result_o
);
    //----------------------------------------
    //              REG & WIRE
    //---------------------------------------- 
    wire [31:0] sub_res_w = A_i - B_i;
    reg [31:0] result_r;

    assign result_o = result_r
    always @(A_i or B_i or op_i or sub_res_w) begin
        case (op_i)
            // ---- ADD/SUB (funct3=000) --- 
            `ALU_ADD: result_r = A_i + B_i;
            `ALU_SUB: result_r = sub_res_w;
            
            // ---- OR (funct3=110) --- 
            `ALU_OR: o_resutl = i_input1 | i_input2; 
            // ---- AND (funct3=111) --- 
            `ALU_AND: o_resutl = i_input1 & i_input2; 
            // ---- XOR (funct3=100) --- 
            `ALU_XOR: o_resutl = i_input1 ^ i_input2;
            
            // ---- shift left (funct3=001) --- 
            // barrel shifter
            `ALU_SHIFTL: begin
                
            end
            `ALU_SHIFTR:
            `ALU_SHIFTR_ARITH:
        endcase
    end
endmodule
