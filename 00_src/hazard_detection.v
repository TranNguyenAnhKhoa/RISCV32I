module hazard_detection(
    
    input       [4:0]   i_rs1_IFID          ,
    input       [4:0]   i_rs2_IFID          ,
    input       [4:0]   i_rd_IDEX           ,
    input       [4:0]   i_rd_EXMEM          ,
    // control signal
    input               i_write_reg_IDEX    ,
    input               i_mem_read_IDEX     ,
    input               i_mem_read_EXMEM    ,
    input               i_branch_ID         ,
    input               i_is_jalr           ,

    output  reg         o_write_IDEX        ,
    output  reg         o_write_PC          ,
    output  reg         o_control_mux
    
);
    always @(*) begin
        if ( ( i_mem_read_IDEX && ( (i_rd_IDEX == i_rs1_IFID) || (i_rd_IDEX == i_rs2_IFID) ) )    //Resolving AL after Load

        || ( (i_branch_ID) && ( (i_write_reg_IDEX && ( (i_rd_IDEX == i_rs1_IFID) || (i_rd_IDEX == i_rs2_IFID) ) )        // Resolving
                            || ( (i_mem_read_EXMEM) && ( (i_rd_EXMEM == i_rs1_IFID)||(i_rd_EXMEM == i_rs2_IFID) ) ) ) )  // cmp data hazard

        || ( (i_is_jalr) && ( (i_rd_IDEX == i_rs1_IFID) || ( (i_mem_read_EXMEM) && (i_rd_EXMEM == i_rs1_IFID) ) ) ) // Resolving jalr hazards 
        ) begin
            o_write_IDEX    = 1'b0 ;
            o_write_PC      = 1'b0 ;
            o_control_mux   = 1'b1 ;
        end else begin
            o_write_IDEX    = 1'b1 ;
            o_write_PC      = 1'b1 ;
            o_control_mux   = 1'b0 ;
        end
    end


endmodule
