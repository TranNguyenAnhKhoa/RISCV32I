module RISCV(
    input clk_i,
    input rstn_i
);
    //----------------------------------------
    //              wires & regs
    //----------------------------------------
    
        //-----------fetch stage------------------
    wire [31:0] intr_IF_w;
    wire [31:0] addr_IF_w;
    
        //----------decode stage------------------
    wire        ctrl_branch_ID_w       ; 
    wire        ctrl_mem_read_ID_w     ;  
    wire        ctrl_mem_to_reg_ID_w   ;
    wire        ctrl_mem_write_ID_w    ; 
    wire        ctrl_ALUsrc_ID_w       ;    
    wire        ctrl_reg_write_ID_w    ; 
    wire        ctrl_ALUOp_ID_w        ;   
    wire [4:0]  rd1_ID_w                 ;
    wire [4:0]  rd2_ID_w                 ;
    wire [31:0] addr_current_ID_w      ;
    wire [31:0] imm_gen_ID_w           ; 

        //----------execute stage-----------------          
    wire        branch_taken_EXE_i;
    wire [31:0] addr_branch_EXE_w;
    
        //----------memory stage------------------

    
        //---------write back stage---------------
    wire [31:0] data_WB_w;
    wire [4:0]  write_rd_WB_w;
    wire        ctrl_reg_write_en_WB_w ;

        // control signal

        // hazard signal
    wire hz_flush_w;
    wire hz_write_PC_en_w;
    wire hz_ctrl_w;

    // ----------------------------------------------
    //          Internal blocks
    // ----------------------------------------------   
    IF_stage IF_stage_inst(
        .clk_i          (clk_i              ),
        .rstn_i         (rstn_i             ),
        .branch_i       (branch_taken_EXE_i ),
        .flush_i        (hz_flush_w         ),
        .write_PC_en_i  (hz_write_PC_en_w   ),
        .addr_branch_i  (addr_branch_EXE_w  ),
        .instruction_o  (intr_IF_w          ),
        .addr_current_o (addr_IF_w          )    
    );

    ID_stage ID_stage_inst(
        .clk_i             (clk_i                   ), 
        .rstn_i            (rstn_i                  ), 
        .instruction_i     (intr_IF_w               ), 
        .addr_current_i    (addr_IF_w               ),
        .write_back_data_i (data_WB_w               ), 
        .write_rd_i        (write_rd_WB_w           ), 
        .hz_ctrl_i         (hz_ctrl_w               ), 
        .reg_write_en_i    (ctrl_reg_write_en_WB_w  ), 
        .ctrl_branch_o     (ctrl_branch_ID_w        ), 
        .ctrl_mem_read_o   (ctrl_mem_read_ID_w      ), 
        .ctrl_mem_to_reg_o (ctrl_mem_to_reg_ID_w    ), 
        .ctrl_mem_write_o  (ctrl_mem_write_ID_w     ), 
        .ctrl_ALUsrc_o     (ctrl_ALUsrc_ID_w        ), 
        .ctrl_reg_write_o  (ctrl_reg_write_ID_w     ), 
        .ctrl_ALUOp_o      (ctrl_ALUOp_ID_w         ), 
        .rd1_o             (rd1_ID_w                ), 
        .rd2_o             (rd2_ID_w                ), 
        .addr_current_o    (addr_current_ID_w       ), 
        .imm_gen_o         (imm_gen_ID_w            )
    );

    EXE_stage EXE_stage_inst(
        clk_i                 
        rstn_i                
        instruction_i         
        ctrl_branch_i         
        ctrl_mem_read_i       
        ctrl_mem_to_reg_i     
        ctrl_mem_write_i      
        ctrl_ALU_src_i        
        ctrl_reg_write_i      
        ctrl_ALUOp_i          
        addr_current_i        
        rd1_i                 
        rd2_i                 
        imm_gen_i             
        funct7_30_i           
        funct3_i              
        hz_ALUresult_MEM_i    
        hz_data_wb_i          
        hz_sel_ALU1_i         
        hz_sel_ALU2_i         
        ctrl_branch_o         
        ctrl_mem_read_o       
        ctrl_mem_to_reg_o     
        ctrl_mem_write_o      
        ctrl_reg_write_o      
        addr_branch_o         
        branch_taken_o        
        ALUresult_o           
        ALU2_i_o              
    );

endmodule
