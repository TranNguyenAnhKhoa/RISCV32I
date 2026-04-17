module ID_stage(
    input         clk_i         ,
    input         rstn_i        ,

    input [31:0]  instruction_i ,
    input [31:0]  addr_current_i,
    input [31:0]  write_back_data_i  ,
    input [4:0 ]  write_reg          ,

    // hazard control
    input         control_mux_i ,

    // control signal
    input         reg_write_en_i   ,
    output        branch_o      ,
    output        mem_read_o    ,
    output        mem_to_reg_o  ,
    output        mem_write_o   ,
    output        ALU_src_o     ,
    output        reg_write_o   ,
    output [1:0 ] ALUOp_o       ,

    output [31:0] rd1_o         ,
    output [31:0] rd2_o         ,
    output [31:0] instruction_o ,
    output [31:0] addr_current_o,
    output [31:0] o_imm_gen_out ,
    output        branch_taken_o
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

    wire w_branch       ; 
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

    // ----------------------------------------------
    //          Sequential logic
    // ----------------------------------------------

    // ----------------------------------------------
    //          Sequential logic
    // ----------------------------------------------    
    control controller_inst0(
        .instruction_i  (instruction_i   ),
        .branch_o       (w_branch       ), 
        .mem_read_o     (w_mem_read_o   ), 
        .mem_to_reg_o   (w_mem_to_reg   ), 
        .mem_write_o    (w_mem_write    ), 
        .ALU_src_o      (w_ALU_src      ), 
        .reg_write_o    (w_reg_write    ),
        .ALUOp_o        (w_ALUOp        )
    );    
    
    assign w_control_signal = (control_mux_i) ? 8'h0 : {w_branch, w_mem_read_o, w_mem_to_reg, w_mem_write, w_ALU_src, w_reg_write, w_ALUOp} ;

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

    comparator comparator_inst0(
        .A_i            (w_read_data1           ),
        .B_i            (w_read_data2           ),
        .i_funct3       (instruction_i[14:12]   ),
        .branch_taken_o (branch_taken_o         )
    );

    immediate_generator imm_gen_inst0(
        .instruction_i  (instruction_i),
        .output_o       (w_imm_gen_out)
    );

    always @(posedge clk_i) begin
        if(rstn_i) begin
            branch_o        <= 1'b0         ;
            mem_read_o      <= 1'b0         ;
            mem_to_reg_o    <= 1'b0         ;
            mem_write_o       <= 1'b0         ;
            ALU_src_o       <= 1'b0         ;
            reg_write_o     <= 1'b0         ;
            ALUOp_o         <= 2'b0         ;

            addr_current_r  <= 32'h0000_0000;

            o_imm_gen_out   <= 32'h0000_0000;
            o_funct7_30     <= 1'b0         ;
            funct3_o        <= 3'b000       ;
            rs1_o           <= 5'b0000_0    ;
            rs2_o           <= 5'b0000_0    ;
            rd_o            <= 5'b0000_0    ;
            rd1_o    <= 32'b0        ;
            rd2_o    <= 32'b0        ;


        end else begin
            branch_o        <= w_control_signal[7]  ;
            mem_read_o      <= w_control_signal[6]  ;
            mem_to_reg_o    <= w_control_signal[5]  ;
            mem_write_o       <= w_control_signal[4]  ;
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
            rd1_o    <= w_read_data1         ;
            rd2_o    <= w_read_data2         ;
        end
        
    end

endmodule
