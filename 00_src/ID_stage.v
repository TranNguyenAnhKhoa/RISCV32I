module ID_stage(
    input               i_clk, 
    input               i_rstn,

    input       [31:0]  i_instruction,
    input       [31:0]  i_addr_current,
    input       [31:0]  i_write_back,
    input       [4:0 ]  i_rd,
    input               i_reg_write,

    // hazard control
    input               i_control_mux,

    output reg          o_branch, o_mem_read, o_mem_to_reg, o_mem_write, o_ALU_src, o_reg_write, 
    output reg  [1:0 ]  o_ALUOp,

    output reg  [31:0]  o_read_data1, o_read_data2,
    output reg          o_funct7_30,
    output reg  [2:0 ]  o_funct3,
    output reg  [4:0 ]  o_rs1,
    output reg  [4:0 ]  o_rs2,
    output reg  [4:0 ]  o_rd,
    output reg  [31:0]  o_addr_current,
    output reg  [31:0]  o_imm_gen_out,
    output reg          o_branch_taken
    );
    //----------------------------------------
    //              WIRE
    //---------------------------------------- 
    wire [31:0] w_instruction;
    wire [31:0] w_addr_current, w_addr_branch, w_addr_next, w_addr_plus4;
    wire [31:0] w_read_data1, w_read_data2;
    wire [31:0] w_imm_gen_out;

    wire w_branch, w_mem_read, w_mem_to_reg, w_mem_write,  w_ALU_src, w_reg_write  ;
    wire [1:0] w_ALUOp;
    wire [7:0] w_control_signal;
    
    assign w_addr_current = i_addr_current ;
    assign w_instruction  = i_instruction  ;

    control controller_inst0(
        .i_instructions (i_instruction  ),
        .o_branch       (w_branch       ), 
        .o_mem_read     (w_mem_read     ), 
        .o_mem_to_reg   (w_mem_to_reg   ), 
        .o_mem_write    (w_mem_write    ), 
        .o_ALU_src      (w_ALU_src      ), 
        .o_reg_write    (w_reg_write    ),
        .o_ALUOp        (w_ALUOp        )
    );    
    
    mux21 #(
        .WIDTH(8)
    )mux_hazard_inst0(
        .i_input0   ( {w_branch, w_mem_read, w_mem_to_reg, w_mem_write, w_ALU_src, w_reg_write, w_ALUOp} ),
        .i_input1   (8'h00)             ,
        .i_sel      (i_control_mux)     ,
        .o_output   (w_control_signal)
    );

    register_file RF_inst0(
        .i_clk          (i_clk                  ),
        .i_rstn         (i_rstn                 ),
        .i_read_reg1    (i_instruction[19:15]   ),
        .i_read_reg2    (i_instruction[24:20]   ),

        .i_write_reg    (i_rd                   ),
        .i_write_data   (i_write_back           ),

        .i_reg_write_en (i_reg_write            ),

        .o_read_data1   (w_read_data1           ),
        .o_read_data2   (w_read_data2           )
    );

    comparator comparator_inst0(
        .i_input1       (w_read_data1           ),
        .i_input2       (w_read_data2           ),
        .i_funct3       (i_instruction[14:12]   ),
        .o_branch_taken (o_branch_taken         )
    );

    immediate_generator imm_gen_inst0(
        .i_instructions (i_instruction),
        .o_output       (w_imm_gen_out)
    );

    always @(posedge i_clk) begin
        if(i_rstn) begin
            o_branch        <= 1'b0         ;
            o_mem_read      <= 1'b0         ;
            o_mem_to_reg    <= 1'b0         ;
            o_mem_write     <= 1'b0         ;
            o_ALU_src       <= 1'b0         ;
            o_reg_write     <= 1'b0         ;
            o_ALUOp         <= 2'b0         ;

            o_addr_current  <= 32'h0000_0000;

            o_imm_gen_out   <= 32'h0000_0000;
            o_funct7_30     <= 1'b0         ;
            o_funct3        <= 3'b000       ;
            o_rs1           <= 5'b0000_0    ;
            o_rs2           <= 5'b0000_0    ;
            o_rd            <= 5'b0000_0    ;
            o_read_data1    <= 32'b0        ;
            o_read_data2    <= 32'b0        ;


        end else begin
            o_branch        <= w_control_signal[7]  ;
            o_mem_read      <= w_control_signal[6]  ;
            o_mem_to_reg    <= w_control_signal[5]  ;
            o_mem_write     <= w_control_signal[4]  ;
            o_ALU_src       <= w_control_signal[3]  ;
            o_reg_write     <= w_control_signal[2]  ;
            o_ALUOp         <= w_control_signal[1:0];

            o_addr_current  <= w_addr_current       ;
            o_imm_gen_out   <= w_imm_gen_out        ;

            o_funct7_30     <= w_instruction[30]    ;
            o_funct3        <= w_instruction[14:12] ;
            o_rs1           <= w_instruction[19:15] ;
            o_rs2           <= w_instruction[24:20] ;
            o_rd            <= w_instruction[11:7]  ;
            o_read_data1    <= w_read_data1         ;
            o_read_data2    <= w_read_data2         ;
        end
        
    end

endmodule
