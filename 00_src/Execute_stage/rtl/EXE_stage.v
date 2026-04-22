module EXE_stage(
    input         clk_i                 , 
    input         rstn_i                ,
    input         instruction_i         ,
    input         ctrl_branch_i         ,
    input         ctrl_mem_read_i       ,
    input         ctrl_mem_to_reg_i     ,
    input         ctrl_mem_write_i      ,
    input         ctrl_ALU_src_i        ,
    input         ctrl_reg_write_i      ,
    input [1:0 ]  ctrl_ALUOp_i          ,
    input [31:0]  addr_current_i        ,
    input [31:0]  rd1_i                 ,
    input [31:0]  rd2_i                 ,
    input [31:0]  imm_gen_i             ,
    input         funct7_30_i           ,
    input [2:0]   funct3_i              ,
    input [31:0]  hz_ALUresult_MEM_i    , 
    input [31:0]  hz_data_wb_i          ,
    input [1:0]   hz_sel_ALU1_i         , 
    input [1:0]   hz_sel_ALU2_i         ,
    output        ctrl_branch_o         , 
    output        ctrl_mem_read_o       , 
    output        ctrl_mem_to_reg_o     , 
    output        ctrl_mem_write_o      , 
    output        ctrl_reg_write_o      ,
    output [31:0] addr_branch_o         ,
    output        branch_taken_o        ,
    output [31:0] ALUresult_o           ,
    output [31:0] ALU2_i_o              

);
    //----------------------------------------
    //              WIRE & REG
    //---------------------------------------- 
    wire        ctrl_branch_w    ; 
    wire        ctrl_mem_read_w  ; 
    wire        ctrl_mem_to_reg_w; 
    wire        ctrl_mem_write_w ;  
    wire        ctrl_ALU_src_w   ; 
    wire        ctrl_reg_write_w ;
    wire [1:0]  ctrl_ALUOp_w     ;
    wire        branch_taken_w;
    wire [31:0] ALU1_i_w;
    wire [31:0] ALU2_i_w;
    wire [3:0]  ALUctrl_w;
    wire [31:0] ALUout_w; 
    wire [31:0] addr_branch_w;

    reg         branch_r     ;
    reg         mem_read_r   ;
    reg         mem_to_reg_r ;
    reg         mem_write_r  ;
    reg         reg_write_r  ;
    reg         ALU2_i_r     ;
    // ----------------------------------------------
    //          Combinational logic
    // ----------------------------------------------
    assign ctrl_branch_o     = ctrl_branch_r    ;
    assign ctrl_mem_read_o   = ctrl_mem_read_r  ;
    assign ctrl_mem_to_reg_o = ctrl_mem_to_reg_r ;
    assign ctrl_mem_write_o  = ctrl_mem_write_r ;
    assign ctrl_reg_write_o  = ctrl_reg_write_r ;

    assign addr_branch_o = addr_branch_r ;

    assign ALU2_i_o = ALU2_i_r;
    assign ALU1_i_w =   (hz_sel_ALU1_i == 00) ? i_read_data1     :
                        (hz_sel_ALU1_i == 01) ? i_data_wire_back :
                        (hz_sel_ALU1_i == 10) ? i_ALU_result_MEM :
                        32'h0000_0000;

    assign ALU2_i_w =   (hz_sel_ALU2_i == 00) ? i_read_data2     :
                        (hz_sel_ALU2_i == 01) ? i_data_wire_back :
                        (hz_sel_ALU2_i == 10) ? i_ALU_result_MEM :
                        32'h0000_0000;
    
    assign addr_branch_o = addr_branch_r;
    assign branch_taken_o = branch_taken_r;
    
    // ----------------------------------------------
    //          Sequential logic
    // ----------------------------------------------
always @(posedge clk_i) begin
        if(i_rstn) begin
            ctrl_branch_r        <= 1'b0         ;
            ctrl_mem_read_r      <= 1'b0         ;
            ctrl_mem_to_reg_r    <= 1'b0         ;
            ctrl_mem_write_r     <= 1'b0         ;
            ctrl_ALU_src_r       <= 1'b0         ;
            ctrl_reg_write_r     <= 1'b0         ;

            ALU2_i_r             <= 32'h0000_0000;
            o_mem_to_reg        <= 0    ;
        end else begin
            ctrl_branch_r       <= ctrl_branch_i      ;
            ctrl_mem_read_r     <= ctrl_mem_read_i    ;
            ctrl_mem_to_reg_r   <= ctrl_mem_to_reg_i  ;
            ctrl_mem_write_r    <= ctrl_mem_write_i   ;
            ctrl_reg_write_r    <= ctrl_reg_write_i   ;
            addr_branch_r       <= addr_current_i + imm_gen_i  ;
            ALU2_i_r            <= ALU2_i_w           ;
            o_mem_to_reg        <= w_mem_to_reg  ;
        end
        
    end

    ALU ALU_inst0(
        .A_i        (ALU1_i_w   ),
        .B_i        (ALU2_i_w   ),
        .op_i       (ALUctrl_w  ),
        .result_o   (ALUout_w  )
    );

    ALU_control ALU_control_inst0(
        .i_ALUOp        (ctrl_ALUOp_i        ),
        .funct3_i       (funct3_i       ),
        .funct7_30_i    (funct7_30_i    ),
        .ALUctrl_o      (ALUctrl_w      )
    );
    comparator comparator_inst0(
        .A_i            (rd1_i          ), 
        .B_i            (rd1_i          ),
        .funct3_i       (funct3_i       ),
        .branch_taken_o (branch_taken_w )
    );


endmodule
