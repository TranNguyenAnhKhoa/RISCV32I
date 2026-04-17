
module program_counter
(
    input         clk_i     ,
    input         rstn_i    ,
    input         write_en_i,
    input  [31:0] PC_i      ,

    output [31:0] PC_o
);
    reg [31:0] PC_r;

//------------------------------------    
//          combinational logic
//------------------------------------  
    assign PC_o = PC_r;
//------------------------------------    
//          sequential logic
//------------------------------------  
    always @(posedge clk_i) begin
        if(!rstn_i) begin
            PC_r <= 32'h0;
        end
        else begin
            if (write_en_i) PC_r <= PC_i;
            else PC_r <= PC_r;
        end
    end

endmodule

// program_counter PC_inst (
//     clk_i     (),
//     rstn_i    (),
//     write_en_i(),
//     PC_i      (),
//     PC_o      ()
// );

