// module DMEM(
//     input              i_clk,

//     input       [31:0] i_address,
//     input       [31:0] i_write_data,
//     input              i_mem_write,
//     input              i_mem_read,

//     output      [31:0] o_read_data
// );
//     reg [7:0] dmem [0:2048];
//     reg [31:0] temp;
//     always @(posedge i_clk) begin
//         if (i_mem_write) begin
//             dmem[i_address+3] <= i_write_data[31:24 ];
//             dmem[i_address+2] <= i_write_data[23:16 ];
//             dmem[i_address+1] <= i_write_data[15:8  ];
//             dmem[i_address  ] <= i_write_data[7:0   ];
//         end
//             //$readmemh("/home/khoatna/workspace/chipyard/generators/riscv32i/src/main/resources/vsrc/riscv32i/submodule/rtl/DMEM/DMEM.mem", dmem);
//             $writememh("../data_mem/DMEM.mem", dmem);
//         end

//     assign o_read_data = (i_mem_read) ? {dmem[i_address], dmem[i_address+1], dmem[i_address+2], dmem[i_address+3]} : 32'h0000000;

// endmodule

module DMEM(
            input              i_clk,

            input       [31:0] i_address,
            input       [31:0] i_data,
            input              i_mem_write,
            input              i_mem_read,
            input       [2:0]  i_funct3,
            output reg  [31:0] o_data
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
    assign  w_bank3 = bank3[i_address];
    assign  w_bank2 = bank2[i_address];
    assign  w_bank1 = bank1[i_address];
    assign  w_bank0 = bank0[i_address];

    wire [31:0] w_idx_addr;
    assign w_idx_addr = i_address>>2;


    always @(posedge i_clk) begin
    //---------------------------------------------------------------
    //                         WRITE  
    //---------------------------------------------------------------
        if (i_mem_write) begin
            case (i_funct3)
                sw_lw: begin //store word
                    bank0[w_idx_addr] <= i_data[7:0  ];
                    bank1[w_idx_addr] <= i_data[15:8 ];
                    bank2[w_idx_addr] <= i_data[23:16];
                    bank3[w_idx_addr] <= i_data[31:24];
                end

                sh_lh: begin//store half word
                    if (i_address[1]) begin
                        bank2[w_idx_addr] <= i_data[7:0];
                        bank3[w_idx_addr] <= i_data[15:8];
                    end
                    else begin
                        bank0[w_idx_addr] <= i_data[7:0];
                        bank1[w_idx_addr] <= i_data[15:8];
                    end
                end
                
                sb_lb: begin //store byte
                    case (i_address[1:0])
                        2'b00: bank0[w_idx_addr] <= i_data[7:0];
                        2'b01: bank1[w_idx_addr] <= i_data[7:0];
                        2'b10: bank2[w_idx_addr] <= i_data[7:0];
                        2'b11: bank3[w_idx_addr] <= i_data[7:0];
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
        if (i_mem_read) begin
            casez(i_funct3)
                sb_lb: begin// load bytes
                    case (i_address[1:0])
                        2'b00: o_data = {{24{bank0[w_idx_addr][7]}}, bank0[w_idx_addr]};
                        2'b01: o_data = {{24{bank1[w_idx_addr][7]}}, bank1[w_idx_addr]};
                        2'b10: o_data = {{24{bank2[w_idx_addr][7]}}, bank2[w_idx_addr]};
                        2'b11: o_data = {{24{bank3[w_idx_addr][7]}}, bank3[w_idx_addr]};
                    endcase
                end

                sh_lh: begin// load half word
                    if (i_address[1]) begin
                        o_data = { {16{bank3[w_idx_addr][7]}}, bank3[w_idx_addr], bank2[w_idx_addr] };
                    end
                    else begin
                        o_data = { {16{bank2[w_idx_addr][7]}}, bank1[w_idx_addr], bank0[w_idx_addr] };
                    end   
                end
                
                sw_lw: begin// load word
                    o_data[7:0  ] = bank0[w_idx_addr];
                    o_data[15:8 ] = bank1[w_idx_addr];
                    o_data[23:16] = bank2[w_idx_addr];
                    o_data[31:24] = bank3[w_idx_addr];
                end

                lbu: begin// load bytes unsigned
                    case (i_address[1:0])
                        2'b00: o_data = {24'b0, bank0[w_idx_addr]};
                        2'b01: o_data = {24'b0, bank1[w_idx_addr]};
                        2'b10: o_data = {24'b0, bank2[w_idx_addr]};
                        2'b11: o_data = {24'b0, bank3[w_idx_addr]};
                    endcase
                end
                
                lhu: begin// load half word unsigned
                    if (i_address[1]) begin
                        o_data = { 16'b0, bank3[w_idx_addr], bank2[w_idx_addr] };
                    end
                    else begin
                        o_data = { 16'b0, bank2[w_idx_addr], bank1[w_idx_addr] };
                    end
                end
                
                default: o_data = 32'hzzzz;
            endcase
        end else begin
            o_data = 32'h0000_0000;
        end
    end

endmodule
