module EXE_stage(
    input         clk_i,
    input         rstn_i,
    input         ctrl_branch_i,
    input         ctrl_mem_read_i,
    input         ctrl_mem_to_reg_i,
    input         ctrl_mem_write_i,
    input         ctrl_reg_write_i,
    input  [1:0]  ctrl_ALUOp_i,
    input  [6:0]  opcode_i,
    input  [31:0] addr_current_i,
    input  [31:0] rd1_i,
    input  [31:0] rd2_i,
    input  [31:0] imm_gen_i,
    input         funct7_30_i,
    input  [2:0]  funct3_i,
    input  [31:0] forward_EXMEM_data_i,
    input  [31:0] forward_MEMWB_data_i,
    input  [1:0]  hz_sel_ALU1_i,
    input  [1:0]  hz_sel_ALU2_i,
    input  [4:0]  write_rd_i,
    output        ctrl_mem_read_o,
    output        ctrl_mem_to_reg_o,
    output        ctrl_mem_write_o,
    output        ctrl_reg_write_o,
    output [31:0] addr_branch_o,
    output        is_branch_o,
    output [31:0] ALUresult_o,
    output [31:0] ALU2_i_o,
    output [2:0]  funct3_o,
    output [4:0]  write_rd_o
);

    localparam [6:0] OPCODE_LOAD   = 7'b0000011;
    localparam [6:0] OPCODE_OP_IMM = 7'b0010011;
    localparam [6:0] OPCODE_AUIPC  = 7'b0010111;
    localparam [6:0] OPCODE_STORE  = 7'b0100011;
    localparam [6:0] OPCODE_OP     = 7'b0110011;
    localparam [6:0] OPCODE_LUI    = 7'b0110111;
    localparam [6:0] OPCODE_BRANCH = 7'b1100011;
    localparam [6:0] OPCODE_JALR   = 7'b1100111;
    localparam [6:0] OPCODE_JAL    = 7'b1101111;

    wire [31:0] operand1_forwarded_w;
    wire [31:0] operand2_forwarded_w;
    reg  [31:0] ALU_operand1_r;
    reg  [31:0] ALU_operand2_r;
    wire [3:0]  ALU_control_w;
    wire [31:0] ALU_result_w;
    wire        branch_taken_w;
    reg  [31:0] branch_target_r;
    reg         redirect_r;

    reg         ctrl_mem_read_r;
    reg         ctrl_mem_to_reg_r;
    reg         ctrl_mem_write_r;
    reg         ctrl_reg_write_r;
    reg  [31:0] store_data_r;
    reg  [31:0] ALU_result_r;
    reg  [2:0]  funct3_r;
    reg  [4:0]  write_rd_r;

    assign operand1_forwarded_w =
        (hz_sel_ALU1_i == 2'b01) ? forward_EXMEM_data_i :
        (hz_sel_ALU1_i == 2'b10) ? forward_MEMWB_data_i :
                                   rd1_i;

    assign operand2_forwarded_w =
        (hz_sel_ALU2_i == 2'b01) ? forward_EXMEM_data_i :
        (hz_sel_ALU2_i == 2'b10) ? forward_MEMWB_data_i :
                                   rd2_i;

    always @(*) begin
        ALU_operand1_r = operand1_forwarded_w;
        ALU_operand2_r = operand2_forwarded_w;

        case (opcode_i)
            OPCODE_OP: begin
                ALU_operand1_r = operand1_forwarded_w;
                ALU_operand2_r = operand2_forwarded_w;
            end

            OPCODE_OP_IMM,
            OPCODE_LOAD,
            OPCODE_STORE: begin
                ALU_operand1_r = operand1_forwarded_w;
                ALU_operand2_r = imm_gen_i;
            end

            OPCODE_LUI: begin
                ALU_operand1_r = 32'h0000_0000;
                ALU_operand2_r = imm_gen_i;
            end

            OPCODE_AUIPC: begin
                ALU_operand1_r = addr_current_i;
                ALU_operand2_r = imm_gen_i;
            end

            OPCODE_JAL,
            OPCODE_JALR: begin
                ALU_operand1_r = addr_current_i;
                ALU_operand2_r = 32'd4;
            end

            default: begin
                ALU_operand1_r = 32'h0000_0000;
                ALU_operand2_r = 32'h0000_0000;
            end
        endcase
    end

    always @(*) begin
        branch_target_r = addr_current_i + imm_gen_i;
        redirect_r      = 1'b0;

        case (opcode_i)
            OPCODE_BRANCH: begin
                redirect_r = ctrl_branch_i && branch_taken_w;
            end

            OPCODE_JAL: begin
                redirect_r = 1'b1;
            end

            OPCODE_JALR: begin
                if (funct3_i == 3'b000) begin
                    branch_target_r = (operand1_forwarded_w + imm_gen_i) & 32'hffff_fffe;
                    redirect_r      = 1'b1;
                end
            end

            default: begin
                redirect_r = 1'b0;
            end
        endcase
    end

    assign ctrl_mem_read_o   = ctrl_mem_read_r;
    assign ctrl_mem_to_reg_o = ctrl_mem_to_reg_r;
    assign ctrl_mem_write_o  = ctrl_mem_write_r;
    assign ctrl_reg_write_o  = ctrl_reg_write_r;
    assign addr_branch_o     = branch_target_r;
    assign is_branch_o       = redirect_r;
    assign ALUresult_o       = ALU_result_r;
    assign ALU2_i_o          = store_data_r;
    assign funct3_o          = funct3_r;
    assign write_rd_o        = write_rd_r;

    always @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            ctrl_mem_read_r   <= 1'b0;
            ctrl_mem_to_reg_r <= 1'b0;
            ctrl_mem_write_r  <= 1'b0;
            ctrl_reg_write_r  <= 1'b0;
            store_data_r      <= 32'h0000_0000;
            ALU_result_r      <= 32'h0000_0000;
            funct3_r          <= 3'b000;
            write_rd_r        <= 5'd0;
        end else begin
            ctrl_mem_read_r   <= ctrl_mem_read_i;
            ctrl_mem_to_reg_r <= ctrl_mem_to_reg_i;
            ctrl_mem_write_r  <= ctrl_mem_write_i;
            ctrl_reg_write_r  <= ctrl_reg_write_i;
            store_data_r      <= operand2_forwarded_w;
            ALU_result_r      <= ALU_result_w;
            funct3_r          <= funct3_i;
            write_rd_r        <= write_rd_i;
        end
    end

    ALU ALU_inst0(
        .A_i       (ALU_operand1_r),
        .B_i       (ALU_operand2_r),
        .ALUCtrl_i (ALU_control_w),
        .result_o  (ALU_result_w)
    );

    ALU_control ALU_control_inst0(
        .ALUOp_i     (ctrl_ALUOp_i),
        .opcode_i    (opcode_i),
        .funct3_i    (funct3_i),
        .funct7_30_i (funct7_30_i),
        .ALUctrl_o   (ALU_control_w)
    );

    comparator comparator_inst0(
        .A_i            (operand1_forwarded_w),
        .B_i            (operand2_forwarded_w),
        .funct3_i       (funct3_i),
        .branch_taken_o (branch_taken_w)
    );

endmodule
