module MEM_stage(
    input           clk_i               , 
    input           rstn_i              ,
    input           ctrl_mem_read_i     , 
    input           ctrl_mem_write_i    , 
    input           ctrl_reg_write_i    , 
    input           ctrl_mem_to_reg_i   ,
    input  [31:0]   ALUresult_i         , 

    input  [31:0]   ALU2i_i             ,
    input  [4:0 ]   write_rd_i          ,
    input  [2:0]    funct3_i            ,   
    output          ctrl_mem_to_reg_o   , 
    output          ctrl_reg_write_o    ,
    output [31:0]   DMEM_data_o         ,
    output [31:0]   ALUresult_o         ,
    output [4:0 ]   write_rd_o            
);
    
    //------------------------------
    //           WIRE & REG
    //------------------------------
    wire        ctrl_reg_write_w;
    wire        ctrl_mem_to_reg_w;
    wire [31:0] DMEM_data_w         ;
    reg [31:0]      ALUresult_r;
    reg [31:0]      DMEM_data_r;
    reg [4:0]       write_rd_r;
    reg             ctrl_reg_write_r;
    reg             ctrl_mem_to_reg_r;
    // ----------------------------------------------
    //          Combinational logic
    // ----------------------------------------------
    assign ctrl_reg_write_o   = ctrl_reg_write_r  ;
    assign ctrl_mem_to_reg_o  = ctrl_mem_to_reg_r ;
    assign write_rd_o         = write_rd_r         ;
    assign ALUresult_o        = ALUresult_r  ;
    assign DMEM_data_o        = DMEM_data_r ;

    always @(posedge clk_i or rstn_i) begin
        if( !rstn_i ) begin
            ctrl_reg_write_r    <= 0;
            DMEM_data_r         <= 0; 
            ALUresult_r         <= 0;
            write_rd_r          <= 0;
            ctrl_mem_to_reg_r   <= 0;
        end else begin
            ctrl_reg_write_r    <= ctrl_reg_write_i;
            ctrl_mem_to_reg_r   <= ctrl_mem_to_reg_i;
            DMEM_data_r         <= DMEM_data_w; 
            write_rd_r          <= write_rd_i;   
            ALUresult_r         <= ALUresult_i;      
         end
    end
    DMEM DMEM_inst0(
        .clk_i       (clk_i           ),
        .address_i   (ALUresult_i     ),
        .data_i      (ALU2i_i         ),
        .funct3_i    (funct3_i        ),
        .mem_write_i (ctrl_mem_write_i),
        .mem_read_i  (ctrl_mem_read_i ),
        .data_o      (DMEM_data_w     )
    );

endmodule
