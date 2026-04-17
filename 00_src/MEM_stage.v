module MEM_stage(
    input             i_clk, i_rstn,
    
    input             i_mem_read, i_mem_write, i_reg_write, i_mem_to_reg,
    input      [31:0] i_ALU_out, i_addr_branch,
    input      [31:0] i_read_data2,
    input      [4:0 ] i_rd,
    input      [2:0]  i_funct3,   

    output reg        o_mem_to_reg, o_reg_write,
    output reg [31:0] o_DMEM_out, o_ALU_out, o_addr_branch,
    output reg [4:0 ] o_rd
);
    
    //------------------------------
    //           WIRE
    //------------------------------
    wire w_reg_write, w_mem_to_reg;
    wire [31:0] w_DMEM_out, w_ALU_out, w_read_data2, w_addr_branch;
    wire [4:0 ] w_rd;

    assign w_reg_write   = i_reg_write  ;
    assign w_mem_to_reg  = i_mem_to_reg ;
    assign w_ALU_out     = i_ALU_out    ;
    assign w_rd          = i_rd         ;
    assign w_read_data2  = i_read_data2 ;
    assign w_addr_branch = i_addr_branch;

    //and and_inst0 ( o_is_branch, i_branch, i_branch_taken);

    DMEM DMEM_inst0(
        .i_clk       (i_clk                 ),
        .i_address   (w_ALU_out             ),
        .i_data      (i_read_data2          ),
        .i_funct3    (i_funct3              ),
        .i_mem_write (i_mem_write           ),
        .i_mem_read  (i_mem_read            ),
        .o_data      (w_DMEM_out            )
    );
    always @(posedge i_clk) begin
        if(i_rstn) begin
            o_mem_to_reg <= 0;
            o_reg_write  <= 0;
            o_DMEM_out     <= 0; 
            o_ALU_out     <= 0;
            o_rd          <= 0;
            o_addr_branch <=0;
        end else begin
            o_reg_write  <= w_reg_write; 
            o_mem_to_reg <= w_mem_to_reg;
            o_DMEM_out   <= w_DMEM_out; 
            o_ALU_out    <= w_ALU_out;
            o_rd         <= w_rd;
            o_addr_branch<= w_addr_branch;          
         end
    end

endmodule
