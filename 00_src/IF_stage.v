module IF_stage(
    input               clk_i           , 
    input               rstn_i          ,
    input               i_is_branch     ,
    
    input               i_flush         ,
    input               i_write_PC      ,
    
    input       [31:0]  i_addr_branch   ,
    output reg  [31:0]  o_instruction   ,
    output reg  [31:0]  o_addr_current

    );
    //----------------------------------------
    //              WIRE
    //----------------------------------------
    wire [31:0] w_addr_next;
    wire [31:0] w_addr_plus4;
    
    //----------------------------------------
    //              REG
    //----------------------------------------
    reg [31:0] w_instruction; 
    reg [31:0] w_addr_current;

    adder adder4_inst0(
        .i_input1   (w_addr_current    ),
        .i_input2   (32'h0000_0004     ),

        .o_output   (w_addr_plus4      )
    );

    program_counter PC_inst0(
        .i_clk          (i_clk          ),
        .i_rstn         (i_rstn         ),
        .i_PC_next      (w_addr_next    ),
        .i_write_en     (i_write_PC     ),
        .o_PC_current   (w_addr_current )
    );

    IMEM IMEM_inst0(
        .i_address      (w_addr_current ),
        .o_instructions (w_instruction  )
    );

    // ----------------------------------------------
    //          Combinational logic
    // ----------------------------------------------
    always @(*) begin
        if (i_flush) begin
            w_instruction   = 32'h0000_0000 ;
            w_addr_current   = 32'h0000_0000 ;
        end else begin
            w_instruction   = o_instruction ;
            w_addr_current   = o_addr_current;
        end
    end

    // ----------------------------------------------
    //          Sequential logic
    // ----------------------------------------------
    always @(posedge i_clk) begin
        if (i_rstn) begin
            o_instruction  <= 32'h0000_0000;
            o_addr_current <= 32'h0000_0000;
        end else begin
            o_instruction  <= w_instruction ;
            o_addr_current <= w_addr_current;
        end
    end
endmodule
