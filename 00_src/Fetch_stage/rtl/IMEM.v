module IMEM(
    input  [31:0]   address_i,
    output [31:0]   instruction_o
);
    reg [7:0] imem [0:1023];
    
    initial begin
        $readmemh("/data/workspaces/khoatna/workspace/RISCV32I/01_data_mem/IMEM.mem", imem);
    end

    assign instruction_o = {    imem[address_i  ], 
                                imem[address_i+1], 
                                imem[address_i+2], 
                                imem[address_i+3]
                        };


endmodule
