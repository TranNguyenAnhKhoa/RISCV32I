// module DMEM(
//     input              clk_i,

//     input       [31:0] address_i,
//     input       [31:0] i_write_data,
//     input              mem_write_i,
//     input              mem_read_i,

//     output      [31:0] o_read_data
// );
//     reg [7:0] dmem [0:2048];
//     reg [31:0] temp;
//     always @(posedge clk_i) begin
//         if (mem_write_i) begin
//             dmem[address_i+3] <= i_write_data[31:24 ];
//             dmem[address_i+2] <= i_write_data[23:16 ];
//             dmem[address_i+1] <= i_write_data[15:8  ];
//             dmem[address_i  ] <= i_write_data[7:0   ];
//         end
//             //$readmemh("/home/khoatna/workspace/chipyard/generators/riscv32i/src/main/resources/vsrc/riscv32i/submodule/rtl/DMEM/DMEM.mem", dmem);
//             $writememh("../data_mem/DMEM.mem", dmem);
//         end

//     assign o_read_data = (mem_read_i) ? {dmem[address_i], dmem[address_i+1], dmem[address_i+2], dmem[address_i+3]} : 32'h0000000;

// endmodule

module DMEM(
            input              clk_i,

            input       [31:0] address_i,
            input       [31:0] data_i,
            input              mem_write_i,
            input              mem_read_i,
            input       [2:0]  funct3_i,
            output reg  [31:0] data_o
);
    parameter   sb_lb   = 3'b000,
                sh_lh   = 3'b001,
                sw_lw   = 3'b010, 
                lbu     = 3'b100,
                lhu     = 3'b101;

    reg [7:0] bank0 [0:63]; // byte0 LSB
    reg [7:0] bank1 [0:63]; // byte1 
    reg [7:0] bank2 [0:63]; // byte2
    reg [7:0] bank3 [0:63]; // byte3 MSB

    wire [7:0] w_bank3, w_bank2, w_bank1, w_bank0;
    assign  w_bank3 = bank3[address_i];
    assign  w_bank2 = bank2[address_i];
    assign  w_bank1 = bank1[address_i];
    assign  w_bank0 = bank0[address_i];

    wire [31:0] w_idx_addr;
    assign w_idx_addr = address_i>>2;


    always @(posedge clk_i) begin
    //---------------------------------------------------------------
    //                         WRITE  
    //---------------------------------------------------------------
        if (mem_write_i) begin
            case (funct3_i)
                sw_lw: begin //store word
                    bank0[w_idx_addr] <= data_i[7:0  ];
                    bank1[w_idx_addr] <= data_i[15:8 ];
                    bank2[w_idx_addr] <= data_i[23:16];
                    bank3[w_idx_addr] <= data_i[31:24];
                end

                sh_lh: begin//store half word
                    if (address_i[1]) begin
                        bank2[w_idx_addr] <= data_i[7:0];
                        bank3[w_idx_addr] <= data_i[15:8];
                    end
                    else begin
                        bank0[w_idx_addr] <= data_i[7:0];
                        bank1[w_idx_addr] <= data_i[15:8];
                    end
                end
                
                sb_lb: begin //store byte
                    case (address_i[1:0])
                        2'b00: bank0[w_idx_addr] <= data_i[7:0];
                        2'b01: bank1[w_idx_addr] <= data_i[7:0];
                        2'b10: bank2[w_idx_addr] <= data_i[7:0];
                        2'b11: bank3[w_idx_addr] <= data_i[7:0];
                    endcase
                end
                default: begin
                    bank0[w_idx_addr] <= 8'h0;
                    bank1[w_idx_addr] <= 8'h0;
                    bank2[w_idx_addr] <= 8'h0;
                    bank3[w_idx_addr] <= 8'h0;
                end
            endcase
        end
    end
    //---------------------------------------------------------------
    //                          READ   
    //---------------------------------------------------------------
    always @(*) begin
        if (mem_read_i) begin
            casez(funct3_i)
                sb_lb: begin// load bytes
                    case (address_i[1:0])
                        2'b00: data_o = {{24{bank0[w_idx_addr][7]}}, bank0[w_idx_addr]};
                        2'b01: data_o = {{24{bank1[w_idx_addr][7]}}, bank1[w_idx_addr]};
                        2'b10: data_o = {{24{bank2[w_idx_addr][7]}}, bank2[w_idx_addr]};
                        2'b11: data_o = {{24{bank3[w_idx_addr][7]}}, bank3[w_idx_addr]};
                    endcase
                end

                sh_lh: begin// load half word
                    if (address_i[1]) begin
                        data_o = { {16{bank3[w_idx_addr][7]}}, bank3[w_idx_addr], bank2[w_idx_addr] };
                    end
                    else begin
                        data_o = { {16{bank2[w_idx_addr][7]}}, bank1[w_idx_addr], bank0[w_idx_addr] };
                    end   
                end
                
                sw_lw: begin// load word
                    data_o[7:0  ] = bank0[w_idx_addr];
                    data_o[15:8 ] = bank1[w_idx_addr];
                    data_o[23:16] = bank2[w_idx_addr];
                    data_o[31:24] = bank3[w_idx_addr];
                end

                lbu: begin// load bytes unsigned
                    case (address_i[1:0])
                        2'b00: data_o = {24'b0, bank0[w_idx_addr]};
                        2'b01: data_o = {24'b0, bank1[w_idx_addr]};
                        2'b10: data_o = {24'b0, bank2[w_idx_addr]};
                        2'b11: data_o = {24'b0, bank3[w_idx_addr]};
                    endcase
                end
                
                lhu: begin// load half word unsigned
                    if (address_i[1]) begin
                        data_o = { 16'b0, bank3[w_idx_addr], bank2[w_idx_addr] };
                    end
                    else begin
                        data_o = { 16'b0, bank2[w_idx_addr], bank1[w_idx_addr] };
                    end
                end
                
                default: data_o = 32'hzzzz;
            endcase
        end else begin
            data_o = 32'h0000_0000;
        end
    end

endmodule
