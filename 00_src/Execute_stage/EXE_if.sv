module EXE_if(
    input  logic         clk_i             ,
    input  logic         rstn_i            ,
    input  logic [31:0]  instruction_i     ,
    input  logic [31:0]  addr_current_i    ,
    input  logic [31:0]  write_back_data_i ,
    input  logic [4:0 ]  write_reg         ,
    // hazard control
    input  logic         ctr_hazard_i      ,
    // control signal
    input  logic         reg_write_en_i    ,
    output logic         branch_o          ,
    output logic         mem_read_o        ,
    output logic         mem_to_reg_o      ,
    output logic         mem_write_o       ,
    output logic         ALU_src_o         ,
    output logic         reg_write_o       ,
    output logic  [1:0 ] ALUOp_o           ,
    output logic  [31:0] rd1_o             ,
    output logic  [31:0] rd2_o             ,
    output logic  [31:0] instruction_o     ,
    output logic  [31:0] addr_current_o    ,
    output logic  [31:0] imm_gen_o 
);
    logic clk_l;
    logic rstn_l;

    always @(posedge clk_i or negedge rstn_i) begin
        clk_l <= clk_i;
        rstn_l <= rstn_i;
    end

    IF_stage IF_stage_inst(
        .clk_i            (clk_l            ),
        .rstn_i           (rstn_l           ),
        .instruction_i    (instruction_i    ),
        .addr_current_i   (addr_current_i   ),
        .write_back_data_i(write_back_data_i),
        .write_reg        (write_reg        ),
        .ctr_hazard_i     (ctr_hazard_i     ),
        .reg_write_en_i   (reg_write_en_i   ),
        .branch_o         (branch_o         ),
        .mem_read_o       (mem_read_o       ),
        .mem_to_reg_o     (mem_to_reg_o     ),
        .mem_write_o      (mem_write_o      ),
        .ALU_src_o        (ALU_src_o        ),
        .reg_write_o      (reg_write_o      ),
        .ALUOp_o          (ALUOp_o          ),
        .rd1_o            (rd1_o            ),
        .rd2_o            (rd2_o            ),
        .instruction_o    (instruction_o    ),
        .addr_current_o   (addr_current_o   ),
        .imm_gen_o        (imm_gen_o        )
    );

endmodule
