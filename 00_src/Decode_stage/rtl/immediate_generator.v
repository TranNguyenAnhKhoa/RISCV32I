module immediate_generator(
    input  [31:0] instruction_i,
    output [31:0] output_o
);

    localparam [6:0] OPCODE_LOAD   = 7'b0000011;
    localparam [6:0] OPCODE_OP_IMM = 7'b0010011;
    localparam [6:0] OPCODE_AUIPC  = 7'b0010111;
    localparam [6:0] OPCODE_STORE  = 7'b0100011;
    localparam [6:0] OPCODE_LUI    = 7'b0110111;
    localparam [6:0] OPCODE_BRANCH = 7'b1100011;
    localparam [6:0] OPCODE_JALR   = 7'b1100111;
    localparam [6:0] OPCODE_JAL    = 7'b1101111;

    reg [31:0] immediate_r;

    assign output_o = immediate_r;

    always @(*) begin
        immediate_r = 32'h0000_0000;

        case (instruction_i[6:0])
            OPCODE_LOAD,
            OPCODE_OP_IMM,
            OPCODE_JALR: begin
                immediate_r = {{20{instruction_i[31]}}, instruction_i[31:20]};
            end

            OPCODE_STORE: begin
                immediate_r = {
                    {20{instruction_i[31]}},
                    instruction_i[31:25],
                    instruction_i[11:7]
                };
            end

            OPCODE_BRANCH: begin
                immediate_r = {
                    {20{instruction_i[31]}},
                    instruction_i[7],
                    instruction_i[30:25],
                    instruction_i[11:8],
                    1'b0
                };
            end

            OPCODE_LUI,
            OPCODE_AUIPC: begin
                immediate_r = {instruction_i[31:12], 12'b0};
            end

            OPCODE_JAL: begin
                immediate_r = {
                    {12{instruction_i[31]}},
                    instruction_i[19:12],
                    instruction_i[20],
                    instruction_i[30:21],
                    1'b0
                };
            end

            default: begin
                immediate_r = 32'h0000_0000;
            end
        endcase
    end

endmodule
