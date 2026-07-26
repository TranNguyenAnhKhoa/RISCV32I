`timescale 1ns/1ps
`include "RISCV32I_io.sv"
`include "RISCV32I_Test.sv"

module RISCV32I_tb;

    localparam time CLOCK_PERIOD = 10ns;
    localparam logic [31:0] NOP_INSTRUCTION = 32'h0000_0013;

    bit clock;

    RISCV32I_io testbench_interface(clock);
    RISCV32I_Test test(testbench_interface);

    RISCV dut(
        .clk_i  (clock),
        .rstn_i (testbench_interface.reset_n)
    );

    always #(CLOCK_PERIOD/2) begin
        clock = ~clock;
    end

    task automatic write_imem(
        input int instruction_address_i,
        input logic [31:0] instruction_i
    );
        dut.IF_stage_inst.IMEM_inst0.imem[instruction_address_i + 0] = instruction_i[31:24];
        dut.IF_stage_inst.IMEM_inst0.imem[instruction_address_i + 1] = instruction_i[23:16];
        dut.IF_stage_inst.IMEM_inst0.imem[instruction_address_i + 2] = instruction_i[15:8];
        dut.IF_stage_inst.IMEM_inst0.imem[instruction_address_i + 3] = instruction_i[7:0];
    endtask

    task automatic prepare_memories;
        int byte_address;
        int word_index;

        for (byte_address = 0; byte_address < 1024; byte_address += 4) begin
            write_imem(byte_address, NOP_INSTRUCTION);
        end

        for (word_index = 0; word_index < 64; word_index++) begin
            dut.MEM_stage_inst.DMEM_inst0.bank0[word_index] = 8'h00;
            dut.MEM_stage_inst.DMEM_inst0.bank1[word_index] = 8'h00;
            dut.MEM_stage_inst.DMEM_inst0.bank2[word_index] = 8'h00;
            dut.MEM_stage_inst.DMEM_inst0.bank3[word_index] = 8'h00;
        end
    endtask

    task automatic reset_core;
        testbench_interface.reset_n = 1'b0;
        repeat (3) @(posedge clock);
        @(negedge clock);
        testbench_interface.reset_n = 1'b1;
        #1;
    endtask

    task automatic set_register(
        input int register_index_i,
        input logic [31:0] register_value_i
    );
        case (register_index_i)
            1:  dut.ID_stage_inst.RF_inst0.reg_r1_q  = register_value_i;
            2:  dut.ID_stage_inst.RF_inst0.reg_r2_q  = register_value_i;
            3:  dut.ID_stage_inst.RF_inst0.reg_r3_q  = register_value_i;
            4:  dut.ID_stage_inst.RF_inst0.reg_r4_q  = register_value_i;
            5:  dut.ID_stage_inst.RF_inst0.reg_r5_q  = register_value_i;
            6:  dut.ID_stage_inst.RF_inst0.reg_r6_q  = register_value_i;
            7:  dut.ID_stage_inst.RF_inst0.reg_r7_q  = register_value_i;
            8:  dut.ID_stage_inst.RF_inst0.reg_r8_q  = register_value_i;
            9:  dut.ID_stage_inst.RF_inst0.reg_r9_q  = register_value_i;
            10: dut.ID_stage_inst.RF_inst0.reg_r10_q = register_value_i;
            11: dut.ID_stage_inst.RF_inst0.reg_r11_q = register_value_i;
            12: dut.ID_stage_inst.RF_inst0.reg_r12_q = register_value_i;
            13: dut.ID_stage_inst.RF_inst0.reg_r13_q = register_value_i;
            14: dut.ID_stage_inst.RF_inst0.reg_r14_q = register_value_i;
            15: dut.ID_stage_inst.RF_inst0.reg_r15_q = register_value_i;
            16: dut.ID_stage_inst.RF_inst0.reg_r16_q = register_value_i;
            17: dut.ID_stage_inst.RF_inst0.reg_r17_q = register_value_i;
            18: dut.ID_stage_inst.RF_inst0.reg_r18_q = register_value_i;
            19: dut.ID_stage_inst.RF_inst0.reg_r19_q = register_value_i;
            20: dut.ID_stage_inst.RF_inst0.reg_r20_q = register_value_i;
            21: dut.ID_stage_inst.RF_inst0.reg_r21_q = register_value_i;
            22: dut.ID_stage_inst.RF_inst0.reg_r22_q = register_value_i;
            23: dut.ID_stage_inst.RF_inst0.reg_r23_q = register_value_i;
            24: dut.ID_stage_inst.RF_inst0.reg_r24_q = register_value_i;
            25: dut.ID_stage_inst.RF_inst0.reg_r25_q = register_value_i;
            26: dut.ID_stage_inst.RF_inst0.reg_r26_q = register_value_i;
            27: dut.ID_stage_inst.RF_inst0.reg_r27_q = register_value_i;
            28: dut.ID_stage_inst.RF_inst0.reg_r28_q = register_value_i;
            29: dut.ID_stage_inst.RF_inst0.reg_r29_q = register_value_i;
            30: dut.ID_stage_inst.RF_inst0.reg_r30_q = register_value_i;
            31: dut.ID_stage_inst.RF_inst0.reg_r31_q = register_value_i;
            default: begin
                // x0 is hard-wired to zero.
            end
        endcase
    endtask

    function automatic logic [31:0] get_register(
        input int register_index_i
    );
        case (register_index_i)
            0:  return 32'h0000_0000;
            1:  return dut.ID_stage_inst.RF_inst0.reg_r1_q;
            2:  return dut.ID_stage_inst.RF_inst0.reg_r2_q;
            3:  return dut.ID_stage_inst.RF_inst0.reg_r3_q;
            4:  return dut.ID_stage_inst.RF_inst0.reg_r4_q;
            5:  return dut.ID_stage_inst.RF_inst0.reg_r5_q;
            6:  return dut.ID_stage_inst.RF_inst0.reg_r6_q;
            7:  return dut.ID_stage_inst.RF_inst0.reg_r7_q;
            8:  return dut.ID_stage_inst.RF_inst0.reg_r8_q;
            9:  return dut.ID_stage_inst.RF_inst0.reg_r9_q;
            10: return dut.ID_stage_inst.RF_inst0.reg_r10_q;
            11: return dut.ID_stage_inst.RF_inst0.reg_r11_q;
            12: return dut.ID_stage_inst.RF_inst0.reg_r12_q;
            13: return dut.ID_stage_inst.RF_inst0.reg_r13_q;
            14: return dut.ID_stage_inst.RF_inst0.reg_r14_q;
            15: return dut.ID_stage_inst.RF_inst0.reg_r15_q;
            16: return dut.ID_stage_inst.RF_inst0.reg_r16_q;
            17: return dut.ID_stage_inst.RF_inst0.reg_r17_q;
            18: return dut.ID_stage_inst.RF_inst0.reg_r18_q;
            19: return dut.ID_stage_inst.RF_inst0.reg_r19_q;
            20: return dut.ID_stage_inst.RF_inst0.reg_r20_q;
            21: return dut.ID_stage_inst.RF_inst0.reg_r21_q;
            22: return dut.ID_stage_inst.RF_inst0.reg_r22_q;
            23: return dut.ID_stage_inst.RF_inst0.reg_r23_q;
            24: return dut.ID_stage_inst.RF_inst0.reg_r24_q;
            25: return dut.ID_stage_inst.RF_inst0.reg_r25_q;
            26: return dut.ID_stage_inst.RF_inst0.reg_r26_q;
            27: return dut.ID_stage_inst.RF_inst0.reg_r27_q;
            28: return dut.ID_stage_inst.RF_inst0.reg_r28_q;
            29: return dut.ID_stage_inst.RF_inst0.reg_r29_q;
            30: return dut.ID_stage_inst.RF_inst0.reg_r30_q;
            31: return dut.ID_stage_inst.RF_inst0.reg_r31_q;
            default: return 32'h0000_0000;
        endcase
    endfunction

    function automatic logic [31:0] get_dmem_word(
        input int word_index_i
    );
        return {
            dut.MEM_stage_inst.DMEM_inst0.bank3[word_index_i],
            dut.MEM_stage_inst.DMEM_inst0.bank2[word_index_i],
            dut.MEM_stage_inst.DMEM_inst0.bank1[word_index_i],
            dut.MEM_stage_inst.DMEM_inst0.bank0[word_index_i]
        };
    endfunction

    initial begin : dut_bridge
        testbench_interface.reset_n = 1'b0;

        forever begin
            @testbench_interface.request_event;
            prepare_memories();
            write_imem(0, testbench_interface.instruction);

            if (testbench_interface.test_kind == 1) begin
                dut.MEM_stage_inst.DMEM_inst0.bank0[2] = 8'h34;
                dut.MEM_stage_inst.DMEM_inst0.bank1[2] = 8'h80;
                dut.MEM_stage_inst.DMEM_inst0.bank2[2] = 8'h00;
                dut.MEM_stage_inst.DMEM_inst0.bank3[2] = 8'h7f;
            end

            reset_core();
            set_register(1, testbench_interface.rs1_value);
            set_register(2, testbench_interface.rs2_value);

            case (testbench_interface.test_kind)
                3: begin
                    repeat (3) @(posedge clock);
                    #1;
                    testbench_interface.actual_value = dut.IF_stage_inst.PC_inst0.PC_r;
                    testbench_interface.actual_aux_value = 32'h0000_0000;
                end

                4: begin
                    repeat (3) @(posedge clock);
                    #1;
                    testbench_interface.actual_value = dut.IF_stage_inst.PC_inst0.PC_r;
                    repeat (6) @(posedge clock);
                    #1;
                    testbench_interface.actual_aux_value = get_register(testbench_interface.rd_index);
                end

                2: begin
                    repeat (8) @(posedge clock);
                    #1;
                    testbench_interface.actual_value = get_dmem_word(4);
                    testbench_interface.actual_aux_value = 32'h0000_0000;
                end

                5: begin
                    set_register(31, 32'h1357_9bdf);
                    repeat (8) @(posedge clock);
                    #1;
                    testbench_interface.actual_value = get_register(31);
                    testbench_interface.actual_aux_value = 32'h0000_0000;
                end

                default: begin
                    repeat (9) @(posedge clock);
                    #1;
                    testbench_interface.actual_value = get_register(testbench_interface.rd_index);
                    testbench_interface.actual_aux_value = 32'h0000_0000;
                end
            endcase

            ->testbench_interface.complete_event;
        end
    end

    initial begin : timeout_watchdog
        #100us;
        $fatal(1, "[TB] Timeout waiting for RV32I regression completion");
    end

endmodule
