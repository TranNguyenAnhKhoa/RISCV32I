module CORE_if(
    input logic clk_i,
    input logic rstn_i
);

    RISCV RISCV_inst0(
        .clk_i  (clk_i),
        .rstn_i (rstn_i)
    );

endmodule
