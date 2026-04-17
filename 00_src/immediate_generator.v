module immediate_generator(
    input       [31:0]  i_instructions,
    output reg  [31:0]  o_output
);

    parameter   R_type  = 5'b01100,
                I_type1 = 5'b00000,
                I_type2 = 5'b00100,
                I_type3 = 5'b11001,
                S_type  = 5'b01000,
                B_type  = 5'b11000,
                U_type  = 5'b01101,
                J_type  = 5'b11011;

    always @(*) begin
        case (i_instructions[6:2])
            R_type  : o_output = 32'hxxxx;
            I_type1 : o_output = { {20{i_instructions[31]}}, i_instructions[31:20] };
            I_type2 : o_output = { {20{i_instructions[31]}}, i_instructions[31:20] };
            I_type3 : o_output = { {20{i_instructions[31]}}, i_instructions[31:20] };
            S_type  : o_output = { {20{i_instructions[31]}}, i_instructions[31:25], i_instructions[11:7] };
            B_type  : o_output = { {20{i_instructions[31]}}, i_instructions[7], i_instructions[30:25], i_instructions[11:8], 1'b0 };
            U_type  : o_output = { i_instructions[31:12], 12'b000000000000 };
            J_type  : o_output = { {11{i_instructions[31]}}, i_instructions[31], i_instructions[19:12], i_instructions[20], i_instructions[30:21], 1'b0 };
            default : o_output = 32'h00000000;
        endcase
        
    end

endmodule
