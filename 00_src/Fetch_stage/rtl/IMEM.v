module IMEM(
    input  [31:0] address_i,
    output [31:0] instruction_o
);

    parameter IMEM_FILE = "";

    reg [7:0] imem [0:1023];
    integer byte_index;

    initial begin
        for (byte_index = 0; byte_index < 1024; byte_index = byte_index + 4) begin
            imem[byte_index + 0] = 8'h00;
            imem[byte_index + 1] = 8'h00;
            imem[byte_index + 2] = 8'h00;
            imem[byte_index + 3] = 8'h13;
        end

        if (IMEM_FILE != "") begin
            $readmemh(IMEM_FILE, imem);
        end
    end

    // IMEM.mem stores each instruction as four bytes, MSB first.
    assign instruction_o = (address_i <= 32'd1020) ? {
        imem[address_i + 0],
        imem[address_i + 1],
        imem[address_i + 2],
        imem[address_i + 3]
    } : 32'h0000_0013;

endmodule
