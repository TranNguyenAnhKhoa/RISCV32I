
module program_counter
(
    input         i_clk     ,
    input         i_rstn    ,
    input         i_write_en,
    input  [31:0] i_PC_next ,

    output [31:0] o_PC_current
);
    reg [31:0] r_PC_current;
//------------------------------------    
//          combinational logic
//------------------------------------  
    assign o_PC_current = (i_write_en) ? i_PC_next : r_PC_current;
//------------------------------------    
//          sequential logic
//------------------------------------  
    always @(posedge i_clk) begin
        if(i_rstn) begin
            r_PC_current <= 32'h0;
        end
        else begin
            r_PC_current <= i_PC_next;
        end
    end

endmodule
