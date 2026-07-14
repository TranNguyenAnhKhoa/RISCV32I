module control(
    input  [31:0] instruction_i,
    output        branch_o,
    output        mem_read_o,
    output        mem_to_reg_o,
    output        mem_write_o,
    output        reg_write_o,
    output [1:0]  ALUOp_o
);

    localparam [6:0] OPCODE_LOAD     = 7'b0000011;
    localparam [6:0] OPCODE_MISC_MEM = 7'b0001111;
    localparam [6:0] OPCODE_OP_IMM   = 7'b0010011;
    localparam [6:0] OPCODE_AUIPC    = 7'b0010111;
    localparam [6:0] OPCODE_STORE    = 7'b0100011;
    localparam [6:0] OPCODE_OP       = 7'b0110011;
    localparam [6:0] OPCODE_LUI      = 7'b0110111;
    localparam [6:0] OPCODE_BRANCH   = 7'b1100011;
    localparam [6:0] OPCODE_JALR     = 7'b1100111;
    localparam [6:0] OPCODE_JAL      = 7'b1101111;
    localparam [6:0] OPCODE_SYSTEM   = 7'b1110011;

    reg        branch_r;
    reg        mem_read_r;
    reg        mem_to_reg_r;
    reg        mem_write_r;
    reg        reg_write_r;
    reg [1:0]  ALUOp_r;

    assign branch_o     = branch_r;
    assign mem_read_o   = mem_read_r;
    assign mem_to_reg_o = mem_to_reg_r;
    assign mem_write_o  = mem_write_r;
    assign reg_write_o  = reg_write_r;
    assign ALUOp_o      = ALUOp_r;

    always @(*) begin
        branch_r     = 1'b0;
        mem_read_r   = 1'b0;
        mem_to_reg_r = 1'b0;
        mem_write_r  = 1'b0;
        reg_write_r  = 1'b0;
        ALUOp_r      = 2'b00;

        case (instruction_i[6:0])
            OPCODE_LOAD: begin
                case (instruction_i[14:12])
                    3'b000,
                    3'b001,
                    3'b010,
                    3'b100,
                    3'b101: begin
                        mem_read_r   = 1'b1;
                        mem_to_reg_r = 1'b1;
                        reg_write_r  = 1'b1;
                        ALUOp_r      = 2'b01;
                    end

                    default: begin
                        // Unsupported load encoding has no side effect.
                    end
                endcase
            end

            OPCODE_STORE: begin
                case (instruction_i[14:12])
                    3'b000,
                    3'b001,
                    3'b010: begin
                        mem_write_r = 1'b1;
                        ALUOp_r     = 2'b01;
                    end

                    default: begin
                        // Unsupported store encoding has no side effect.
                    end
                endcase
            end

            OPCODE_OP: begin
                if (
                    (instruction_i[31:25] == 7'b0000000) ||
                    (
                        (instruction_i[31:25] == 7'b0100000) &&
                        (
                            (instruction_i[14:12] == 3'b000) ||
                            (instruction_i[14:12] == 3'b101)
                        )
                    )
                ) begin
                    reg_write_r = 1'b1;
                    ALUOp_r     = 2'b10;
                end
            end

            OPCODE_OP_IMM: begin
                if (
                    (
                        (instruction_i[14:12] == 3'b001) &&
                        (instruction_i[31:25] == 7'b0000000)
                    ) ||
                    (
                        (instruction_i[14:12] == 3'b101) &&
                        (
                            (instruction_i[31:25] == 7'b0000000) ||
                            (instruction_i[31:25] == 7'b0100000)
                        )
                    ) ||
                    (
                        (instruction_i[14:12] != 3'b001) &&
                        (instruction_i[14:12] != 3'b101)
                    )
                ) begin
                    reg_write_r = 1'b1;
                    ALUOp_r     = 2'b10;
                end
            end

            OPCODE_LUI: begin
                reg_write_r = 1'b1;
                ALUOp_r     = 2'b11;
            end

            OPCODE_AUIPC: begin
                reg_write_r = 1'b1;
                ALUOp_r     = 2'b01;
            end

            OPCODE_BRANCH: begin
                case (instruction_i[14:12])
                    3'b000,
                    3'b001,
                    3'b100,
                    3'b101,
                    3'b110,
                    3'b111: begin
                        branch_r = 1'b1;
                        ALUOp_r  = 2'b10;
                    end

                    default: begin
                        // Reserved branch funct3 has no side effect.
                    end
                endcase
            end

            OPCODE_JAL: begin
                reg_write_r = 1'b1;
                ALUOp_r     = 2'b01;
            end

            OPCODE_JALR: begin
                if (instruction_i[14:12] == 3'b000) begin
                    reg_write_r = 1'b1;
                    ALUOp_r     = 2'b01;
                end
            end

            OPCODE_MISC_MEM: begin
                // FENCE/FENCE.I are ordering operations. With the current
                // single-core memory model they retire as pipeline NOPs.
            end

            OPCODE_SYSTEM: begin
                // ECALL/EBREAK/CSR traps are not implemented in this core.
                // Keep every write-enable low so the instruction is benign.
            end

            default: begin
                // Illegal/unimplemented opcodes do not modify architectural
                // state and never introduce X values into the pipeline.
            end
        endcase
    end

endmodule
