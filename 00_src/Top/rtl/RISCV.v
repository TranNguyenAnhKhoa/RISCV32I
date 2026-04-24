module RISCV(
    input clk_i,
    input rstn_i
);
    //----------------------------------------
    //              wires & regs
    //----------------------------------------
    
        //-----------fetch stage------------------
    wire [31:0] instr_IF_w;
    wire [31:0] addr_IF_w;
    
        //----------decode stage------------------
    wire        ctrl_branch_ID_w        ; 
    wire        ctrl_mem_read_ID_w      ;  
    wire        ctrl_mem_to_reg_ID_w    ;
    wire        ctrl_mem_write_ID_w     ; 
    wire [1:0]  ctrl_ALUOp_ID_w         ;    
    wire        ctrl_reg_write_ID_w     ;   
    wire [31:0]  rd1_ID_w               ;
    wire [31:0]  rd2_ID_w               ;
    wire [31:0] addr_current_ID_w       ;
    wire [31:0] imm_gen_ID_w            ; 
    wire        funct7_30_ID_w          ;
    wire [2:0]  funct3_ID_w             ;
    wire [4:0]  rs1_ID_w                ;
    wire [4:0]  rs2_ID_w                ;
    wire [4:0]  write_rd_ID_w           ;
        //----------execute stage----------------- 
    wire [31:0] addr_branch_EXE_w       ;
    wire        ctrl_mem_read_EXE_w     ;
    wire        ctrl_mem_to_reg_EXE_w   ;
    wire        ctrl_mem_write_EXE_w    ;
    wire        ctrl_reg_write_EXE_w    ;
    wire [2:0]  funct3_EXE_w            ;
    wire [4:0]  write_rd_EXE_w          ;
    wire [31:0] ALUresult_EXE_w         ;
    wire [31:0] ALU2_i_EXE_w            ;
    wire        is_branch_EXE_w         ;
    wire        write_IDEX_w            ;
    wire        write_PC_w              ;

        //----------memory stage------------------
    wire        ctrl_mem_to_reg_MEM_w   ;
    wire        ctrl_reg_write_MEM_w    ;
    wire [31:0] DMEM_data_MEM_w         ;
    wire [31:0] ALUresult_MEM_w         ;
    wire [31:0] addr_branch_MEM_w       ;
    wire [4:0]  write_rd_MEM_w          ;
    wire [2:0]  funct3_MEM_w            ;
        //---------write back stage---------------
    wire [31:0] data_WB_w = (ctrl_mem_to_reg_MEM_w) ? DMEM_data_MEM_w : ALUresult_MEM_w;

        // hazard signal
    wire        hz_flush_w;
    wire        hz_write_PC_en_w;
    wire        hz_ctrl_w;
    wire [1:0]  hz_ALU1_w;
    wire [1:0]  hz_ALU2_w;

    // ----------------------------------------------
    //          Internal blocks
    // ----------------------------------------------   
    IF_stage IF_stage_inst(
        .clk_i          (clk_i              ),
        .rstn_i         (rstn_i             ),
        .branch_i       (is_branch_EXE_w    ),
        .flush_i        (hz_flush_w         ),
        .write_PC_en_i  (hz_write_PC_en_w   ),
        .addr_branch_i  (addr_branch_EXE_w  ),
        .instruction_o  (instr_IF_w          ),
        .addr_current_o (addr_IF_w          )    
    );

    ID_stage ID_stage_inst(
        .clk_i             (clk_i                   ), 
        .rstn_i            (rstn_i                  ), 
        .instruction_i     (instr_IF_w              ), 
        .addr_current_i    (addr_IF_w               ),
        .write_back_data_i (data_WB_w               ), 
        .write_rd_i        (write_rd_MEM_w           ), 
        .hz_ctrl_i         (hz_ctrl_w               ), 
        .reg_write_en_i    (ctrl_reg_write_MEM_w    ),
        .funct7_30_o       (funct7_30_ID_w          ),
        .funct3_o          (funct3_ID_w             ),
        .ctrl_branch_o     (ctrl_branch_ID_w        ), 
        .ctrl_mem_read_o   (ctrl_mem_read_ID_w      ), 
        .ctrl_mem_to_reg_o (ctrl_mem_to_reg_ID_w    ), 
        .ctrl_mem_write_o  (ctrl_mem_write_ID_w     ),
        .ctrl_reg_write_o  (ctrl_reg_write_ID_w     ),
        .ctrl_ALUOp_o      (ctrl_ALUOp_ID_w         ),
        .rd1_o             (rd1_ID_w                ), 
        .rd2_o             (rd2_ID_w                ), 
        .addr_current_o    (addr_current_ID_w       ), 
        .imm_gen_o         (imm_gen_ID_w            ),
        .rs1_o             (rs1_ID_w                ),
        .rs2_o             (rs2_ID_w                ),
        .write_rd_o        (write_rd_ID_w           )
    );

    EXE_stage EXE_stage_inst(
        .clk_i              (clk_i                  ),   
        .rstn_i             (rstn_i                 ),  
        .ctrl_branch_i      (ctrl_branch_ID_w       ),   
        .ctrl_mem_read_i    (ctrl_mem_read_ID_w     ),   
        .ctrl_mem_to_reg_i  (ctrl_mem_to_reg_ID_w   ),   
        .ctrl_mem_write_i   (ctrl_mem_write_ID_w    ),  
        .ctrl_reg_write_i   (ctrl_reg_write_ID_w    ),   
        .ctrl_ALUOp_i       (ctrl_ALUOp_ID_w        ),   
        .addr_current_i     (addr_current_ID_w      ),   
        .rd1_i              (rd1_ID_w               ),   
        .rd2_i              (rd2_ID_w               ),   
        .imm_gen_i          (imm_gen_ID_w           ),   
        .funct7_30_i        (funct7_30_ID_w         ),   
        .funct3_i           (funct3_ID_w            ),
        .funct3_o           (funct3_EXE_w           ),   
        .ALUresult_MEM_i    (ALUresult_MEM_w        ),   
        .data_wb_i          (data_WB_w              ),   
        .hz_sel_ALU1_i      (hz_ALU1_w              ),   
        .hz_sel_ALU2_i      (hz_ALU2_w              ),
        .write_rd_i         (write_rd_ID_w          ),
        .write_rd_o         (write_rd_EXE_w         ),  
        .ctrl_mem_read_o    (ctrl_mem_read_EXE_w    ),   
        .ctrl_mem_to_reg_o  (ctrl_mem_to_reg_EXE_w  ),   
        .ctrl_mem_write_o   (ctrl_mem_write_EXE_w   ),   
        .ctrl_reg_write_o   (ctrl_reg_write_EXE_w   ),   
        .addr_branch_o      (addr_branch_EXE_w      ), 
        .ALUresult_o        (ALUresult_EXE_w        ),   
        .ALU2_i_o           (ALU2_i_EXE_w           ), 
        .is_branch_o        (is_branch_EXE_w        )
    );

    MEM_stage MEM_stage_inst(
        .clk_i             (clk_i                   ),
        .rstn_i            (rstn_i                  ),
        .ctrl_mem_read_i   (ctrl_mem_read_EXE_w     ),
        .ctrl_mem_write_i  (ctrl_mem_write_EXE_w    ),
        .ctrl_reg_write_i  (ctrl_reg_write_EXE_w    ),
        .ctrl_mem_to_reg_i (ctrl_mem_to_reg_EXE_w   ),
        .ALUresult_i       (ALUresult_EXE_w         ),
        .ALU2i_i           (ALU2_i_EXE_w            ),
        .write_rd_i        (write_rd_EXE_w          ),
        .funct3_i          (funct3_EXE_w            ),
        .ctrl_mem_to_reg_o (ctrl_mem_to_reg_MEM_w   ),
        .ctrl_reg_write_o  (ctrl_reg_write_MEM_w    ),
        .DMEM_data_o       (DMEM_data_MEM_w         ),
        .ALUresult_o       (ALUresult_MEM_w         ),
        .write_rd_o        (write_rd_MEM_w          )
    );

    hazard_detection hazard_detection_inst(
        .rs1_IFID_i         (instr_IF_w[19:15]      ),
        .rs2_IFID_i         (instr_IF_w[24:20]      ),
        .rd_IDEX_i          (write_rd_ID_w          ),
        .rd_EXMEM_i         (write_rd_EXE_w          ),
        .write_reg_IDEX_i   (ctrl_reg_write_ID_w    ),
        .mem_read_IDEX_i    (ctrl_mem_read_ID_w     ),
        .mem_read_EXMEM_i   (ctrl_mem_read_EXE_w    ),
        .branch_ID_i        (ctrl_branch_ID_w      ),
        .is_jalr_i          (   (instr_IF_w & `INST_JALR_MASK) == `INST_JALR ),
        .write_IDEX_o       (hz_flush_w             ),
        .write_PC_o         (hz_write_PC_en_w       ),
        .control_mux_o      (hz_ctrl_w              )
    );

    forwarding forwarding_inst( 
        .reg_write_EXMEM_i  (ctrl_reg_write_EXE_w   ),
        .reg_write_MEMWB_i  (ctrl_reg_write_MEM_w   ),
        .rs1_IDEX_i         (rs1_ID_w               ),
        .rs2_IDEX_i         (rs2_ID_w               ),
        .rd_EXMEM_i         (write_rd_EXE_w         ),
        .rd_MEMWB_i         (write_rd_MEM_w         ),
        .mux_ALU1_o         (hz_ALU1_w              ),
        .mux_ALU2_o         (hz_ALU2_w              )

    );
endmodule
