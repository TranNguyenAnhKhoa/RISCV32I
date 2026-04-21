module immediate_generator(
    input  [31:0]  instruction_i,
    output [31:0]  output_o
);
    reg [31:0] output_r;

    parameter   R_type  = 5'b01100,
                I_type1 = 5'b00000,
                I_type2 = 5'b00100,
                I_type3 = 5'b11001,
                S_type  = 5'b01000,
                B_type  = 5'b11000,
                U_type  = 5'b01101,
                J_type  = 5'b11011;

    always @(*) begin
        case (instruction_i[6:2])
            R_type  : output_r = 32'hxxxx;
            I_type1 : output_r = { {20{instruction_i[31]}}, instruction_i[31:20] };
            I_type2 : output_r = { {20{instruction_i[31]}}, instruction_i[31:20] };
            I_type3 : output_r = { {20{instruction_i[31]}}, instruction_i[31:20] };
            S_type  : output_r = { {20{instruction_i[31]}}, instruction_i[31:25], instruction_i[11:7] };
            B_type  : output_r = { {20{instruction_i[31]}}, instruction_i[7], instruction_i[30:25], instruction_i[11:8], 1'b0 };
            U_type  : output_r = { instruction_i[31:12], 12'b000000000000 };
            J_type  : output_r = { {11{instruction_i[31]}}, instruction_i[31], instruction_i[19:12], instruction_i[20], instruction_i[30:21], 1'b0 };
            default : output_r = 32'h00000000;
        endcase
        
    end

    assign output_o = output_r;

endmodule
