module MEM_stage(
    input           clk_i, 
    input           rstn_i,
    
    input           ctrl_branch_i,
    input           ctrl_mem_read_i, 
    input           ctrl_mem_write_i, 
    input           ctrl_reg_write_i, 
    input           ctrl_mem_to_reg_i,

    input  [31:0]   ALUresult_i, 
    input  [31:0]   addr_branch_i,
    input  [31:0]   rd2_i,
    input  [4:0 ]   rd_i,
    input  [2:0]    funct3_i,   

    output          ctrl_mem_to_reg_o, 
    output          ctrl_reg_write_o,
    output [31:0]   DMEM_data_o,
    output [31:0]   ALUresult_o,
    output [31:0]   addr_branch_o,
    output [4:0 ]   o_rd,
    output          is_branch_o
);
    
    //------------------------------
    //           WIRE
    //------------------------------
    wire ctrl_reg_write_w;
    wire ctrl_mem_to_reg_w;
    wire [31:0] DMEM_data_w, 
    wire [31:0] ALUresult_w, 
    wire [31:0] rd2_w, 
    wire [31:0] addr_branch_w;
    wire [4:0 ] w_rd;

    assign w_reg_write   = i_reg_write  ;
    assign w_mem_to_reg  = i_mem_to_reg ;
    assign w_rd          = rd_i         ;
    assign w_read_data2  = rd2_i ;
    assign addr_branch_w = addr_branch_i;
    assign ALUresult_o   = ALUresult_r  ;
    assign DMEM_data_o   = DMEM_data_r ;
    
    assign is_branch_o = ctrl_branch_i && branch_taken_i;

    DMEM DMEM_inst0(
        .clk_i       (clk_i           ),
        .address_i   (ALUresult_i     ),
        .data_i      (rd2_i           ),
        .funct3_i    (funct3_i        ),
        .mem_write_i (ctrl_mem_write_i),
        .mem_read_i  (ctrl_mem_read_i ),
        .data_o      (DMEM_data_w     )
    );
    always @(posedge clk_i) begin
        if( rstn_i ) begin
            o_mem_to_reg    <= 0;
            ctrl_reg_write_r     <= 0;
            DMEM_data_r      <= 0; 
            o_ALU_out       <= 0;
            o_rd            <= 0;
            o_addr_branch   <=0;
            ALUresult_r     <= 0;
        end else begin
            ctrl_reg_write_r     <= w_reg_write; 
            o_mem_to_reg    <= w_mem_to_reg;
            DMEM_data_r      <= DMEM_data_w; 
            o_ALU_out       <= ALUresult_w;
            o_rd            <= w_rd;
            o_addr_branch   <= addr_branch_w;    
            ALUresult_r     <= ALUresult_i;      
         end
    end

endmodule
