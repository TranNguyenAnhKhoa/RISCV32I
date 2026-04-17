module test(
    input  logic         clk_i         , 
    input  logic         rstn_i        ,
    input  logic         branch_i     ,

    input  logic         flush_i       ,
    input  logic         write_PC_en_i ,

    input  logic [31:0]  addr_branch_i ,
    output logic [31:0]  instruction_o ,
    output logic [31:0]  addr_current_o
);
    logic clk_l;
    logic rstn_l;

    always @(posedge clk_i or negedge rstn_i) begin
        clk_l <= clk_i;
        rstn_l <= rstn_i;
    end

    IF_stage IF_stage_inst(
        .clk_i          (clk_l         ),
        .rstn_i         (rstn_l        ),
        .branch_i       (branch_i      ),
        .flush_i        (flush_i       ),
        .write_PC_en_i  (write_PC_en_i ),
        .addr_branch_i  (addr_branch_i ),
        .instruction_o  (instruction_o ),
        .addr_current_o (addr_current_o)    
    );

endmodule
