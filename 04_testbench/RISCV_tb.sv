`timescale 1ns/1ps

module RISCV_tb;
    localparam time CLOCK_PERIOD = 10ns;
    localparam int DEFAULT_INSTRUCTION_COUNT = 53;
    localparam int ASCII_CHARACTER_COUNT = 96;
    localparam int ASCII_SIGNAL_WIDTH = ASCII_CHARACTER_COUNT * 8;

    bit clock;
    bit reset_n;
    bit enable_fetch_trace;
    bit unknown_trace_reported;
    int instruction_count;
    int plusarg_status;
    string imem_file;

    // Waveform trace signals. Set instruction_decode_ascii radix to ASCII in
    // Vivado Wave; the dynamic string is also available in Scope/Objects.
    logic [31:0] trace_pc;
    logic [31:0] trace_instruction;
    string instruction_decode_string;
    logic [ASCII_SIGNAL_WIDTH-1:0] instruction_decode_ascii;

    RISCV dut(
        .clk_i  (clock),
        .rstn_i (reset_n)
    );

    always #(CLOCK_PERIOD/2) begin
        clock = ~clock;
    end

    function automatic string register_name(
        input logic [4:0] register_index_i
    );
        case (register_index_i)
            5'd0:  return "x0/zero";
            5'd1:  return "x1/ra";
            5'd2:  return "x2/sp";
            5'd3:  return "x3/gp";
            5'd4:  return "x4/tp";
            5'd5:  return "x5/t0";
            5'd6:  return "x6/t1";
            5'd7:  return "x7/t2";
            5'd8:  return "x8/s0";
            5'd9:  return "x9/s1";
            5'd10: return "x10/a0";
            5'd11: return "x11/a1";
            5'd12: return "x12/a2";
            5'd13: return "x13/a3";
            5'd14: return "x14/a4";
            5'd15: return "x15/a5";
            5'd16: return "x16/a6";
            5'd17: return "x17/a7";
            5'd18: return "x18/s2";
            5'd19: return "x19/s3";
            5'd20: return "x20/s4";
            5'd21: return "x21/s5";
            5'd22: return "x22/s6";
            5'd23: return "x23/s7";
            5'd24: return "x24/s8";
            5'd25: return "x25/s9";
            5'd26: return "x26/s10";
            5'd27: return "x27/s11";
            5'd28: return "x28/t3";
            5'd29: return "x29/t4";
            5'd30: return "x30/t5";
            5'd31: return "x31/t6";
            default: return "x?";
        endcase
    endfunction

    function automatic string disassemble_instruction(
        input logic [31:0] instruction_i
    );
        logic [6:0] opcode;
        logic [6:0] funct7;
        logic [2:0] funct3;
        logic [4:0] rd;
        logic [4:0] rs1;
        logic [4:0] rs2;
        logic [4:0] shift_amount;
        logic signed [31:0] immediate;
        string rd_name;
        string rs1_name;
        string rs2_name;

        if ($isunknown(instruction_i)) begin
            return "<uninitialized>";
        end

        opcode       = instruction_i[6:0];
        rd           = instruction_i[11:7];
        funct3       = instruction_i[14:12];
        rs1          = instruction_i[19:15];
        rs2          = instruction_i[24:20];
        funct7       = instruction_i[31:25];
        shift_amount = instruction_i[24:20];
        rd_name      = register_name(rd);
        rs1_name     = register_name(rs1);
        rs2_name     = register_name(rs2);

        case (opcode)
            7'b0110011: begin
                case ({funct7, funct3})
                    {7'b0000000,3'b000}: return $sformatf("add   %s, %s, %s", rd_name, rs1_name, rs2_name);
                    {7'b0100000,3'b000}: return $sformatf("sub   %s, %s, %s", rd_name, rs1_name, rs2_name);
                    {7'b0000000,3'b001}: return $sformatf("sll   %s, %s, %s", rd_name, rs1_name, rs2_name);
                    {7'b0000000,3'b010}: return $sformatf("slt   %s, %s, %s", rd_name, rs1_name, rs2_name);
                    {7'b0000000,3'b011}: return $sformatf("sltu  %s, %s, %s", rd_name, rs1_name, rs2_name);
                    {7'b0000000,3'b100}: return $sformatf("xor   %s, %s, %s", rd_name, rs1_name, rs2_name);
                    {7'b0000000,3'b101}: return $sformatf("srl   %s, %s, %s", rd_name, rs1_name, rs2_name);
                    {7'b0100000,3'b101}: return $sformatf("sra   %s, %s, %s", rd_name, rs1_name, rs2_name);
                    {7'b0000000,3'b110}: return $sformatf("or    %s, %s, %s", rd_name, rs1_name, rs2_name);
                    {7'b0000000,3'b111}: return $sformatf("and   %s, %s, %s", rd_name, rs1_name, rs2_name);
                    default: return $sformatf("unknown R-type (funct7=%02h funct3=%01h)", funct7, funct3);
                endcase
            end

            7'b0010011: begin
                immediate = {{20{instruction_i[31]}}, instruction_i[31:20]};
                case (funct3)
                    3'b000: return $sformatf("addi  %s, %s, %0d", rd_name, rs1_name, immediate);
                    3'b010: return $sformatf("slti  %s, %s, %0d", rd_name, rs1_name, immediate);
                    3'b011: return $sformatf("sltiu %s, %s, %0d", rd_name, rs1_name, immediate);
                    3'b100: return $sformatf("xori  %s, %s, %0d", rd_name, rs1_name, immediate);
                    3'b110: return $sformatf("ori   %s, %s, %0d", rd_name, rs1_name, immediate);
                    3'b111: return $sformatf("andi  %s, %s, %0d", rd_name, rs1_name, immediate);
                    3'b001: return $sformatf("slli  %s, %s, %0d", rd_name, rs1_name, shift_amount);
                    3'b101: begin
                        if (instruction_i[30]) begin
                            return $sformatf("srai  %s, %s, %0d", rd_name, rs1_name, shift_amount);
                        end
                        return $sformatf("srli  %s, %s, %0d", rd_name, rs1_name, shift_amount);
                    end
                    default: return "unknown I-type";
                endcase
            end

            7'b0000011: begin
                immediate = {{20{instruction_i[31]}}, instruction_i[31:20]};
                case (funct3)
                    3'b000: return $sformatf("lb    %s, %0d(%s)", rd_name, immediate, rs1_name);
                    3'b001: return $sformatf("lh    %s, %0d(%s)", rd_name, immediate, rs1_name);
                    3'b010: return $sformatf("lw    %s, %0d(%s)", rd_name, immediate, rs1_name);
                    3'b100: return $sformatf("lbu   %s, %0d(%s)", rd_name, immediate, rs1_name);
                    3'b101: return $sformatf("lhu   %s, %0d(%s)", rd_name, immediate, rs1_name);
                    default: return "unknown load";
                endcase
            end

            7'b0100011: begin
                immediate = {{20{instruction_i[31]}}, instruction_i[31:25], instruction_i[11:7]};
                case (funct3)
                    3'b000: return $sformatf("sb    %s, %0d(%s)", rs2_name, immediate, rs1_name);
                    3'b001: return $sformatf("sh    %s, %0d(%s)", rs2_name, immediate, rs1_name);
                    3'b010: return $sformatf("sw    %s, %0d(%s)", rs2_name, immediate, rs1_name);
                    default: return "unknown store";
                endcase
            end

            7'b1100011: begin
                immediate = {{19{instruction_i[31]}}, instruction_i[31], instruction_i[7],
                             instruction_i[30:25], instruction_i[11:8], 1'b0};
                case (funct3)
                    3'b000: return $sformatf("beq   %s, %s, %0d", rs1_name, rs2_name, immediate);
                    3'b001: return $sformatf("bne   %s, %s, %0d", rs1_name, rs2_name, immediate);
                    3'b100: return $sformatf("blt   %s, %s, %0d", rs1_name, rs2_name, immediate);
                    3'b101: return $sformatf("bge   %s, %s, %0d", rs1_name, rs2_name, immediate);
                    3'b110: return $sformatf("bltu  %s, %s, %0d", rs1_name, rs2_name, immediate);
                    3'b111: return $sformatf("bgeu  %s, %s, %0d", rs1_name, rs2_name, immediate);
                    default: return "unknown branch";
                endcase
            end

            7'b0110111: begin
                return $sformatf("lui   %s, 0x%05h", rd_name, instruction_i[31:12]);
            end

            7'b0010111: begin
                return $sformatf("auipc %s, 0x%05h", rd_name, instruction_i[31:12]);
            end

            7'b1101111: begin
                immediate = {{11{instruction_i[31]}}, instruction_i[31], instruction_i[19:12],
                             instruction_i[20], instruction_i[30:21], 1'b0};
                return $sformatf("jal   %s, %0d", rd_name, immediate);
            end

            7'b1100111: begin
                immediate = {{20{instruction_i[31]}}, instruction_i[31:20]};
                return $sformatf("jalr  %s, %0d(%s)", rd_name, immediate, rs1_name);
            end

            7'b0001111: begin
                if (funct3 == 3'b001) begin
                    return "fence.i";
                end
                return "fence";
            end

            7'b1110011: begin
                case (instruction_i)
                    32'h00000073: return "ecall";
                    32'h00100073: return "ebreak";
                    default: return $sformatf("system/csr 0x%08h", instruction_i);
                endcase
            end

            default: return $sformatf("unknown opcode 0x%02h", opcode);
        endcase
    endfunction

    task automatic display_imem_contents();
        int instruction_index;
        int byte_address;
        logic [31:0] instruction;

        $display("");
        $display("====================== IMEM DISASSEMBLY ======================");
        $display(" ADDRESS    MACHINE     ASCII INSTRUCTION");
        $display("---------------------------------------------------------------");

        for (instruction_index = 0;
             instruction_index < instruction_count;
             instruction_index++) begin
            byte_address = instruction_index * 4;
            instruction = {
                dut.IF_stage_inst.IMEM_inst0.imem[byte_address+0],
                dut.IF_stage_inst.IMEM_inst0.imem[byte_address+1],
                dut.IF_stage_inst.IMEM_inst0.imem[byte_address+2],
                dut.IF_stage_inst.IMEM_inst0.imem[byte_address+3]
            };
            $display(" 0x%08h  0x%08h  %s",
                     byte_address,
                     instruction,
                     disassemble_instruction(instruction));
        end

        $display("===============================================================");
        $display("");
    endtask

    task automatic update_decode_ascii(
        input string decode_text_i
    );
        int character_index;
        int copied_character_count;

        instruction_decode_ascii = {ASCII_SIGNAL_WIDTH{1'b0}};
        copied_character_count = decode_text_i.len();

        if (copied_character_count > ASCII_CHARACTER_COUNT) begin
            copied_character_count = ASCII_CHARACTER_COUNT;
        end

        for (character_index = 0;
             character_index < copied_character_count;
             character_index++) begin
            instruction_decode_ascii[ASCII_SIGNAL_WIDTH-1-(character_index*8) -: 8]
                = decode_text_i.getc(character_index);
        end
    endtask

    always @(posedge clock) begin
        #1;
        trace_pc          = dut.addr_IF_w;
        trace_instruction = dut.instr_IF_w;

        if (!reset_n) begin
            instruction_decode_string = "<reset>";
            update_decode_ascii(instruction_decode_string);
        end else if (!$isunknown({trace_pc, trace_instruction})) begin
            instruction_decode_string = disassemble_instruction(trace_instruction);
            update_decode_ascii(instruction_decode_string);
            unknown_trace_reported    = 1'b0;

            if (enable_fetch_trace) begin
                $display("[FETCH] time=%0t pc=0x%08h machine=0x%08h  %s",
                         $time,
                         trace_pc,
                         trace_instruction,
                         instruction_decode_string);
            end
        end else begin
            instruction_decode_string = "<unknown>";
            update_decode_ascii(instruction_decode_string);

            if (enable_fetch_trace && !unknown_trace_reported) begin
                $display("[FETCH] time=%0t PC/instruction became unknown; trace is suppressed until valid again.",
                         $time);
                unknown_trace_reported = 1'b1;
            end
        end
    end

    initial begin
        clock             = 1'b0;
        reset_n           = 1'b0;
        enable_fetch_trace = 1'b1;
        unknown_trace_reported = 1'b0;
        instruction_count = DEFAULT_INSTRUCTION_COUNT;
        imem_file = "C:/Users/khoah/OneDrive/Desktop/riscv32/RISCV32I/01_data_mem/IMEM.mem";
        trace_pc = 32'b0;
        trace_instruction = 32'b0;
        instruction_decode_string = "<initializing>";
        update_decode_ascii(instruction_decode_string);

        plusarg_status = $value$plusargs("IMEM_FILE=%s", imem_file);
        plusarg_status = $value$plusargs("IMEM_WORDS=%d", instruction_count);

        if ($test$plusargs("NO_FETCH_TRACE")) begin
            enable_fetch_trace = 1'b0;
        end

        $display("[TB] Loading IMEM file: %s", imem_file);
        $readmemh(imem_file, dut.IF_stage_inst.IMEM_inst0.imem);
        #1;
        display_imem_contents();

        repeat (4) @(posedge clock);
        @(negedge clock);
        reset_n = 1'b1;

        repeat (800) @(posedge clock);
        $finish;
    end

endmodule
