module IF_if(
    input  logic        clk_i,
    input  logic        rstn_i,
    input  logic        branch_i,
    input  logic        flush_i,
    input  logic        write_PC_en_i,
    input  logic [31:0] addr_branch_i,
    output logic [31:0] instruction_o,
    output logic [31:0] addr_current_o
);

    IF_stage IF_stage_inst0(
        .clk_i          (clk_i),
        .rstn_i         (rstn_i),
        .branch_i       (branch_i),
        .flush_i        (flush_i),
        .write_PC_en_i  (write_PC_en_i),
        .addr_branch_i  (addr_branch_i),
        .instruction_o  (instruction_o),
        .addr_current_o (addr_current_o)
    );

endmodule
