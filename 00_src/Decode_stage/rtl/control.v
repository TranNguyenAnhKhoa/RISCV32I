module control(
    input [31:0] instruction_i,

    output       branch_o, 
    output       mem_read_o, 
    output       mem_to_reg_o, 
    output       mem_write_o,
    output       reg_write_o,
    output [1:0] ALUOp_o
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
    
    wire [6:0]  opcode      ;
    reg         branch_r    ; 
    reg         mem_read_r  ; 
    reg         mem_to_reg_r; 
    reg         mem_write_r ; 
    reg         reg_write_r ;
    reg [1:0]   ALUOp_r     ;
    
    assign opcode       = instruction_i[6:0];
    assign branch_o     = branch_r      ;
    assign mem_read_o   = mem_read_r    ;
    assign mem_to_reg_o = mem_to_reg_r  ;
    assign mem_write_o  = mem_write_r   ;
    assign reg_write_o  = reg_write_r   ;
    assign ALUOp_o      = ALUOp_r       ;

    always @(*) begin

        ALUOp_r      = 2'b00; 
        mem_write_r  = 1'b0; 
        mem_read_r   = 1'b0; 
        mem_to_reg_r = 1'b0; 
        reg_write_r  = 1'b0;
        branch_r     = 1'b0;

        case (opcode)
            Load: begin
                ALUOp_r     = 2'b01; 
                mem_write_r = 1'b0; 
                mem_read_r  = 1'b1; 
                mem_to_reg_r= 1'b1; 
                reg_write_r = 1'b1;
                branch_r    = 1'b0;
            end
            R_type: begin
                ALUOp_r     = 2'b00;
                mem_write_r = 1'b0;
                mem_read_r  = 1'b0;
                mem_to_reg_r= 1'b0;
                reg_write_r = 1'b1;
                branch_r    = 1'b0;
            end
            Imm_A_L: begin
                ALUOp_r     = 2'b10; 
                mem_write_r = 1'b0; 
                mem_read_r  = 1'b0;
                mem_to_reg_r= 1'b0; 
                reg_write_r = 1'b1;
                branch_r    = 1'b0;
            end

            Store: begin
                ALUOp_r     = 2'b01; 
                mem_write_r = 1'b1; 
                mem_read_r  = 1'b0; 
                mem_to_reg_r= 1'bx; 
                reg_write_r = 1'b0;
                branch_r    = 1'bx;
            end
            B_type: begin
                ALUOp_r     = 2'b10; 
                mem_write_r = 1'b0; 
                mem_read_r  = 1'b0; 
                mem_to_reg_r= 1'bx; 
                reg_write_r = 1'b0;
                branch_r    = 1'bx;
            end
            Lui: begin
                ALUOp_r     = 2'b11; 
                mem_write_r = 1'b0; 
                mem_read_r  = 1'b0; 
                mem_to_reg_r= 1'b0; 
                reg_write_r = 1'b1;
                branch_r    = 1'b0;
            end
            jal: begin
                ALUOp_r     = 2'bxx; 
                mem_write_r = 1'b0; 
                mem_read_r  = 1'b0; 
                mem_to_reg_r= 1'bx; 
                reg_write_r = 1'b1;
                branch_r    = 1'b1;
            end
            
            jalr: begin
                ALUOp_r     = 2'bxx; 
                mem_write_r = 1'b0; 
                mem_read_r  = 1'b0; 
                mem_to_reg_r= 1'bx; 
                reg_write_r = 1'b1;
                branch_r    = 1'b1;
            end
            auipc: begin
                ALUOp_r     = 2'bxx; 
                mem_write_r = 1'b0; 
                mem_read_r  = 1'b0; 
                mem_to_reg_r= 1'bx; 
                reg_write_r = 1'b1;
                branch_r    = 1'b1;
            end
            default: begin
                ALUOp_r     = 2'b00; 
                mem_write_r = 1'b0; 
                mem_read_r  = 1'b0; 
                mem_to_reg_r= 1'b0; 
                reg_write_r = 1'b0;
                branch_r    = 1'b0;
            end
        endcase
    end

endmodule
