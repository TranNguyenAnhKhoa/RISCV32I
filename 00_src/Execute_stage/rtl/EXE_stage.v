module EXE_stage(
    input         clk_i              , 
    input         rstn_i             ,
    input         ctrl_branch_i      ,
    input         ctrl_mem_read_i    ,
    input         ctrl_mem_to_reg_i  ,
    input         ctrl_mem_write_i   ,
    input         ctrl_reg_write_i   ,
    input [1:0]   ctrl_ALUOp_i       ,
    input [31:0]  addr_current_i     ,
    input [31:0]  rd1_i              ,
    input [31:0]  rd2_i              ,
    input [31:0]  imm_gen_i          ,
    input         funct7_30_i        ,
    input [2:0]   funct3_i           ,
    input [31:0]  ALUresult_MEM_i    , 
    input [31:0]  data_wb_i          ,
    input [1:0]   hz_sel_ALU1_i      , 
    input [1:0]   hz_sel_ALU2_i      ,
    input [4:0 ]  write_rd_i         , 
    output        ctrl_mem_read_o    , 
    output        ctrl_mem_to_reg_o  , 
    output        ctrl_mem_write_o   , 
    output        ctrl_reg_write_o   ,

    output [31:0] addr_branch_o      ,
    output        is_branch_o        ,
    output [31:0] ALUresult_o        ,
    output [31:0] ALU2_i_o           ,
    output [2:0]  funct3_o           ,
    output [4:0 ] write_rd_o            

);
    //----------------------------------------
    //              WIRE & REG
    //---------------------------------------- 

    wire        ctrl_mem_read_w  ; 
    wire        ctrl_mem_to_reg_w; 
    wire        ctrl_mem_write_w ;  
    wire        ctrl_reg_write_w ;
    wire        branch_taken_w;
    wire [31:0] ALU1_i_w;
    wire [31:0] ALU2_i_w;
    wire [3:0]  ALUctrl_w;
    wire [31:0] ALUresult_w; 

    reg         ctrl_mem_read_r   ;
    reg         ctrl_mem_to_reg_r ;
    reg         ctrl_mem_write_r  ;
    reg         ctrl_reg_write_r  ;
    reg [31:0]  ALU2_i_r     ;
    reg [31:0]  ALUresult_r  ;
    reg [2:0]   funct3_r     ;
    reg [4:0]   write_rd_r   ;

    // ----------------------------------------------
    //          Combinational logic
    // ----------------------------------------------

    assign ctrl_mem_read_o   = ctrl_mem_read_r  ;
    assign ctrl_mem_to_reg_o = ctrl_mem_to_reg_r ;
    assign ctrl_mem_write_o  = ctrl_mem_write_r ;
    assign ctrl_reg_write_o  = ctrl_reg_write_r ;

    assign addr_branch_o = addr_current_i + imm_gen_i ;
    assign is_branch_o = ctrl_branch_i && branch_taken_w ;

    assign ALU2_i_o = ALU2_i_r;
    assign ALU1_i_w =   (hz_sel_ALU1_i == 2'b00) ? rd1_i           :
                        (hz_sel_ALU1_i == 2'b01) ? data_wb_i       :
                        (hz_sel_ALU1_i == 2'b10) ? ALUresult_MEM_i :
                        32'h0000_0000;

    assign ALU2_i_w =   (hz_sel_ALU2_i == 2'b00) ? rd2_i           :
                        (hz_sel_ALU2_i == 2'b01) ? ALUresult_MEM_i :
                        (hz_sel_ALU2_i == 2'b10) ? data_wb_i       :
                        32'h0000_0000;
    
    assign ALUresult_o = ALUresult_r;
    assign funct3_o = funct3_r; 
    assign write_rd_o = write_rd_r;
    // ----------------------------------------------
    //          Sequential logic
    // ----------------------------------------------
always @(posedge clk_i or rstn_i) begin
        if(rstn_i) begin
            ctrl_mem_read_r     <= 1'b0                 ;
            ctrl_mem_to_reg_r   <= 1'b0                 ;
            ctrl_mem_write_r    <= 1'b0                 ;
            ctrl_reg_write_r    <= 1'b0                 ;
            ALU2_i_r            <= 32'h0000_0000        ;
            ALUresult_r         <= 32'h0000_0000        ;
            funct3_r            <= 3'b000               ;
            write_rd_r          <= 5'b00000             ;
        end else begin

            ctrl_mem_read_r     <= ctrl_mem_read_i                  ;
            ctrl_mem_to_reg_r   <= ctrl_mem_to_reg_i                ;
            ctrl_mem_write_r    <= ctrl_mem_write_i                 ;
            ctrl_reg_write_r    <= ctrl_reg_write_i                 ;
            ALU2_i_r            <= ALU2_i_w                         ;
            ALUresult_r         <= ALUresult_w                      ;
            funct3_r            <= funct3_i                         ;
            write_rd_r          <= write_rd_i                       ;

        end
        
    end

    ALU ALU_inst0(
        .A_i        (ALU1_i_w   ),
        .B_i        (ALU2_i_w   ),
        .op_i       (ALUctrl_w  ),
        .result_o   (ALUresult_w  )
    );

    ALU_control ALU_control_inst0(
        .ALUOp_i        (ctrl_ALUOp_i   ),
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
