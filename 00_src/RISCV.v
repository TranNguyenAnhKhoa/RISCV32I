module RISCV(
    input i_clk,
    input i_rstn
);
    //----------------------------------------
    //              WIRE
    //----------------------------------------
    
    //-----------fetch stage------------------
    wire [31:0] w_instruction_f, w_addr_current_f;
    
    //----------decode stage------------------
    wire        w_branch_d, w_mem_read_d, w_mem_to_reg_d, w_mem_write_d, w_ALU_src_d, w_reg_write_d;
    wire [1:0]  w_ALUOp_d; 
    wire [31:0] w_read_data1_d, w_read_data2_d;
    wire        w_funct7_30_d;  
    wire [2:0]  w_funct3_d;      
    wire [4:0]  w_rd_d, w_rs1_d, w_rs2_d;          
    wire [31:0] w_addr_current_d, w_imm_gen_out_d;
    wire        w_branch_taken_d;

    //----------execute stage-----------------          
    wire        w_branch_exe, w_mem_read_exe, w_mem_to_reg_exe, w_mem_write_exe, w_reg_write_exe;
    wire [31:0] w_addr_branch_exe ;
    wire        w_branch_taken_exe;
    wire [31:0] w_ALU_out_exe     ;
    wire [31:0] w_read_data2_exe  ;
    wire [4:0]  w_rd_exe          ;
    
    //----------memory stage------------------
    wire        w_mem_to_reg_mem;
    wire        w_is_branch_mem;
    wire [31:0] w_addr_branch_mem, w_DMEM_out_mem, w_ALU_out_mem;
    
    //---------write back stage---------------
    wire [31:0] w_write_back_wb;
    wire [4:0]  w_rd_mem;
    wire        w_reg_write_mem;
    
    /// control signal
    wire        w_branch, w_mem_read, w_mem_to_reg, w_mem_write, w_ALU_src, w_reg_write;
    wire [1:0]  w_ALUOp;

    // hazard signal
    wire        w_flush, w_write_PC, w_control_mux;
    wire [1:0]  w_forwarding_mux_ALU1, w_forwarding_mux_ALU2;


    IF_stage IF_stage_inst0(
        .i_clk          (i_clk              ), 
        .i_rstn         (i_rstn             ),
        
        .i_flush        (w_flush            ),
        .i_write_PC     (w_write_PC         ),
        
        .i_is_branch    (w_branch_taken_d   ),
        .i_addr_branch  (w_addr_branch_mem  ),
        .o_instruction  (w_instruction_f    ),
        .o_addr_current (w_addr_current_f   )
    );

    ID_stage ID_stage_inst0(
        //control signal
        .i_clk          (i_clk              ), 
        .i_rstn         (i_rstn             ),
        .i_instruction  (w_instruction_f    ),
        .i_addr_current (w_addr_current_f   ),
        .i_write_back   (w_write_back_wb    ),
        .i_rd           (w_rd_mem           ),
        .i_reg_write    (w_reg_write_mem    ),
        .i_control_mux  (w_control_mux      ),
        .o_branch       (w_branch_d         ), 
        .o_mem_read     (w_mem_read_d       ), 
        .o_mem_to_reg   (w_mem_to_reg_d     ), 
        .o_mem_write    (w_mem_write_d      ), 
        .o_ALU_src      (w_ALU_src_d        ), 
        .o_reg_write    (w_reg_write_d      ),
        .o_ALUOp        (w_ALUOp_d          ),
        .o_read_data1   (w_read_data1_d     ), 
        .o_read_data2   (w_read_data2_d     ),
        .o_funct7_30    (w_funct7_30_d      ),
        .o_funct3       (w_funct3_d         ),
        .o_rs1          (w_rs1_d            ),
        .o_rs2          (w_rs2_d            ),
        .o_rd           (w_rd_d             ),
        .o_addr_current (w_addr_current_d   ),
        .o_imm_gen_out  (w_imm_gen_out_d    ),
        .o_branch_taken (w_branch_taken_d   )

    );

    EXE_stage EXE_stage_inst0(
        //control signal
    .i_clk              (i_clk                  ), 
    .i_rstn             (i_rstn                 ),
    .i_branch           (w_branch_d             ), 
    .i_mem_read         (w_mem_read_d           ), 
    .i_mem_to_reg       (w_mem_to_reg_d         ), 
    .i_mem_write        (w_mem_write_d          ), 
    .i_ALU_src          (w_ALU_src_d            ), 
    .i_reg_write        (w_reg_write_d          ),
    .i_ALUOp            (w_ALUOp_d              ),
    .i_addr_current     (w_addr_current_d       ),
    .i_read_data1       (w_read_data1_d         ), 
    .i_read_data2       (w_read_data2_d         ),
    .i_imm_gen_out      (w_imm_gen_out_d        ),
    .i_funct7_30        (w_funct7_30_d          ),
    .i_funct3           (w_funct3_d             ),
    .i_rd               (w_rd_d                 ),
    .i_sel_mux1         (w_forwarding_mux_ALU1  ), 
    .i_sel_mux2         (w_forwarding_mux_ALU2  ),
    .i_ALU_result_MEM   (w_ALU_out_exe          ),
    .i_data_wire_back   (w_write_back_wb        ),
    
    .o_branch           (w_branch_exe           ), 
    .o_mem_read         (w_mem_read_exe         ), 
    .o_mem_to_reg       (w_mem_to_reg_exe       ), 
    .o_mem_write        (w_mem_write_exe        ), 
    .o_reg_write        (w_reg_write_exe        ),
    .o_addr_branch      (w_addr_branch_exe      ),
    //.o_branch_taken     (w_branch_taken_exe     ),
    .o_ALU_out          (w_ALU_out_exe          ),
    .o_mux_alu2         (w_read_data2_exe       ),
    .o_rd               (w_rd_exe               )
    
    );

    MEM_stage MEM_stage_inst0(
        //control signal
    .i_clk          (i_clk              ), 
    .i_rstn         (i_rstn             ),
    .i_mem_read     (w_mem_read_exe     ),     
    .i_mem_write    (w_mem_write_exe    ), 
    .i_reg_write    (w_reg_write_exe    ), 
    .i_mem_to_reg   (w_mem_to_reg_exe   ),
    .i_ALU_out      (w_ALU_out_exe      ),
    .i_read_data2   (w_read_data2_exe   ),
    .i_rd           (w_rd_exe           ),
    .i_funct3       (w_funct3_d         ),
    .i_addr_branch  (w_addr_branch_exe  ),
    
    .o_addr_branch  (w_addr_branch_mem  ),
    .o_mem_to_reg   (w_mem_to_reg_mem   ),
    .o_DMEM_out     (w_DMEM_out_mem     ), 
    .o_ALU_out      (w_ALU_out_mem      ),
    .o_rd           (w_rd_mem           ),
    .o_reg_write    (w_reg_write_mem    )
    );
    // write back stage
        //control signal
    mux21 mux_wb_inst0(
        .i_input0 (w_ALU_out_mem    ), 
        .i_input1 (w_DMEM_out_mem   ),
        .i_sel    (w_mem_to_reg_mem ),
        .o_output (w_write_back_wb  )  
    );

    // Hazard Handle
    forwarding forwarding_unit_inst0(
        .i_reg_write_EXMEM (w_reg_write_exe         ),
        .i_reg_write_MEMWB (w_reg_write_mem         ),
        .i_rs1_IDEX        (w_rs1_d                 ),
        .i_rs2_IDEX        (w_rs1_d                 ),
        .i_rd_EXMEM        (w_rd_exe                ),
        .i_rd_MEMWB        (w_rd_mem                ),

        .o_mux_ALU1        (w_forwarding_mux_ALU1   ), 
        .o_mux_ALU2        (w_forwarding_mux_ALU2   )
    );

    hazard_detection hazard_detection_unit_inst0(
        .i_rs1_IFID         (w_instruction_f[19:15]),
        .i_rs2_IFID         (w_instruction_f[24:20]),
        .i_rd_IDEX          (w_rd_d                 ),
        .i_rd_EXMEM         (w_rd_exe               ),
        .i_branch_ID        (w_branch_d             ),
        .i_is_jalr          (w_instruction_f[5]     ),

        .i_write_reg_IDEX   (w_reg_write_d          ),
        .i_mem_read_IDEX    (w_mem_read_d           ),
        .i_mem_read_EXMEM   (w_mem_read_exe         ),

        .o_write_IDEX       (w_flush                ),
        .o_write_PC         (w_write_PC             ),
        .o_control_mux      (w_control_mux          ) 
    );

endmodule
