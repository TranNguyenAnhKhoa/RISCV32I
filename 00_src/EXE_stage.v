module EXE_stage(
    input i_clk, i_rstn,

    input         i_branch, i_mem_read, i_mem_to_reg, i_mem_write, i_ALU_src, i_reg_write,
    input  [1:0 ] i_ALUOp,
 
    input [31:0] i_addr_current,
    input [31:0] i_read_data1, i_read_data2,
    input [31:0] i_imm_gen_out,

    input        i_funct7_30,
    input [2:0]  i_funct3,
    input [4:0]  i_rd,
    // hazard
    input [31:0] i_ALU_result_MEM, i_data_wire_back,
    input [1:0]  i_sel_mux1, i_sel_mux2,

    output reg   o_branch, o_mem_read, o_mem_to_reg, o_mem_write, o_reg_write,
    output reg [31:0] o_addr_branch,
    //output reg        o_branch_taken,

    output reg [31:0] o_ALU_out,
    output reg [31:0] o_mux_alu2,
    output reg [4:0]  o_rd

);
    //------------------------------
    //           WIRE
    //------------------------------
    wire w_branch, w_mem_read, w_mem_to_reg, w_mem_write, w_reg_write, w_branch_taken;
    wire [31:0] w_mux_alu1, w_mux_alu2;
    wire [3:0]  w_ALUCtrl;
    wire [31:0] w_ALU_out, w_addr_branch;
    wire [4:0]  w_rd;

    assign w_branch       = i_branch    ; 
    assign w_mem_read     = i_mem_read  ; 
    assign w_mem_to_reg   = i_mem_to_reg; 
    assign w_mem_write    = i_mem_write ; 
    assign w_reg_write    = i_reg_write ;
    assign w_rd           = i_rd        ;

    adder adder_addr_inst1(
        .i_input1(i_addr_current    ),
        .i_input2(i_imm_gen_out     ),

        .o_output(w_addr_branch     )   
    );

    mux31 mux_alu1_inst0(
        .i_input0 (i_read_data1     ),
        .i_input1 (i_data_wire_back ),
        .i_input2 (i_ALU_result_MEM ),
        .i_sel    (i_sel_mux1       ),
        .o_output (w_mux_alu1       )
    );
    mux31 mux_alu2_inst0(
        .i_input0 (i_read_data2     ),
        .i_input1 (i_data_wire_back ),
        .i_input2 (i_ALU_result_MEM ),
        .i_sel    (i_sel_mux2       ),
        .o_output (w_mux_alu2       )
    );

    ALU ALU_inst0(
        .i_input1   (w_mux_alu1 ),
        .i_input2   (w_mux_alu2 ),
        .i_ALUCtrl  (w_ALUCtrl  ),
        .o_resutl   (w_ALU_out  )
    );

    ALU_control ALU_control_inst0(
        .i_ALUOp        (i_ALUOp        ),
        .i_funct3       (i_funct3       ),
        .i_funct7_30    (i_funct7_30    ),
        .o_ALUCtrl      (w_ALUCtrl      )     
    );

    always @(posedge i_clk) begin
        if(i_rstn) begin
            o_reg_write     <= 0    ;
            o_mem_write     <= 0    ;
            o_mem_read      <= 0    ;
            o_branch        <= 0    ;
            o_ALU_out       <= 0    ;
            o_addr_branch   <= 0    ;
            o_mux_alu2      <= 0    ;
            o_rd            <= 0    ;
            o_mem_to_reg    <= 0    ;
        end else begin
            o_reg_write     <= w_reg_write   ;
            o_mem_write     <= w_mem_write   ;
            o_mem_read      <= w_mem_read    ;
            o_branch        <= w_branch      ;
            o_ALU_out       <= w_ALU_out     ;
            o_addr_branch   <= w_addr_branch ;
            o_mux_alu2      <= w_mux_alu2    ;
            o_rd            <= w_rd          ;
            o_mem_to_reg    <= w_mem_to_reg  ;
        end
        
    end
endmodule
