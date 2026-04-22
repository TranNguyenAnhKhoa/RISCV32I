module ID_if(
    input  logic         clk_i                 ,
    input  logic         rstn_i                ,
    input  logic  [31:0] instruction_i         ,
    input  logic  [31:0] addr_current_i        ,
    input  logic  [31:0] write_back_data_i     ,
    input  logic  [4:0 ] write_rd_i             ,
    input  logic         hz_ctrl_i             ,
    input  logic         reg_write_en_i        ,
    output logic         ctrl_branch_o         ,
    output logic         ctrl_mem_read_o       ,
    output logic         ctrl_mem_to_reg_o     ,
    output logic         ctrl_mem_write_o      ,
    output logic         ctrl_ALUsrc_o         ,
    output logic         ctrl_reg_write_o      ,
    output logic  [1:0 ] ctrl_ALUOp_o          ,
    output logic  [31:0] rd1_o                 ,
    output logic  [31:0] rd2_o                 ,
    output logic  [31:0] addr_current_o        ,
    output logic  [31:0] imm_gen_o           
);
    logic clk_l;
    logic rstn_l;

    always @(posedge clk_i or negedge rstn_i) begin
        clk_l <= clk_i;
        rstn_l <= rstn_i;
    end

    ID_stage ID_stage_inst(
        .clk_i             (clk_l              ), 
        .rstn_i            (rstn_l             ), 
        .instruction_i     (instruction_i      ), 
        .addr_current_i    (addr_current_i     ), 
        .write_back_data_i (write_back_data_i  ), 
        .write_rd_i        (write_rd_i          ), 
        .hz_ctrl_i         (hz_ctrl_i          ), 
        .reg_write_en_i    (reg_write_en_i     ), 
        .ctrl_branch_o     (ctrl_branch_o      ), 
        .ctrl_mem_read_o   (ctrl_mem_read_o    ), 
        .ctrl_mem_to_reg_o (ctrl_mem_to_reg_o  ), 
        .ctrl_mem_write_o  (ctrl_mem_write_o   ), 
        .ctrl_ALUsrc_o     (ctrl_ALUsrc_o      ), 
        .ctrl_reg_write_o  (ctrl_reg_write_o   ), 
        .ctrl_ALUOp_o      (ctrl_ALUOp_o       ), 
        .rd1_o             (rd1_o              ), 
        .rd2_o             (rd2_o              ), 
        .addr_current_o    (addr_current_o     ), 
        .imm_gen_o         (imm_gen_o          )
    );

endmodule
