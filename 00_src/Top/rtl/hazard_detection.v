module hazard_detection(
    
    input       [4:0]   rs1_IFID_i          ,
    input       [4:0]   rs2_IFID_i          ,
    input       [4:0]   rd_IDEX_i           ,
    input       [4:0]   rd_EXMEM_i          ,
    input               write_reg_IDEX_i    ,
    input               mem_read_IDEX_i     ,
    input               mem_read_EXMEM_i    ,
    input               branch_ID_i         ,
    input               is_jalr_i           ,
    output  reg         write_IDEX_o        ,
    output  reg         write_PC_o          ,
    output  reg         control_mux_o
    
);
    always @(*) begin
        if ( ( mem_read_IDEX_i && ( (rd_IDEX_i == rs1_IFID_i) || (rd_IDEX_i == rs2_IFID_i) ) )    //Resolving AL after Load

        || ( (branch_ID_i) && ( (write_reg_IDEX_i && ( (rd_IDEX_i == rs1_IFID_i) || (rd_IDEX_i == rs2_IFID_i) ) )        // Resolving
                            || ( (mem_read_EXMEM_i) && ( (rd_EXMEM_i == rs1_IFID_i)||(rd_EXMEM_i == rs2_IFID_i) ) ) ) )  // cmp data hazard

        || ( (is_jalr_i) && ( (rd_IDEX_i == rs1_IFID_i) || ( (mem_read_EXMEM_i) && (rd_EXMEM_i == rs1_IFID_i) ) ) ) // Resolving jalr hazards 
        ) begin
            write_IDEX_o    = 1'b0 ;
            write_PC_o      = 1'b0 ;
            control_mux_o   = 1'b1 ;
        end else begin
            write_IDEX_o    = 1'b1 ;
            write_PC_o      = 1'b1 ;
            control_mux_o   = 1'b0 ;
        end
    end


endmodule
