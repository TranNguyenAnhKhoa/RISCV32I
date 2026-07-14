module RISCV #(
    parameter IMEM_FILE = "",
    parameter DMEM_FILE = ""
)(
    input clk_i,
    input rstn_i
);

    // IF/ID pipeline outputs
    wire [31:0] instr_IF_w;
    wire [31:0] addr_IF_w;

    // ID/EX pipeline outputs
    wire        ctrl_branch_ID_w;
    wire        ctrl_mem_read_ID_w;
    wire        ctrl_mem_to_reg_ID_w;
    wire        ctrl_mem_write_ID_w;
    wire        ctrl_reg_write_ID_w;
    wire [1:0]  ctrl_ALUOp_ID_w;
    wire [6:0]  opcode_ID_w;
    wire [31:0] rd1_ID_w;
    wire [31:0] rd2_ID_w;
    wire [31:0] addr_current_ID_w;
    wire [31:0] imm_gen_ID_w;
    wire        funct7_30_ID_w;
    wire [2:0]  funct3_ID_w;
    wire [4:0]  rs1_ID_w;
    wire [4:0]  rs2_ID_w;
    wire [4:0]  write_rd_ID_w;

    // EX/MEM pipeline outputs and EX redirect
    wire [31:0] addr_branch_EXE_w;
    wire        redirect_EXE_w;
    wire        ctrl_mem_read_EXE_w;
    wire        ctrl_mem_to_reg_EXE_w;
    wire        ctrl_mem_write_EXE_w;
    wire        ctrl_reg_write_EXE_w;
    wire [2:0]  funct3_EXE_w;
    wire [4:0]  write_rd_EXE_w;
    wire [31:0] ALUresult_EXE_w;
    wire [31:0] store_data_EXE_w;

    // MEM/WB pipeline outputs
    wire        ctrl_mem_to_reg_MEM_w;
    wire        ctrl_reg_write_MEM_w;
    wire [31:0] DMEM_data_MEM_w;
    wire [31:0] ALUresult_MEM_w;
    wire [4:0]  write_rd_MEM_w;

    // Writeback and hazard signals
    wire [31:0] write_back_data_w;
    wire        hazard_ID_write_enable_w;
    wire        hazard_PC_write_enable_w;
    wire        hazard_insert_bubble_w;
    wire [1:0]  forward_ALU1_select_w;
    wire [1:0]  forward_ALU2_select_w;

    assign write_back_data_w = ctrl_mem_to_reg_MEM_w ?
                               DMEM_data_MEM_w :
                               ALUresult_MEM_w;

    IF_stage #(
        .IMEM_FILE (IMEM_FILE)
    ) IF_stage_inst(
        .clk_i          (clk_i),
        .rstn_i         (rstn_i),
        .branch_i       (redirect_EXE_w),
        .flush_i        (redirect_EXE_w),
        .write_PC_en_i  (hazard_PC_write_enable_w),
        .addr_branch_i  (addr_branch_EXE_w),
        .instruction_o  (instr_IF_w),
        .addr_current_o (addr_IF_w)
    );

    ID_stage ID_stage_inst(
        .clk_i             (clk_i),
        .rstn_i            (rstn_i),
        .flush_i           (redirect_EXE_w),
        .instruction_i     (instr_IF_w),
        .addr_current_i    (addr_IF_w),
        .write_back_data_i (write_back_data_w),
        .write_rd_i        (write_rd_MEM_w),
        .write_en_ID_i     (hazard_ID_write_enable_w),
        .hz_ctrl_i         (hazard_insert_bubble_w),
        .reg_write_en_i    (ctrl_reg_write_MEM_w),
        .ctrl_branch_o     (ctrl_branch_ID_w),
        .ctrl_mem_read_o   (ctrl_mem_read_ID_w),
        .ctrl_mem_to_reg_o (ctrl_mem_to_reg_ID_w),
        .ctrl_mem_write_o  (ctrl_mem_write_ID_w),
        .ctrl_reg_write_o  (ctrl_reg_write_ID_w),
        .ctrl_ALUOp_o      (ctrl_ALUOp_ID_w),
        .opcode_o          (opcode_ID_w),
        .rd1_o             (rd1_ID_w),
        .rd2_o             (rd2_ID_w),
        .addr_current_o    (addr_current_ID_w),
        .imm_gen_o         (imm_gen_ID_w),
        .funct7_30_o       (funct7_30_ID_w),
        .funct3_o          (funct3_ID_w),
        .rs1_o             (rs1_ID_w),
        .rs2_o             (rs2_ID_w),
        .write_rd_o        (write_rd_ID_w)
    );

    EXE_stage EXE_stage_inst(
        .clk_i                  (clk_i),
        .rstn_i                 (rstn_i),
        .ctrl_branch_i          (ctrl_branch_ID_w),
        .ctrl_mem_read_i        (ctrl_mem_read_ID_w),
        .ctrl_mem_to_reg_i      (ctrl_mem_to_reg_ID_w),
        .ctrl_mem_write_i       (ctrl_mem_write_ID_w),
        .ctrl_reg_write_i       (ctrl_reg_write_ID_w),
        .ctrl_ALUOp_i           (ctrl_ALUOp_ID_w),
        .opcode_i               (opcode_ID_w),
        .addr_current_i         (addr_current_ID_w),
        .rd1_i                  (rd1_ID_w),
        .rd2_i                  (rd2_ID_w),
        .imm_gen_i              (imm_gen_ID_w),
        .funct7_30_i            (funct7_30_ID_w),
        .funct3_i               (funct3_ID_w),
        .forward_EXMEM_data_i   (ALUresult_EXE_w),
        .forward_MEMWB_data_i   (write_back_data_w),
        .hz_sel_ALU1_i          (forward_ALU1_select_w),
        .hz_sel_ALU2_i          (forward_ALU2_select_w),
        .write_rd_i             (write_rd_ID_w),
        .ctrl_mem_read_o        (ctrl_mem_read_EXE_w),
        .ctrl_mem_to_reg_o      (ctrl_mem_to_reg_EXE_w),
        .ctrl_mem_write_o       (ctrl_mem_write_EXE_w),
        .ctrl_reg_write_o       (ctrl_reg_write_EXE_w),
        .addr_branch_o          (addr_branch_EXE_w),
        .is_branch_o            (redirect_EXE_w),
        .ALUresult_o            (ALUresult_EXE_w),
        .ALU2_i_o               (store_data_EXE_w),
        .funct3_o               (funct3_EXE_w),
        .write_rd_o             (write_rd_EXE_w)
    );

    MEM_stage #(
        .DMEM_FILE (DMEM_FILE)
    ) MEM_stage_inst(
        .clk_i             (clk_i),
        .rstn_i            (rstn_i),
        .ctrl_mem_read_i   (ctrl_mem_read_EXE_w),
        .ctrl_mem_write_i  (ctrl_mem_write_EXE_w),
        .ctrl_reg_write_i  (ctrl_reg_write_EXE_w),
        .ctrl_mem_to_reg_i (ctrl_mem_to_reg_EXE_w),
        .ALUresult_i       (ALUresult_EXE_w),
        .ALU2i_i           (store_data_EXE_w),
        .write_rd_i        (write_rd_EXE_w),
        .funct3_i          (funct3_EXE_w),
        .ctrl_mem_to_reg_o (ctrl_mem_to_reg_MEM_w),
        .ctrl_reg_write_o  (ctrl_reg_write_MEM_w),
        .DMEM_data_o       (DMEM_data_MEM_w),
        .ALUresult_o       (ALUresult_MEM_w),
        .write_rd_o        (write_rd_MEM_w)
    );

    hazard_detection hazard_detection_inst(
        .opcode_IFID_i       (instr_IF_w[6:0]),
        .rs1_IFID_i          (instr_IF_w[19:15]),
        .rs2_IFID_i          (instr_IF_w[24:20]),
        .rd_IDEX_i           (write_rd_ID_w),
        .rd_EXMEM_i          (write_rd_EXE_w),
        .write_reg_IDEX_i    (ctrl_reg_write_ID_w),
        .mem_read_IDEX_i     (ctrl_mem_read_ID_w),
        .mem_read_EXMEM_i    (ctrl_mem_read_EXE_w),
        .branch_ID_i         (ctrl_branch_ID_w),
        .is_jalr_i           (instr_IF_w[6:0] == 7'b1100111),
        .write_IDEX_o        (hazard_ID_write_enable_w),
        .write_PC_o          (hazard_PC_write_enable_w),
        .control_mux_o       (hazard_insert_bubble_w)
    );

    forwarding forwarding_inst(
        .reg_write_EXMEM_i (ctrl_reg_write_EXE_w),
        .reg_write_MEMWB_i (ctrl_reg_write_MEM_w),
        .rs1_IDEX_i        (rs1_ID_w),
        .rs2_IDEX_i        (rs2_ID_w),
        .rd_EXMEM_i        (write_rd_EXE_w),
        .rd_MEMWB_i        (write_rd_MEM_w),
        .mux_ALU1_o        (forward_ALU1_select_w),
        .mux_ALU2_o        (forward_ALU2_select_w)
    );

endmodule
