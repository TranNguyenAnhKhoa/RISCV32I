module comparator(
    input   [31:0] A_i, 
    input   [31:0] B_i,
    input   [2:0]  funct3_i,
    output         branch_taken_o // take the branch or not

);
    wire equal_w, slt_w, ult_w;
    reg branch_taken_r;
// take the branch if ....
    parameter   equal                   = 3'b000,
                not_equal               = 3'b001,
                less_than               = 3'b100,
                greater_than_or_eq      = 3'b101,
                less_than_u             = 3'b110,
                greater_than_or_eq_u    = 3'b111;
    
    assign equal_w  = (A_i == B_i);
    assign ult_w    = (A_i < B_i);
    assign branch_taken_o = branch_taken_r;
    always @(*) begin
        case (funct3_i)
            equal                : branch_taken_r = (equal_w ) ? 1:0;
            not_equal            : branch_taken_r = (~equal_w) ? 1:0;
            less_than            : branch_taken_r = (A_i[31] != B_i[31]) ? A_i[31]:ult_w ; // signed
            greater_than_or_eq   : branch_taken_r = (A_i[31] != B_i[31]) ? B_i[31]:~ult_w ; // signed
            less_than_u          : branch_taken_r = (ult_w)  ? 1:0;
            greater_than_or_eq_u : branch_taken_r = (~ult_w) ? 1:0 ;
            default              : branch_taken_r = 0;
        endcase
    end
    
endmodule
