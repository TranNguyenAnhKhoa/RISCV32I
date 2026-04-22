module ID_stage(
    input         clk_i                 ,
    input         rstn_i                ,

    input [31:0]  instruction_i         ,
    input [31:0]  addr_current_i        ,
    input [31:0]  write_back_data_i     ,
    input [4:0 ]  write_rd_i             ,
    input         hz_ctrl_i             ,       // hazard control
    input         reg_write_en_i        ,       // control signal 
    output        ctrl_branch_o         ,       // control signal
    output        ctrl_mem_read_o       ,       // control signal
    output        ctrl_mem_to_reg_o     ,       // control signal
    output        ctrl_mem_write_o      ,       // control signal
    output        ctrl_ALUsrc_o         ,       // control signal
    output        ctrl_reg_write_o      ,       // control signal
    output [1:0 ] ctrl_ALUOp_o          ,       // control signal
    output [31:0] rd1_o                 ,
    output [31:0] rd2_o                 ,
    output [31:0] addr_current_o        ,
    output [31:0] imm_gen_o 

    );
    //----------------------------------------
    //              WIRE & REG
    //---------------------------------------- 
    wire [31:0] instruction_w;
    wire [31:0] addr_current_w; 
    wire [31:0] w_addr_branch; 
    wire [31:0] addr_next_w;
    wire [31:0] w_addr_plus4;
    wire [31:0] rd1_w; 
    wire [31:0] rd2_w;
    wire [31:0] imm_gen_w;

    wire        ctrl_branch_w    ; 
    wire        ctrl_mem_read_w  ; 
    wire        ctrl_mem_to_reg_w; 
    wire        ctrl_mem_write_w ;  
    wire        ctrl_ALUsrc_w   ; 
    wire        ctrl_reg_write_w ;
    wire [1:0]  ctrl_ALUOp_w     ;
    
    reg [31:0]  addr_current_r      ;
    reg [31:0]  instruction_r       ;

    reg         ctrl_branch_r    ;
    reg         ctrl_mem_read_r  ;
    reg         ctrl_mem_to_reg_r;
    reg         ctrl_mem_write_r ;
    reg         ctrl_ALUsrc_r   ;
    reg         ctrl_reg_write_r ;
    reg [1:0]   ctrl_ALUOp_r     ;
    reg [31:0]  imm_gen_r       ;
    reg         funct7_30_r;
    reg [2:0]   funct3_r;
    reg [4:0]   rs1_r;
    reg [4:0]   rs2_r;
    reg [4:0]   rd_r;
    reg [31:0]  rd1_r;
    reg [31:0]  rd2_r;
    // ----------------------------------------------
    //          Combinational logic
    // ----------------------------------------------
    assign addr_current_o = addr_current_r;
    assign imm_gen_o      = imm_gen_r;
    assign instruction_w  = instruction_i  ;
    assign rd1_o          = rd1_r          ;
    assign rd2_o          = rd2_r          ;
    // ---------------control-----------------------
    assign ctrl_branch_o     = ctrl_branch_r    ;
    assign ctrl_mem_read_o   = ctrl_mem_read_r  ;
    assign ctrl_mem_to_reg_o = ctrl_mem_to_reg_r;
    assign ctrl_mem_write_o  = ctrl_mem_write_r ;
    assign ctrl_ALUsrc_o     = ctrl_ALUsrc_r   ;
    assign ctrl_reg_write_o  = ctrl_reg_write_r ;
    assign ctrl_ALUOp_o      = ctrl_ALUOp_r     ;
    // ----------------------------------------------
    //          Sequential logic
    // ----------------------------------------------
    always @(posedge clk_i or rstn_i or hz_ctrl_i) begin
        if(hz_ctrl_i) begin
            ctrl_branch_r        <= 1'b0         ;
            ctrl_mem_read_r      <= 1'b0         ;
            ctrl_mem_to_reg_r    <= 1'b0         ;
            ctrl_mem_write_r     <= 1'b0         ;
            ctrl_ALUsrc_r       <= 1'b0         ;
            ctrl_reg_write_r     <= 1'b0         ;
            ctrl_ALUOp_r         <= 2'b0         ;
        end
        if(!rstn_i) begin
            ctrl_branch_r        <= 1'b0         ;
            ctrl_mem_read_r      <= 1'b0         ;
            ctrl_mem_to_reg_r    <= 1'b0         ;
            ctrl_mem_write_r     <= 1'b0         ;
            ctrl_ALUsrc_r       <= 1'b0         ;
            ctrl_reg_write_r     <= 1'b0         ;
            ctrl_ALUOp_r         <= 2'b0         ;

            addr_current_r  <= 32'h0000_0000;

            imm_gen_r       <= 32'h0000_0000;
            funct7_30_r     <= 1'b0         ;
            funct3_r        <= 3'b000       ;
            rs1_r           <= 5'b0000_0    ;
            rs2_r           <= 5'b0000_0    ;
            rd_r            <= 5'b0000_0    ;
            rd1_r           <= 32'b0        ;
            rd2_r           <= 32'b0        ;


        end else begin
            ctrl_branch_r        <=  ctrl_branch_w    ;
            ctrl_mem_read_r      <=  ctrl_mem_read_w  ;
            ctrl_mem_to_reg_r    <=  ctrl_mem_to_reg_w;
            ctrl_mem_write_r     <=  ctrl_mem_write_w ;
            ctrl_ALUsrc_r       <=  ctrl_ALUsrc_w   ;
            ctrl_reg_write_r     <=  ctrl_reg_write_w ;
            ctrl_ALUOp_r         <=  ctrl_ALUOp_w     ;

            addr_current_r  <= addr_current_i       ;
            imm_gen_r       <= imm_gen_w        ;

            funct7_30_r     <= instruction_w[30]    ;
            funct3_r        <= instruction_w[14:12] ;
            rs1_r           <= instruction_w[19:15] ;
            rs2_r           <= instruction_w[24:20] ;
            rd_r            <= instruction_w[11:7]  ;
            rd1_r           <= rd1_w         ;
            rd2_r           <= rd2_w         ;
        end
        
    end
    // ----------------------------------------------
    //          Internal blocks
    // ----------------------------------------------    
    control controller_inst0(
        .instruction_i  (instruction_i      ),
        .branch_o       (ctrl_branch_w       ), 
        .mem_read_o     (ctrl_mem_read_w     ), 
        .mem_to_reg_o   (ctrl_mem_to_reg_w   ), 
        .mem_write_o    (ctrl_mem_write_w    ), 
        .ALUsrc_o       (ctrl_ALUsrc_w      ), 
        .reg_write_o    (ctrl_reg_write_w    ),
        .ALUOp_o        (ctrl_ALUOp_w        )
    );

    register_file RF_inst0(
        .clk_i          (clk_i                  ),
        .rstn_i         (rstn_i                 ),
        .rs1_i          (instruction_i[19:15]   ),
        .rs2_i          (instruction_i[24:20]   ),

        .rd_i           (write_rd_i             ),
        .rd_value_i     (write_back_data_i      ),

        .reg_write_i    (reg_write_en_i         ),

        .read_rs1_o     (rd1_w                  ),
        .read_rs2_o     (rd2_w                  )
    );

    immediate_generator imm_gen_inst0(
        .instruction_i  (instruction_i),
        .output_o       (imm_gen_w)
    );

endmodule
