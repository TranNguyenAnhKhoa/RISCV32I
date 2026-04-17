module comparator(
    input       [31:0]  i_input1, i_input2,
    input       [2:0]   i_funct3,
    output reg          o_branch_taken // take the branch or not

);
    wire w_equal, w_slt, w_ult;
// take the branch if ....
    parameter   equal                   = 3'b000,
                not_equal               = 3'b001,
                less_than               = 3'b100,
                greater_than_or_eq      = 3'b101,
                less_than_u             = 3'b110,
                greater_than_or_eq_u    = 3'b111;
    
    assign w_equal  = (i_input1 == i_input2);
    assign w_ult    = (i_input1 < i_input2);
    always @(*) begin
        case (i_funct3)
            equal               : o_branch_taken = (w_equal ) ? 1:0;
            not_equal           : o_branch_taken = (~w_equal) ? 1:0;
            less_than           : o_branch_taken = (i_input1[31] != i_input2[31]) ? i_input1[31]:w_ult ; // signed
            greater_than_or_eq  : o_branch_taken = (i_input1[31] != i_input2[31]) ? i_input2[31]:~w_ult ; // signed
            less_than_u         : o_branch_taken = (w_ult) ? 1:0;
            greater_than_or_eq_u: o_branch_taken = (~w_ult) ? 1:0 ;
            default             : o_branch_taken = 0;
        endcase
    end
    
endmodule
