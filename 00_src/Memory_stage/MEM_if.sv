module MEM_if(
    input  logic        clk_i,
    input  logic        rstn_i,
    input  logic        ctrl_mem_read_i,
    input  logic        ctrl_mem_write_i,
    input  logic        ctrl_reg_write_i,
    input  logic        ctrl_mem_to_reg_i,
    input  logic [31:0] ALUresult_i,
    input  logic [31:0] ALU2i_i,
    input  logic [4:0]  write_rd_i,
    input  logic [2:0]  funct3_i,
    output logic        ctrl_mem_to_reg_o,
    output logic        ctrl_reg_write_o,
    output logic [31:0] DMEM_data_o,
    output logic [31:0] ALUresult_o,
    output logic [4:0]  write_rd_o
);

    MEM_stage MEM_stage_inst0(
        .clk_i             (clk_i),
        .rstn_i            (rstn_i),
        .ctrl_mem_read_i   (ctrl_mem_read_i),
        .ctrl_mem_write_i  (ctrl_mem_write_i),
        .ctrl_reg_write_i  (ctrl_reg_write_i),
        .ctrl_mem_to_reg_i (ctrl_mem_to_reg_i),
        .ALUresult_i       (ALUresult_i),
        .ALU2i_i           (ALU2i_i),
        .write_rd_i        (write_rd_i),
        .funct3_i          (funct3_i),
        .ctrl_mem_to_reg_o (ctrl_mem_to_reg_o),
        .ctrl_reg_write_o  (ctrl_reg_write_o),
        .DMEM_data_o       (DMEM_data_o),
        .ALUresult_o       (ALUresult_o),
        .write_rd_o        (write_rd_o)
    );

endmodule
