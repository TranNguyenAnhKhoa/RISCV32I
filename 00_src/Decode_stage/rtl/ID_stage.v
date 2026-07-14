module ID_stage(
    input         clk_i,
    input         rstn_i,
    input         flush_i,
    input  [31:0] instruction_i,
    input  [31:0] addr_current_i,
    input  [31:0] write_back_data_i,
    input  [4:0]  write_rd_i,
    input         write_en_ID_i,
    input         hz_ctrl_i,
    input         reg_write_en_i,
    output        ctrl_branch_o,
    output        ctrl_mem_read_o,
    output        ctrl_mem_to_reg_o,
    output        ctrl_mem_write_o,
    output        ctrl_reg_write_o,
    output [1:0]  ctrl_ALUOp_o,
    output [6:0]  opcode_o,
    output [31:0] rd1_o,
    output [31:0] rd2_o,
    output [31:0] addr_current_o,
    output [31:0] imm_gen_o,
    output        funct7_30_o,
    output [2:0]  funct3_o,
    output [4:0]  rs1_o,
    output [4:0]  rs2_o,
    output [4:0]  write_rd_o
);

    wire [31:0] rd1_w;
    wire [31:0] rd2_w;
    wire [31:0] immediate_w;
    wire        ctrl_branch_w;
    wire        ctrl_mem_read_w;
    wire        ctrl_mem_to_reg_w;
    wire        ctrl_mem_write_w;
    wire        ctrl_reg_write_w;
    wire [1:0]  ctrl_ALUOp_w;

    reg         ctrl_branch_r;
    reg         ctrl_mem_read_r;
    reg         ctrl_mem_to_reg_r;
    reg         ctrl_mem_write_r;
    reg         ctrl_reg_write_r;
    reg  [1:0]  ctrl_ALUOp_r;
    reg  [6:0]  opcode_r;
    reg  [31:0] rd1_r;
    reg  [31:0] rd2_r;
    reg  [31:0] addr_current_r;
    reg  [31:0] immediate_r;
    reg         funct7_30_r;
    reg  [2:0]  funct3_r;
    reg  [4:0]  rs1_r;
    reg  [4:0]  rs2_r;
    reg  [4:0]  write_rd_r;

    assign ctrl_branch_o     = ctrl_branch_r;
    assign ctrl_mem_read_o   = ctrl_mem_read_r;
    assign ctrl_mem_to_reg_o = ctrl_mem_to_reg_r;
    assign ctrl_mem_write_o  = ctrl_mem_write_r;
    assign ctrl_reg_write_o  = ctrl_reg_write_r;
    assign ctrl_ALUOp_o      = ctrl_ALUOp_r;
    assign opcode_o          = opcode_r;
    assign rd1_o             = rd1_r;
    assign rd2_o             = rd2_r;
    assign addr_current_o    = addr_current_r;
    assign imm_gen_o         = immediate_r;
    assign funct7_30_o       = funct7_30_r;
    assign funct3_o          = funct3_r;
    assign rs1_o             = rs1_r;
    assign rs2_o             = rs2_r;
    assign write_rd_o        = write_rd_r;

    always @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            ctrl_branch_r     <= 1'b0;
            ctrl_mem_read_r   <= 1'b0;
            ctrl_mem_to_reg_r <= 1'b0;
            ctrl_mem_write_r  <= 1'b0;
            ctrl_reg_write_r  <= 1'b0;
            ctrl_ALUOp_r      <= 2'b00;
            opcode_r          <= 7'b0000000;
            rd1_r             <= 32'h0000_0000;
            rd2_r             <= 32'h0000_0000;
            addr_current_r    <= 32'h0000_0000;
            immediate_r       <= 32'h0000_0000;
            funct7_30_r       <= 1'b0;
            funct3_r          <= 3'b000;
            rs1_r             <= 5'd0;
            rs2_r             <= 5'd0;
            write_rd_r        <= 5'd0;
        end else if (flush_i || hz_ctrl_i) begin
            ctrl_branch_r     <= 1'b0;
            ctrl_mem_read_r   <= 1'b0;
            ctrl_mem_to_reg_r <= 1'b0;
            ctrl_mem_write_r  <= 1'b0;
            ctrl_reg_write_r  <= 1'b0;
            ctrl_ALUOp_r      <= 2'b00;
            opcode_r          <= 7'b0000000;
            rd1_r             <= 32'h0000_0000;
            rd2_r             <= 32'h0000_0000;
            addr_current_r    <= 32'h0000_0000;
            immediate_r       <= 32'h0000_0000;
            funct7_30_r       <= 1'b0;
            funct3_r          <= 3'b000;
            rs1_r             <= 5'd0;
            rs2_r             <= 5'd0;
            write_rd_r        <= 5'd0;
        end else if (write_en_ID_i) begin
            ctrl_branch_r     <= ctrl_branch_w;
            ctrl_mem_read_r   <= ctrl_mem_read_w;
            ctrl_mem_to_reg_r <= ctrl_mem_to_reg_w;
            ctrl_mem_write_r  <= ctrl_mem_write_w;
            ctrl_reg_write_r  <= ctrl_reg_write_w;
            ctrl_ALUOp_r      <= ctrl_ALUOp_w;
            opcode_r          <= instruction_i[6:0];
            rd1_r             <= rd1_w;
            rd2_r             <= rd2_w;
            addr_current_r    <= addr_current_i;
            immediate_r       <= immediate_w;
            funct7_30_r       <= instruction_i[30];
            funct3_r          <= instruction_i[14:12];
            rs1_r             <= instruction_i[19:15];
            rs2_r             <= instruction_i[24:20];
            write_rd_r        <= instruction_i[11:7];
        end
    end

    control controller_inst0(
        .instruction_i (instruction_i),
        .branch_o      (ctrl_branch_w),
        .mem_read_o    (ctrl_mem_read_w),
        .mem_to_reg_o  (ctrl_mem_to_reg_w),
        .mem_write_o   (ctrl_mem_write_w),
        .reg_write_o   (ctrl_reg_write_w),
        .ALUOp_o       (ctrl_ALUOp_w)
    );

    register_file RF_inst0(
        .clk_i       (clk_i),
        .rstn_i      (rstn_i),
        .rs1_i       (instruction_i[19:15]),
        .rs2_i       (instruction_i[24:20]),
        .rd_i        (write_rd_i),
        .rd_value_i  (write_back_data_i),
        .reg_write_i (reg_write_en_i),
        .read_rs1_o  (rd1_w),
        .read_rs2_o  (rd2_w)
    );

    immediate_generator immediate_generator_inst0(
        .instruction_i (instruction_i),
        .output_o      (immediate_w)
    );

endmodule
