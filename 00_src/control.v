module control(
    input       [31:0]   i_instructions,

    output  reg         o_branch, 
                        o_mem_read, 
                        o_mem_to_reg, 
                        o_mem_write, 
                        o_ALU_src, 
                        o_reg_write,
    output  reg [1:0]   o_ALUOp
);
    parameter   // I-type
                Load    = 7'b0000011, // load instructions
                jalr    = 7'b1100111, // jump and link register
                Imm_A_L = 7'b0010011, // integer register-immediate, constant shift

                // R-type
                R_type  = 7'b0110011, // integer register-register
                
                // S-type
                Store   = 7'b0100011, // store instructions
                
                // B-type
                B_type = 7'b1100011, // branch
                
                // U-type
                Lui     = 7'b0110111,
                auipc   = 7'b0010111,
                // J-type
                jal     = 7'b1101111; // jump and link
    
    wire    [6:0] opcode;
    assign opcode = i_instructions[6:0];

    always @(*) begin
        case (opcode)
            Load: begin
                o_ALUOp     = 2'b01; 
                o_ALU_src   = 1'b1;  
                o_mem_write = 1'b0; 
                o_mem_read  = 1'b1; 
                o_mem_to_reg= 1'b1; 
                o_reg_write = 1'b1;
                o_branch    = 1'b0;
            end
            R_type: begin
                o_branch    = 1'b0;
                o_mem_read  = 1'b0;
                o_mem_to_reg= 1'b0;
                o_mem_write = 1'b0;
                o_ALU_src   = 1'b0;
                o_reg_write = 1'b1;
                o_ALUOp     = 2'b00;
            end
            Imm_A_L: begin
                o_ALUOp     = 2'b10; 
                o_ALU_src   = 1'b1; 
                o_mem_write = 1'b0; 
                o_mem_read  = 1'b0;
                o_mem_to_reg= 1'b0; 
                o_reg_write = 1'b1;
                o_branch    = 1'b0;
            end

            Store: begin
                o_ALUOp     = 2'b01; 
                o_ALU_src   = 1'b1;  
                o_mem_write = 1'b1; 
                o_mem_read  = 1'b0; 
                o_mem_to_reg= 1'bx; 
                o_reg_write = 1'b0;
                o_branch    = 1'bx;
            end
            B_type: begin
                o_ALUOp     = 2'b10; 
                o_ALU_src   = 1'b0;  
                o_mem_write = 1'b0; 
                o_mem_read  = 1'b0; 
                o_mem_to_reg= 1'bx; 
                o_reg_write = 1'b0;
                o_branch    = 1'bx;
            end
            Lui: begin
                o_ALUOp     = 2'b11; 
                o_ALU_src   = 1'b1;  
                o_mem_write = 1'b0; 
                o_mem_read  = 1'b0; 
                o_mem_to_reg= 1'b0; 
                o_reg_write = 1'b1;
                o_branch    = 1'b0;
            end
            jal: begin
                o_ALUOp     = 2'bxx; 
                o_ALU_src   = 1'b0; 
                o_mem_write = 1'b0; 
                o_mem_read  = 1'b0; 
                o_mem_to_reg= 1'bx; 
                o_reg_write = 1'b1;
                o_branch    = 1'b1;
            end
            
            jalr: begin
                o_ALUOp     = 2'bxx; 
                o_ALU_src   = 1'bx; 
                o_mem_write = 1'b0; 
                o_mem_read  = 1'b0; 
                o_mem_to_reg= 1'bx; 
                o_reg_write = 1'b1;
                o_branch    = 1'b1;
            end
            auipc: begin
                o_ALUOp     = 2'bxx; 
                o_ALU_src   = 1'bx; 
                o_mem_write = 1'b0; 
                o_mem_read  = 1'b0; 
                o_mem_to_reg= 1'bx; 
                o_reg_write = 1'b1;
                o_branch    = 1'b1;
            end
            default: begin
                o_branch    = 1'b0;
                o_mem_read  = 1'b0;
                o_mem_to_reg= 1'b0;
                o_mem_write = 1'b0;
                o_ALU_src   = 1'b0;
                o_reg_write = 1'b0;
                o_ALUOp     = 2'b00;
            end
        endcase
    end

endmodule
