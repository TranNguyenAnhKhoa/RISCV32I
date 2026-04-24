module top(
    input logic        clk_i   ,
    input logic        rstn_i  
);
    logic clk_l;
    logic rstn_l;

    always @(posedge clk_i or rstn_i) begin
        clk_l <= clk_i;
        rstn_l <= rstn_i;
    end

    RISCV RISCV_inst(
        .clk_i  (clk_l),
        .rstn_i (rstn_l)
    );

endmodule