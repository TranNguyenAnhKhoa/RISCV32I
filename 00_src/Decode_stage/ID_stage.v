module ID_stage(
    input         clk_i             ,
    input         rstn_i            ,

    input [31:0]  instruction_i     ,
    input [31:0]  addr_current_i    ,
    input [31:0]  write_back_data_i ,
    input [4:0 ]  write_reg         ,

    // hazard control
    input         ctr_hazard_i      ,

    // control signal
    input         reg_write_en_i    ,
    output        branch_o          ,
    output        mem_read_o        ,
    output        mem_to_reg_o      ,
    output        mem_write_o       ,
    output        ALU_src_o         ,
    output        reg_write_o       ,
    output [1:0 ] ALUOp_o           ,

    output [31:0] rd1_o             ,
    output [31:0] rd2_o             ,
    output [31:0] instruction_o     ,
    output [31:0] addr_current_o    ,
    output [31:0] imm_gen_o 

    );
    //----------------------------------------
    //              WIRE
    //---------------------------------------- 
    wire [31:0] instruction_w;
    wire [31:0] addr_current_w; 
    wire [31:0] w_addr_branch; 
    wire [31:0] addr_next_w;
    wire [31:0] w_addr_plus4;
    wire [31:0] w_read_data1; 
    wire [31:0] w_read_data2;
    wire [31:0] w_imm_gen_out;

    wire branch_w       ; 
    wire w_mem_read_o   ; 
    wire w_mem_to_reg   ; 
    wire w_mem_write    ;  
    wire w_ALU_src      ; 
    wire w_reg_write    ;
    wire [1:0] w_ALUOp  ;
    wire [7:0] w_control_signal;
    
    assign addr_current_o = addr_current_i ;
    assign instruction_w  = instruction_i  ;
    //----------------------------------------
    //              REG
    //---------------------------------------- 
    reg [31:0] addr_current_r;
    reg [31:0] instruction_r;

    // ----------------------------------------------
    //          Combinational logic
    // ----------------------------------------------
    assign addr_current_o = addr_current_r;
    
    // ----------control
    assign branch_o     = branch_r    ;
    assign mem_read_o   = mem_read_r  ;
    assign mem_to_reg_o = mem_to_reg_r;
    assign mem_write_o  = mem_write_r ;
    assign ALU_src_o    = ALU_src_r   ;
    assign reg_write_o  = reg_write_r ;
    assign ALUOp_o      = ALUOp_r     ;
    // ----------------------------------------------
    //          Sequential logic
    // ----------------------------------------------
    always @(posedge clk_i or negedge rstn_i or ctr_hazard_i) begin
        if(ctr_hazard_i) begin
            branch_r        <= 1'b0         ;
            mem_read_r      <= 1'b0         ;
            mem_to_reg_r    <= 1'b0         ;
            mem_write_r     <= 1'b0         ;
            ALU_src_r       <= 1'b0         ;
            reg_write_r     <= 1'b0         ;
            ALUOp_r         <= 2'b0         ;
        end
        if(rstn_i) begin
            branch_r        <= 1'b0         ;
            mem_read_r      <= 1'b0         ;
            mem_to_reg_r    <= 1'b0         ;
            mem_write_r     <= 1'b0         ;
            ALU_src_r       <= 1'b0         ;
            reg_write_r     <= 1'b0         ;
            ALUOp_r         <= 2'b0         ;

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
            branch_o        <= w_control_signal[7]  ;
            mem_read_o      <= w_control_signal[6]  ;
            mem_to_reg_o    <= w_control_signal[5]  ;
            mem_write_o     <= w_control_signal[4]  ;
            ALU_src_o       <= w_control_signal[3]  ;
            reg_write_o     <= w_control_signal[2]  ;
            ALUOp_o         <= w_control_signal[1:0];

            addr_current_r  <= addr_current_i       ;
            o_imm_gen_out   <= w_imm_gen_out        ;

            o_funct7_30     <= instruction_w[30]    ;
            funct3_o        <= instruction_w[14:12] ;
            rs1_o           <= instruction_w[19:15] ;
            rs2_o           <= instruction_w[24:20] ;
            rd_o            <= instruction_w[11:7]  ;
            rd1_o           <= w_read_data1         ;
            rd2_o           <= w_read_data2         ;
        end
        
    end
    // ----------------------------------------------
    //          Internal logic
    // ----------------------------------------------    
    control controller_inst0(
        .instruction_i  (instruction_i  ),
        .branch_o       (branch_w       ), 
        .mem_read_o     (mem_read_w     ), 
        .mem_to_reg_o   (mem_to_reg_w   ), 
        .mem_write_o    (mem_write_w    ), 
        .ALU_src_o      (ALU_src_w      ), 
        .reg_write_o    (reg_write_w    ),
        .ALUOp_o        (ALUOp_w        )
    );

    register_file RF_inst0(
        .clk_i          (clk_i                  ),
        .rstn_i         (rstn_i                 ),
        .rs1_i          (instruction_i[19:15]   ),
        .rs2_i          (instruction_i[24:20]   ),

        .rd_i           (rd_i                   ),
        .rd_value_i     (write_back_i           ),

        .reg_write_i    (reg_write_i            ),

        .read_rs1_o     (w_read_data1           ),
        .read_rs2_o     (w_read_data2           )
    );

    immediate_generator imm_gen_inst0(
        .instruction_i  (instruction_i),
        .output_o       (w_imm_gen_out)
    );

endmodule
