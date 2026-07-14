module hazard_detection(
    input  [6:0] opcode_IFID_i,
    input  [4:0] rs1_IFID_i,
    input  [4:0] rs2_IFID_i,
    input  [4:0] rd_IDEX_i,
    input  [4:0] rd_EXMEM_i,
    input        write_reg_IDEX_i,
    input        mem_read_IDEX_i,
    input        mem_read_EXMEM_i,
    input        branch_ID_i,
    input        is_jalr_i,
    output       write_IDEX_o,
    output       write_PC_o,
    output       control_mux_o
);

    localparam [6:0] OPCODE_LOAD   = 7'b0000011;
    localparam [6:0] OPCODE_OP_IMM = 7'b0010011;
    localparam [6:0] OPCODE_STORE  = 7'b0100011;
    localparam [6:0] OPCODE_OP     = 7'b0110011;
    localparam [6:0] OPCODE_BRANCH = 7'b1100011;
    localparam [6:0] OPCODE_JALR   = 7'b1100111;

    reg uses_rs1_r;
    reg uses_rs2_r;
    wire load_use_hazard_w;

    always @(*) begin
        uses_rs1_r = 1'b0;
        uses_rs2_r = 1'b0;

        case (opcode_IFID_i)
            OPCODE_LOAD,
            OPCODE_OP_IMM,
            OPCODE_JALR: begin
                uses_rs1_r = 1'b1;
            end

            OPCODE_STORE,
            OPCODE_OP,
            OPCODE_BRANCH: begin
                uses_rs1_r = 1'b1;
                uses_rs2_r = 1'b1;
            end

            default: begin
                uses_rs1_r = 1'b0;
                uses_rs2_r = 1'b0;
            end
        endcase
    end

    assign load_use_hazard_w =
        mem_read_IDEX_i &&
        (rd_IDEX_i != 5'd0) &&
        (
            (uses_rs1_r && (rd_IDEX_i == rs1_IFID_i)) ||
            (uses_rs2_r && (rd_IDEX_i == rs2_IFID_i))
        );

    assign write_IDEX_o  = !load_use_hazard_w;
    assign write_PC_o    = !load_use_hazard_w;
    assign control_mux_o = load_use_hazard_w;

    // Legacy inputs are retained so older named-port wrappers still compile.
    // Branch/JALR resolve in EX and use normal forwarding plus load-use stall.
    wire unused_legacy_inputs_w;
    assign unused_legacy_inputs_w =
        ^{rd_EXMEM_i, write_reg_IDEX_i, mem_read_EXMEM_i, branch_ID_i, is_jalr_i};

endmodule
