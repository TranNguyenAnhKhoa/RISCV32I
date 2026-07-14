module DMEM(
    input         clk_i,
    input  [31:0] address_i,
    input  [31:0] data_i,
    input         mem_write_i,
    input         mem_read_i,
    input  [2:0]  funct3_i,
    output reg [31:0] data_o
);

    parameter DMEM_FILE = "";

    localparam [2:0] FUNCT3_BYTE          = 3'b000;
    localparam [2:0] FUNCT3_HALFWORD      = 3'b001;
    localparam [2:0] FUNCT3_WORD          = 3'b010;
    localparam [2:0] FUNCT3_BYTE_UNSIGNED = 3'b100;
    localparam [2:0] FUNCT3_HALF_UNSIGNED = 3'b101;

    reg [7:0] bank0 [0:512];
    reg [7:0] bank1 [0:512];
    reg [7:0] bank2 [0:512];
    reg [7:0] bank3 [0:512];
    reg [7:0] initial_memory [0:2048];

    wire [8:0] word_index_w;
    wire       access_valid_w;
    integer    word_index;
    integer    byte_index;

    assign word_index_w = address_i[10:2];
    assign access_valid_w =
        (
            (
                (funct3_i == FUNCT3_BYTE) ||
                (funct3_i == FUNCT3_BYTE_UNSIGNED)
            ) &&
            (address_i <= 32'd2048)
        ) ||
        (
            (
                (funct3_i == FUNCT3_HALFWORD) ||
                (funct3_i == FUNCT3_HALF_UNSIGNED)
            ) &&
            (address_i[0] == 1'b0) &&
            (address_i <= 32'd2047)
        ) ||
        (
            (funct3_i == FUNCT3_WORD) &&
            (address_i[1:0] == 2'b00) &&
            (address_i <= 32'd2045)
        );

    initial begin
        for (word_index = 0; word_index < 513; word_index = word_index + 1) begin
            bank0[word_index] = 8'h00;
            bank1[word_index] = 8'h00;
            bank2[word_index] = 8'h00;
            bank3[word_index] = 8'h00;
        end

        for (byte_index = 0; byte_index < 2049; byte_index = byte_index + 1) begin
            initial_memory[byte_index] = 8'h00;
        end

        if (DMEM_FILE != "") begin
            $readmemh(DMEM_FILE, initial_memory);

            for (word_index = 0; word_index < 512; word_index = word_index + 1) begin
                bank0[word_index] = initial_memory[(word_index * 4) + 0];
                bank1[word_index] = initial_memory[(word_index * 4) + 1];
                bank2[word_index] = initial_memory[(word_index * 4) + 2];
                bank3[word_index] = initial_memory[(word_index * 4) + 3];
            end

            bank0[512] = initial_memory[2048];
        end
    end

    always @(posedge clk_i) begin
        if (mem_write_i && access_valid_w) begin
            case (funct3_i)
                FUNCT3_BYTE: begin
                    case (address_i[1:0])
                        2'b00: bank0[word_index_w] <= data_i[7:0];
                        2'b01: bank1[word_index_w] <= data_i[7:0];
                        2'b10: bank2[word_index_w] <= data_i[7:0];
                        2'b11: bank3[word_index_w] <= data_i[7:0];
                    endcase
                end

                FUNCT3_HALFWORD: begin
                    if (address_i[1]) begin
                        bank2[word_index_w] <= data_i[7:0];
                        bank3[word_index_w] <= data_i[15:8];
                    end else begin
                        bank0[word_index_w] <= data_i[7:0];
                        bank1[word_index_w] <= data_i[15:8];
                    end
                end

                FUNCT3_WORD: begin
                    bank0[word_index_w] <= data_i[7:0];
                    bank1[word_index_w] <= data_i[15:8];
                    bank2[word_index_w] <= data_i[23:16];
                    bank3[word_index_w] <= data_i[31:24];
                end

                default: begin
                    // Unsupported store width must not corrupt memory.
                end
            endcase
        end
    end

    always @(*) begin
        data_o = 32'h0000_0000;

        if (mem_read_i && access_valid_w) begin
            case (funct3_i)
                FUNCT3_BYTE: begin
                    case (address_i[1:0])
                        2'b00: data_o = {{24{bank0[word_index_w][7]}}, bank0[word_index_w]};
                        2'b01: data_o = {{24{bank1[word_index_w][7]}}, bank1[word_index_w]};
                        2'b10: data_o = {{24{bank2[word_index_w][7]}}, bank2[word_index_w]};
                        2'b11: data_o = {{24{bank3[word_index_w][7]}}, bank3[word_index_w]};
                    endcase
                end

                FUNCT3_HALFWORD: begin
                    if (address_i[1]) begin
                        data_o = {
                            {16{bank3[word_index_w][7]}},
                            bank3[word_index_w],
                            bank2[word_index_w]
                        };
                    end else begin
                        data_o = {
                            {16{bank1[word_index_w][7]}},
                            bank1[word_index_w],
                            bank0[word_index_w]
                        };
                    end
                end

                FUNCT3_WORD: begin
                    data_o = {
                        bank3[word_index_w],
                        bank2[word_index_w],
                        bank1[word_index_w],
                        bank0[word_index_w]
                    };
                end

                FUNCT3_BYTE_UNSIGNED: begin
                    case (address_i[1:0])
                        2'b00: data_o = {24'h000000, bank0[word_index_w]};
                        2'b01: data_o = {24'h000000, bank1[word_index_w]};
                        2'b10: data_o = {24'h000000, bank2[word_index_w]};
                        2'b11: data_o = {24'h000000, bank3[word_index_w]};
                    endcase
                end

                FUNCT3_HALF_UNSIGNED: begin
                    if (address_i[1]) begin
                        data_o = {
                            16'h0000,
                            bank3[word_index_w],
                            bank2[word_index_w]
                        };
                    end else begin
                        data_o = {
                            16'h0000,
                            bank1[word_index_w],
                            bank0[word_index_w]
                        };
                    end
                end

                default: begin
                    data_o = 32'h0000_0000;
                end
            endcase
        end
    end

endmodule
