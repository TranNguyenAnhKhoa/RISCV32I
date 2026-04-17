module IMEM(
    input      [31:0]   address_i,
    output reg [31:0]   instruction_o
); 
    reg [7:0] imem [0:1023];
    
    initial begin
        $readmemh("../data_mem/IMEM.mem", imem);
    end

    always @(*) begin
        instruction_o = {  imem[address_i  ], 
                            imem[address_i+1], 
                            imem[address_i+2], 
                            imem[address_i+3]
                        };
    end

endmodule
