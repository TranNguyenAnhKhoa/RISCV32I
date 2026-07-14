module ALU_control(
    input  [1:0] ALUOp_i,
    input  [6:0] opcode_i,
    input  [2:0] funct3_i,
    input        funct7_30_i,
    output [3:0] ALUctrl_o
);

    localparam [6:0] OPCODE_LOAD   = 7'b0000011;
    localparam [6:0] OPCODE_OP_IMM = 7'b0010011;
    localparam [6:0] OPCODE_AUIPC  = 7'b0010111;
    localparam [6:0] OPCODE_STORE  = 7'b0100011;
    localparam [6:0] OPCODE_OP     = 7'b0110011;
    localparam [6:0] OPCODE_LUI    = 7'b0110111;
    localparam [6:0] OPCODE_JALR   = 7'b1100111;
    localparam [6:0] OPCODE_JAL    = 7'b1101111;

    localparam [3:0] ALU_ADD  = 4'b0000;
    localparam [3:0] ALU_SLL  = 4'b0001;
    localparam [3:0] ALU_SLT  = 4'b0010;
    localparam [3:0] ALU_SLTU = 4'b0011;
    localparam [3:0] ALU_XOR  = 4'b0100;
    localparam [3:0] ALU_SRL  = 4'b0101;
    localparam [3:0] ALU_OR   = 4'b0110;
    localparam [3:0] ALU_AND  = 4'b0111;
    localparam [3:0] ALU_SUB  = 4'b1000;
    localparam [3:0] ALU_SRA  = 4'b1101;
    localparam [3:0] ALU_LUI  = 4'b1111;

    reg [3:0] ALUctrl_r;

    assign ALUctrl_o = ALUctrl_r;

    always @(*) begin
        ALUctrl_r = ALU_ADD;

        case (opcode_i)
            OPCODE_OP: begin
                case (funct3_i)
                    3'b000: ALUctrl_r = funct7_30_i ? ALU_SUB : ALU_ADD;
                    3'b001: ALUctrl_r = ALU_SLL;
                    3'b010: ALUctrl_r = ALU_SLT;
                    3'b011: ALUctrl_r = ALU_SLTU;
                    3'b100: ALUctrl_r = ALU_XOR;
                    3'b101: ALUctrl_r = funct7_30_i ? ALU_SRA : ALU_SRL;
                    3'b110: ALUctrl_r = ALU_OR;
                    3'b111: ALUctrl_r = ALU_AND;
                    default: ALUctrl_r = ALU_ADD;
                endcase
            end

            OPCODE_OP_IMM: begin
                case (funct3_i)
                    3'b000: ALUctrl_r = ALU_ADD;
                    3'b001: ALUctrl_r = ALU_SLL;
                    3'b010: ALUctrl_r = ALU_SLT;
                    3'b011: ALUctrl_r = ALU_SLTU;
                    3'b100: ALUctrl_r = ALU_XOR;
                    3'b101: ALUctrl_r = funct7_30_i ? ALU_SRA : ALU_SRL;
                    3'b110: ALUctrl_r = ALU_OR;
                    3'b111: ALUctrl_r = ALU_AND;
                    default: ALUctrl_r = ALU_ADD;
                endcase
            end

            OPCODE_LUI: begin
                ALUctrl_r = ALU_LUI;
            end

            OPCODE_LOAD,
            OPCODE_STORE,
            OPCODE_AUIPC,
            OPCODE_JAL,
            OPCODE_JALR: begin
                ALUctrl_r = ALU_ADD;
            end

            default: begin
                // Keep ALUOp_i in the interface for backwards compatibility
                // with the original stage test wrappers.
                ALUctrl_r = (ALUOp_i == 2'b11) ? ALU_LUI : ALU_ADD;
            end
        endcase
    end

endmodule
