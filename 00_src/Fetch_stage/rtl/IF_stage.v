module IF_stage(
    input          clk_i         , 
    input          rstn_i        ,
    input          branch_i     ,
    
    input          flush_i       ,
    input          write_PC_en_i ,
    
    input  [31:0]  addr_branch_i ,
    output [31:0]  instruction_o ,
    output [31:0]  addr_current_o

    );
    //----------------------------------------
    //              WIRE & REG
    //----------------------------------------
    wire [31:0] addr_next_w     ;
    wire [31:0] addr_current_w  ;
    wire [31:0] instruction_w   ;

    reg [31:0] addr_current_r   ;
    reg [31:0] instruction_r    ;

    // ----------------------------------------------
    //          Combinational logic
    // ----------------------------------------------
    assign addr_next_w      = (!branch_i) ? (addr_current_w + 32'h0000_0004) : addr_branch_i;
    assign instruction_o    = (flush_i) ? 32'h0000_0000 : instruction_r ;
    assign addr_current_o   = (flush_i) ? 32'h0000_0000 : addr_current_r ;

    // ----------------------------------------------
    //          Sequential logic
    // ----------------------------------------------
    always @(posedge clk_i ) begin
        if (!rstn_i) begin
            instruction_r   <= 32'h0000_0000;
            addr_current_r  <= 32'h0000_0000;
        end else begin
            instruction_r   <= instruction_w ;
            addr_current_r  <= addr_current_w;
        end
    end

    program_counter PC_inst0 (
        .clk_i     (clk_i            ),
        .rstn_i    (rstn_i           ),
        .write_en_i(write_PC_en_i    ),
        .PC_i      (addr_next_w      ),
        .PC_o      (addr_current_w   )
    );

    IMEM IMEM_inst0(
        .address_i     (addr_current_w ),
        .instruction_o (instruction_w  )
    );

endmodule


//----------- interface -----------------

// IF_stage IF_stage_inst(
//     .clk_i         (), 
//     .rstn_i        (),
//     .branch_i   (),
    
//     .flush_i       (),
//     .write_PC_en_i (),
    
//     .addr_branch_i (),
//     .instruction_o (),
//     .addr_current_o

// );
