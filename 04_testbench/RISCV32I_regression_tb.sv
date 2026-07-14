`timescale 1ns/1ps

module RISCV32I_regression_tb;
    localparam time CLOCK_PERIOD = 10ns;
    localparam logic [31:0] NOP_INSTRUCTION = 32'h0000_0013;
    localparam integer PIPELINE_DRAIN_CYCLES = 14;
    localparam integer EXPECTED_INSTRUCTION_CASES = 40;
    localparam integer EXPECTED_SEQUENCE_CASES = 10;

    logic clock;
    logic reset_n;
    bit regression_done;
    integer pass_count;
    integer fail_count;
    integer instruction_case_count;
    integer sequence_case_count;
    bit pc_unknown_reported;
    bit pc_alignment_reported;

    RISCV dut(
        .clk_i  (clock),
        .rstn_i (reset_n)
    );

    always #(CLOCK_PERIOD / 2) begin
        clock = ~clock;
    end

    function automatic logic [31:0] encode_r_type(
        input logic [6:0] funct7_i,
        input logic [4:0] rs2_i,
        input logic [4:0] rs1_i,
        input logic [2:0] funct3_i,
        input logic [4:0] rd_i
    );
        encode_r_type = {
            funct7_i,
            rs2_i,
            rs1_i,
            funct3_i,
            rd_i,
            7'b0110011
        };
    endfunction

    function automatic logic [31:0] encode_i_type(
        input integer immediate_i,
        input logic [4:0] rs1_i,
        input logic [2:0] funct3_i,
        input logic [4:0] rd_i,
        input logic [6:0] opcode_i
    );
        encode_i_type = {
            immediate_i[11:0],
            rs1_i,
            funct3_i,
            rd_i,
            opcode_i
        };
    endfunction

    function automatic logic [31:0] encode_s_type(
        input integer immediate_i,
        input logic [4:0] rs2_i,
        input logic [4:0] rs1_i,
        input logic [2:0] funct3_i
    );
        encode_s_type = {
            immediate_i[11:5],
            rs2_i,
            rs1_i,
            funct3_i,
            immediate_i[4:0],
            7'b0100011
        };
    endfunction

    function automatic logic [31:0] encode_b_type(
        input integer immediate_i,
        input logic [4:0] rs2_i,
        input logic [4:0] rs1_i,
        input logic [2:0] funct3_i
    );
        encode_b_type = {
            immediate_i[12],
            immediate_i[10:5],
            rs2_i,
            rs1_i,
            funct3_i,
            immediate_i[4:1],
            immediate_i[11],
            7'b1100011
        };
    endfunction

    function automatic logic [31:0] encode_u_type(
        input logic [19:0] immediate_i,
        input logic [4:0] rd_i,
        input logic [6:0] opcode_i
    );
        encode_u_type = {
            immediate_i,
            rd_i,
            opcode_i
        };
    endfunction

    function automatic logic [31:0] encode_j_type(
        input integer immediate_i,
        input logic [4:0] rd_i
    );
        encode_j_type = {
            immediate_i[20],
            immediate_i[10:1],
            immediate_i[11],
            immediate_i[19:12],
            rd_i,
            7'b1101111
        };
    endfunction

    function automatic logic [31:0] get_register(
        input integer register_index_i
    );
        case (register_index_i)
            0:  get_register = 32'h0000_0000;
            1:  get_register = dut.ID_stage_inst.RF_inst0.reg_r1_q;
            2:  get_register = dut.ID_stage_inst.RF_inst0.reg_r2_q;
            3:  get_register = dut.ID_stage_inst.RF_inst0.reg_r3_q;
            4:  get_register = dut.ID_stage_inst.RF_inst0.reg_r4_q;
            5:  get_register = dut.ID_stage_inst.RF_inst0.reg_r5_q;
            6:  get_register = dut.ID_stage_inst.RF_inst0.reg_r6_q;
            7:  get_register = dut.ID_stage_inst.RF_inst0.reg_r7_q;
            8:  get_register = dut.ID_stage_inst.RF_inst0.reg_r8_q;
            9:  get_register = dut.ID_stage_inst.RF_inst0.reg_r9_q;
            10: get_register = dut.ID_stage_inst.RF_inst0.reg_r10_q;
            11: get_register = dut.ID_stage_inst.RF_inst0.reg_r11_q;
            12: get_register = dut.ID_stage_inst.RF_inst0.reg_r12_q;
            13: get_register = dut.ID_stage_inst.RF_inst0.reg_r13_q;
            14: get_register = dut.ID_stage_inst.RF_inst0.reg_r14_q;
            15: get_register = dut.ID_stage_inst.RF_inst0.reg_r15_q;
            16: get_register = dut.ID_stage_inst.RF_inst0.reg_r16_q;
            17: get_register = dut.ID_stage_inst.RF_inst0.reg_r17_q;
            18: get_register = dut.ID_stage_inst.RF_inst0.reg_r18_q;
            19: get_register = dut.ID_stage_inst.RF_inst0.reg_r19_q;
            20: get_register = dut.ID_stage_inst.RF_inst0.reg_r20_q;
            21: get_register = dut.ID_stage_inst.RF_inst0.reg_r21_q;
            22: get_register = dut.ID_stage_inst.RF_inst0.reg_r22_q;
            23: get_register = dut.ID_stage_inst.RF_inst0.reg_r23_q;
            24: get_register = dut.ID_stage_inst.RF_inst0.reg_r24_q;
            25: get_register = dut.ID_stage_inst.RF_inst0.reg_r25_q;
            26: get_register = dut.ID_stage_inst.RF_inst0.reg_r26_q;
            27: get_register = dut.ID_stage_inst.RF_inst0.reg_r27_q;
            28: get_register = dut.ID_stage_inst.RF_inst0.reg_r28_q;
            29: get_register = dut.ID_stage_inst.RF_inst0.reg_r29_q;
            30: get_register = dut.ID_stage_inst.RF_inst0.reg_r30_q;
            31: get_register = dut.ID_stage_inst.RF_inst0.reg_r31_q;
            default: get_register = 32'hxxxx_xxxx;
        endcase
    endfunction

    function automatic logic [31:0] get_dmem_word(
        input integer word_index_i
    );
        get_dmem_word = {
            dut.MEM_stage_inst.DMEM_inst0.bank3[word_index_i],
            dut.MEM_stage_inst.DMEM_inst0.bank2[word_index_i],
            dut.MEM_stage_inst.DMEM_inst0.bank1[word_index_i],
            dut.MEM_stage_inst.DMEM_inst0.bank0[word_index_i]
        };
    endfunction

    task automatic set_register(
        input integer register_index_i,
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
            end
        endcase
    endtask

    task automatic set_dmem_word(
        input integer word_index_i,
        input logic [31:0] word_value_i
    );
        dut.MEM_stage_inst.DMEM_inst0.bank0[word_index_i] = word_value_i[7:0];
        dut.MEM_stage_inst.DMEM_inst0.bank1[word_index_i] = word_value_i[15:8];
        dut.MEM_stage_inst.DMEM_inst0.bank2[word_index_i] = word_value_i[23:16];
        dut.MEM_stage_inst.DMEM_inst0.bank3[word_index_i] = word_value_i[31:24];
    endtask

    task automatic write_instruction(
        input integer byte_address_i,
        input logic [31:0] instruction_i
    );
        dut.IF_stage_inst.IMEM_inst0.imem[byte_address_i + 0] = instruction_i[31:24];
        dut.IF_stage_inst.IMEM_inst0.imem[byte_address_i + 1] = instruction_i[23:16];
        dut.IF_stage_inst.IMEM_inst0.imem[byte_address_i + 2] = instruction_i[15:8];
        dut.IF_stage_inst.IMEM_inst0.imem[byte_address_i + 3] = instruction_i[7:0];
    endtask

    task automatic clear_imem;
        integer byte_address_v;

        for (byte_address_v = 0;
             byte_address_v < 1024;
             byte_address_v = byte_address_v + 4) begin
            write_instruction(byte_address_v, NOP_INSTRUCTION);
        end
    endtask

    task automatic clear_dmem;
        integer word_index_v;

        for (word_index_v = 0;
             word_index_v < 64;
             word_index_v = word_index_v + 1) begin
            set_dmem_word(word_index_v, 32'h0000_0000);
        end
    endtask

    task automatic record_failure(
        input string failure_name_i,
        input string failure_detail_i
    );
        fail_count = fail_count + 1;
        $display("[FAIL] %-38s %s", failure_name_i, failure_detail_i);
    endtask

    task automatic check_value(
        input string check_name_i,
        input logic [31:0] actual_value_i,
        input logic [31:0] expected_value_i
    );
        if (actual_value_i === expected_value_i) begin
            pass_count = pass_count + 1;
            $display("[PASS] %-38s value=0x%08h", check_name_i, actual_value_i);
        end else begin
            fail_count = fail_count + 1;
            $display(
                "[FAIL] %-38s expected=0x%08h actual=0x%08h",
                check_name_i,
                expected_value_i,
                actual_value_i
            );
        end
    endtask

    task automatic check_condition(
        input string check_name_i,
        input logic condition_i
    );
        if (condition_i === 1'b1) begin
            pass_count = pass_count + 1;
            $display("[PASS] %-38s", check_name_i);
        end else begin
            fail_count = fail_count + 1;
            $display("[FAIL] %-38s condition was not true", check_name_i);
        end
    endtask

    task automatic reset_and_clear_core;
        @(negedge clock);
        reset_n = 1'b0;
        clear_imem();
        clear_dmem();
        repeat (3) @(posedge clock);
        @(negedge clock);

        pc_unknown_reported      = 1'b0;
        pc_alignment_reported    = 1'b0;
    endtask

    task automatic release_core;
        reset_n = 1'b1;
    endtask

    task automatic run_pipeline_cycles(
        input string test_name_i,
        input integer cycle_count_i
    );
        integer cycle_index_v;

        for (cycle_index_v = 0;
             cycle_index_v < cycle_count_i;
             cycle_index_v = cycle_index_v + 1) begin
            @(posedge clock);
            #1;

            if ($isunknown(dut.addr_IF_w) && !pc_unknown_reported) begin
                record_failure(test_name_i, "fetch PC became X/Z");
                pc_unknown_reported = 1'b1;
            end

            if (!$isunknown(dut.addr_IF_w) &&
                (dut.addr_IF_w[1:0] !== 2'b00) &&
                !pc_alignment_reported) begin
                record_failure(test_name_i, "fetch PC became misaligned");
                pc_alignment_reported = 1'b1;
            end

        end
    endtask

    task automatic start_instruction_case(
        input string instruction_name_i
    );
        instruction_case_count = instruction_case_count + 1;
        $display(
            "\n[INSTRUCTION %0d/%0d] %s",
            instruction_case_count,
            EXPECTED_INSTRUCTION_CASES,
            instruction_name_i
        );
    endtask

    task automatic start_sequence_case(
        input string sequence_name_i
    );
        sequence_case_count = sequence_case_count + 1;
        $display(
            "\n[SEQUENCE %0d/%0d] %s",
            sequence_case_count,
            EXPECTED_SEQUENCE_CASES,
            sequence_name_i
        );
    endtask

    task automatic run_register_instruction(
        input string instruction_name_i,
        input logic [31:0] instruction_i,
        input integer rs1_index_i,
        input logic [31:0] rs1_value_i,
        input integer rs2_index_i,
        input logic [31:0] rs2_value_i,
        input integer rd_index_i,
        input logic [31:0] expected_value_i
    );
        reset_and_clear_core();
        write_instruction(0, instruction_i);
        set_register(rs1_index_i, rs1_value_i);
        set_register(rs2_index_i, rs2_value_i);
        start_instruction_case(instruction_name_i);
        release_core();
        run_pipeline_cycles(instruction_name_i, PIPELINE_DRAIN_CYCLES);
        check_value(
            $sformatf("%s result", instruction_name_i),
            get_register(rd_index_i),
            expected_value_i
        );
    endtask

    task automatic run_load_instruction(
        input string instruction_name_i,
        input logic [2:0] funct3_i,
        input integer immediate_i,
        input logic [31:0] expected_value_i
    );
        reset_and_clear_core();
        write_instruction(
            0,
            encode_i_type(immediate_i, 5'd1, funct3_i, 5'd5, 7'b0000011)
        );
        set_register(1, 32'd8);
        set_dmem_word(2, 32'h7f00_8034);
        start_instruction_case(instruction_name_i);
        release_core();
        run_pipeline_cycles(instruction_name_i, PIPELINE_DRAIN_CYCLES);
        check_value(
            $sformatf("%s result", instruction_name_i),
            get_register(5),
            expected_value_i
        );
    endtask

    task automatic run_store_instruction(
        input string instruction_name_i,
        input logic [2:0] funct3_i,
        input integer immediate_i,
        input logic [31:0] initial_word_i,
        input logic [31:0] expected_word_i
    );
        reset_and_clear_core();
        write_instruction(
            0,
            encode_s_type(immediate_i, 5'd2, 5'd1, funct3_i)
        );
        set_register(1, 32'd16);
        set_register(2, 32'ha1b2_c3d4);
        set_dmem_word(4, initial_word_i);
        start_instruction_case(instruction_name_i);
        release_core();
        run_pipeline_cycles(instruction_name_i, PIPELINE_DRAIN_CYCLES);
        check_value(
            $sformatf("%s memory result", instruction_name_i),
            get_dmem_word(4),
            expected_word_i
        );
    endtask

    task automatic run_branch_instruction(
        input string instruction_name_i,
        input logic [2:0] funct3_i,
        input logic [31:0] taken_rs1_value_i,
        input logic [31:0] taken_rs2_value_i,
        input logic [31:0] not_taken_rs1_value_i,
        input logic [31:0] not_taken_rs2_value_i
    );
        reset_and_clear_core();
        write_instruction(
            0,
            encode_b_type(16, 5'd2, 5'd1, funct3_i)
        );
        write_instruction(
            4,
            encode_i_type(1, 5'd0, 3'b000, 5'd20, 7'b0010011)
        );
        write_instruction(
            16,
            encode_i_type(2, 5'd0, 3'b000, 5'd21, 7'b0010011)
        );
        set_register(1, taken_rs1_value_i);
        set_register(2, taken_rs2_value_i);
        start_instruction_case(instruction_name_i);
        release_core();
        run_pipeline_cycles(instruction_name_i, 20);
        check_value(
            $sformatf("%s squashes wrong path", instruction_name_i),
            get_register(20),
            32'h0000_0000
        );
        check_value(
            $sformatf("%s target executes", instruction_name_i),
            get_register(21),
            32'h0000_0002
        );

        reset_and_clear_core();
        write_instruction(
            0,
            encode_b_type(16, 5'd2, 5'd1, funct3_i)
        );
        write_instruction(
            4,
            encode_i_type(1, 5'd0, 3'b000, 5'd20, 7'b0010011)
        );
        write_instruction(8, encode_j_type(12, 5'd0));
        write_instruction(
            16,
            encode_i_type(2, 5'd0, 3'b000, 5'd21, 7'b0010011)
        );
        set_register(1, not_taken_rs1_value_i);
        set_register(2, not_taken_rs2_value_i);
        release_core();
        run_pipeline_cycles(
            $sformatf("%s not taken", instruction_name_i),
            24
        );
        check_value(
            $sformatf("%s not-taken path executes", instruction_name_i),
            get_register(20),
            32'h0000_0001
        );
        check_value(
            $sformatf("%s not-taken skips target", instruction_name_i),
            get_register(21),
            32'h0000_0000
        );
    endtask

    task automatic run_jal_instruction;
        reset_and_clear_core();
        write_instruction(0, encode_j_type(16, 5'd5));
        write_instruction(
            4,
            encode_s_type(24, 5'd1, 5'd0, 3'b010)
        );
        write_instruction(
            8,
            encode_i_type(1, 5'd0, 3'b000, 5'd20, 7'b0010011)
        );
        write_instruction(
            16,
            encode_i_type(1, 5'd5, 3'b000, 5'd6, 7'b0010011)
        );
        set_register(1, 32'hdead_beef);
        set_dmem_word(6, 32'hface_cafe);
        start_instruction_case("JAL");
        start_sequence_case("JAL link, redirect and flush");
        release_core();
        run_pipeline_cycles("JAL", 22);
        check_value("JAL link x5", get_register(5), 32'd4);
        check_value("JAL target uses link", get_register(6), 32'd5);
        check_value("JAL squashes register write", get_register(20), 32'd0);
        check_value("JAL squashes store", get_dmem_word(6), 32'hface_cafe);
    endtask

    task automatic run_jalr_instruction;
        reset_and_clear_core();
        write_instruction(
            0,
            encode_i_type(21, 5'd0, 3'b000, 5'd1, 7'b0010011)
        );
        write_instruction(
            4,
            encode_i_type(0, 5'd1, 3'b000, 5'd5, 7'b1100111)
        );
        write_instruction(
            8,
            encode_s_type(28, 5'd2, 5'd0, 3'b010)
        );
        write_instruction(
            12,
            encode_i_type(1, 5'd0, 3'b000, 5'd20, 7'b0010011)
        );
        write_instruction(
            20,
            encode_i_type(1, 5'd5, 3'b000, 5'd6, 7'b0010011)
        );
        set_register(2, 32'hdead_beef);
        set_dmem_word(7, 32'hcafe_f00d);
        start_instruction_case("JALR");
        start_sequence_case("JALR dependency, bit zero, link and flush");
        release_core();
        run_pipeline_cycles("JALR", 26);
        check_value("JALR link x5", get_register(5), 32'd8);
        check_value("JALR target uses link", get_register(6), 32'd9);
        check_value("JALR squashes register write", get_register(20), 32'd0);
        check_value("JALR squashes store", get_dmem_word(7), 32'hcafe_f00d);
    endtask

    task automatic run_system_instruction(
        input string instruction_name_i,
        input logic [31:0] instruction_i
    );
        reset_and_clear_core();
        write_instruction(0, instruction_i);
        write_instruction(
            4,
            encode_i_type(7, 5'd0, 3'b000, 5'd30, 7'b0010011)
        );
        set_register(31, 32'h1357_9bdf);
        start_instruction_case(instruction_name_i);
        release_core();
        run_pipeline_cycles(instruction_name_i, PIPELINE_DRAIN_CYCLES);
        check_value(
            $sformatf("%s has no register side effect", instruction_name_i),
            get_register(31),
            32'h1357_9bdf
        );
        check_value(
            $sformatf("%s pipeline continues", instruction_name_i),
            get_register(30),
            32'd7
        );
    endtask

    task automatic run_forwarding_sequences;
        reset_and_clear_core();
        write_instruction(
            0,
            encode_i_type(10, 5'd0, 3'b000, 5'd1, 7'b0010011)
        );
        write_instruction(
            4,
            encode_i_type(3, 5'd0, 3'b000, 5'd2, 7'b0010011)
        );
        write_instruction(
            8,
            encode_r_type(7'b0000000, 5'd2, 5'd1, 3'b000, 5'd3)
        );
        start_sequence_case("MEM forwarding A and EX forwarding B");
        release_core();
        run_pipeline_cycles("FORWARD_MEM_A_EX_B", 16);
        check_value("MEM-A/EX-B arithmetic result", get_register(3), 32'd13);

        reset_and_clear_core();
        write_instruction(
            0,
            encode_i_type(6, 5'd0, 3'b000, 5'd4, 7'b0010011)
        );
        write_instruction(
            4,
            encode_i_type(7, 5'd0, 3'b000, 5'd5, 7'b0010011)
        );
        write_instruction(
            8,
            encode_r_type(7'b0100000, 5'd4, 5'd5, 3'b000, 5'd6)
        );
        start_sequence_case("EX forwarding A and MEM forwarding B");
        release_core();
        run_pipeline_cycles("FORWARD_EX_A_MEM_B", 16);
        check_value("EX-A/MEM-B arithmetic result", get_register(6), 32'd1);

        reset_and_clear_core();
        write_instruction(
            0,
            encode_i_type(42, 5'd0, 3'b000, 5'd10, 7'b0010011)
        );
        write_instruction(
            4,
            encode_i_type(1, 5'd0, 3'b000, 5'd20, 7'b0010011)
        );
        write_instruction(
            8,
            encode_i_type(2, 5'd0, 3'b000, 5'd21, 7'b0010011)
        );
        write_instruction(
            12,
            encode_i_type(1, 5'd10, 3'b000, 5'd11, 7'b0010011)
        );
        start_sequence_case("WB-to-ID same-edge write-through");
        release_core();
        run_pipeline_cycles("WB_TO_ID", 20);
        check_value("WB-to-ID consumer result", get_register(11), 32'd43);

        reset_and_clear_core();
        write_instruction(
            0,
            encode_i_type(123, 5'd0, 3'b000, 5'd0, 7'b0010011)
        );
        write_instruction(
            4,
            encode_i_type(1, 5'd0, 3'b000, 5'd12, 7'b0010011)
        );
        start_sequence_case("x0 write protection and forwarding exclusion");
        release_core();
        run_pipeline_cycles("X0_PROTECTION", 16);
        check_value(
            "x0 remains zero",
            dut.ID_stage_inst.RF_inst0.x0_zero_w,
            32'h0000_0000
        );
        check_value("x0 consumer sees zero", get_register(12), 32'd1);
    endtask

    task automatic run_load_use_sequence;
        reset_and_clear_core();
        write_instruction(
            0,
            encode_i_type(0, 5'd0, 3'b010, 5'd7, 7'b0000011)
        );
        write_instruction(
            4,
            encode_r_type(7'b0000000, 5'd7, 5'd7, 3'b000, 5'd8)
        );
        set_dmem_word(0, 32'h1234_5678);
        start_sequence_case("Load-use stall and forwarding");
        release_core();
        run_pipeline_cycles("LOAD_USE", 18);
        check_value("Load-use loaded value", get_register(7), 32'h1234_5678);
        check_value("Load-use consumer result", get_register(8), 32'h2468_acf0);
    endtask

    task automatic run_store_forwarding_sequence;
        reset_and_clear_core();
        write_instruction(
            0,
            encode_i_type(90, 5'd0, 3'b000, 5'd9, 7'b0010011)
        );
        write_instruction(
            4,
            encode_s_type(16, 5'd9, 5'd0, 3'b010)
        );
        start_sequence_case("Store-data EX forwarding");
        release_core();
        run_pipeline_cycles("STORE_DATA_FORWARD", 16);
        check_value("Store-data forwarded memory value", get_dmem_word(4), 32'd90);
    endtask

    task automatic run_branch_flush_sequence;
        reset_and_clear_core();
        write_instruction(
            0,
            encode_i_type(1, 5'd0, 3'b000, 5'd10, 7'b0010011)
        );
        write_instruction(
            4,
            encode_b_type(12, 5'd0, 5'd10, 3'b001)
        );
        write_instruction(
            8,
            encode_s_type(20, 5'd12, 5'd0, 3'b010)
        );
        write_instruction(
            12,
            encode_i_type(1, 5'd0, 3'b000, 5'd20, 7'b0010011)
        );
        write_instruction(
            16,
            encode_i_type(7, 5'd0, 3'b000, 5'd11, 7'b0010011)
        );
        set_register(12, 32'hdead_beef);
        set_dmem_word(5, 32'hcafe_babe);
        start_sequence_case("Taken dependent branch squashes side effects");
        release_core();
        run_pipeline_cycles("BRANCH_TAKEN_FLUSH", 22);
        check_value("Branch squashes wrong-path store", get_dmem_word(5), 32'hcafe_babe);
        check_value("Branch squashes wrong-path register", get_register(20), 32'd0);
        check_value("Branch target executes", get_register(11), 32'd7);
    endtask

    task automatic run_backward_branch_sequence;
        reset_and_clear_core();
        write_instruction(
            0,
            encode_i_type(0, 5'd0, 3'b000, 5'd1, 7'b0010011)
        );
        write_instruction(
            4,
            encode_i_type(3, 5'd0, 3'b000, 5'd2, 7'b0010011)
        );
        write_instruction(
            8,
            encode_i_type(1, 5'd1, 3'b000, 5'd1, 7'b0010011)
        );
        write_instruction(
            12,
            encode_b_type(-4, 5'd2, 5'd1, 3'b100)
        );
        write_instruction(
            16,
            encode_i_type(0, 5'd1, 3'b000, 5'd3, 7'b0010011)
        );
        start_sequence_case("Backward branch loop and signed immediate");
        release_core();
        run_pipeline_cycles("BACKWARD_BRANCH", 40);
        check_value("Backward branch loop count", get_register(1), 32'd3);
        check_value("Backward branch exits loop", get_register(3), 32'd3);
    endtask

    initial begin
        clock                  = 1'b0;
        reset_n                = 1'b0;
        regression_done        = 1'b0;
        pass_count             = 0;
        fail_count             = 0;
        instruction_case_count = 0;
        sequence_case_count    = 0;

        $display("\n============================================================");
        $display(" RV32I SELF-CHECKING SYSTEMVERILOG REGRESSION");
        $display("============================================================");

        run_register_instruction(
            "ADD",
            encode_r_type(7'b0000000, 5'd2, 5'd1, 3'b000, 5'd5),
            1,
            32'd15,
            2,
            32'd6,
            5,
            32'd21
        );
        run_register_instruction(
            "SUB",
            encode_r_type(7'b0100000, 5'd2, 5'd1, 3'b000, 5'd5),
            1,
            32'd15,
            2,
            32'd6,
            5,
            32'd9
        );
        run_register_instruction(
            "SLL",
            encode_r_type(7'b0000000, 5'd2, 5'd1, 3'b001, 5'd5),
            1,
            32'd3,
            2,
            32'd4,
            5,
            32'd48
        );
        run_register_instruction(
            "SLT",
            encode_r_type(7'b0000000, 5'd2, 5'd1, 3'b010, 5'd5),
            1,
            32'hffff_ffff,
            2,
            32'd1,
            5,
            32'd1
        );
        run_register_instruction(
            "SLTU",
            encode_r_type(7'b0000000, 5'd2, 5'd1, 3'b011, 5'd5),
            1,
            32'd1,
            2,
            32'hffff_ffff,
            5,
            32'd1
        );
        run_register_instruction(
            "XOR",
            encode_r_type(7'b0000000, 5'd2, 5'd1, 3'b100, 5'd5),
            1,
            32'h55aa_0f0f,
            2,
            32'h0ff0_3333,
            5,
            32'h5a5a_3c3c
        );
        run_register_instruction(
            "SRL",
            encode_r_type(7'b0000000, 5'd2, 5'd1, 3'b101, 5'd5),
            1,
            32'h8000_0000,
            2,
            32'd4,
            5,
            32'h0800_0000
        );
        run_register_instruction(
            "SRA",
            encode_r_type(7'b0100000, 5'd2, 5'd1, 3'b101, 5'd5),
            1,
            32'h8000_0000,
            2,
            32'd4,
            5,
            32'hf800_0000
        );
        run_register_instruction(
            "OR",
            encode_r_type(7'b0000000, 5'd2, 5'd1, 3'b110, 5'd5),
            1,
            32'h5500_0f00,
            2,
            32'h00aa_00f0,
            5,
            32'h55aa_0ff0
        );
        run_register_instruction(
            "AND",
            encode_r_type(7'b0000000, 5'd2, 5'd1, 3'b111, 5'd5),
            1,
            32'h55aa_0f0f,
            2,
            32'h0ff0_3333,
            5,
            32'h05a0_0303
        );

        run_register_instruction(
            "ADDI",
            encode_i_type(-7, 5'd1, 3'b000, 5'd5, 7'b0010011),
            1,
            32'd20,
            0,
            32'd0,
            5,
            32'd13
        );
        run_register_instruction(
            "SLTI",
            encode_i_type(1, 5'd1, 3'b010, 5'd5, 7'b0010011),
            1,
            32'hffff_ffff,
            0,
            32'd0,
            5,
            32'd1
        );
        run_register_instruction(
            "SLTIU",
            encode_i_type(-1, 5'd1, 3'b011, 5'd5, 7'b0010011),
            1,
            32'd1,
            0,
            32'd0,
            5,
            32'd1
        );
        run_register_instruction(
            "XORI",
            encode_i_type(12'h0f0, 5'd1, 3'b100, 5'd5, 7'b0010011),
            1,
            32'h55aa_0f0f,
            0,
            32'd0,
            5,
            32'h55aa_0fff
        );
        run_register_instruction(
            "ORI",
            encode_i_type(12'h0f0, 5'd1, 3'b110, 5'd5, 7'b0010011),
            1,
            32'h5500_000f,
            0,
            32'd0,
            5,
            32'h5500_00ff
        );
        run_register_instruction(
            "ANDI",
            encode_i_type(12'h0f0, 5'd1, 3'b111, 5'd5, 7'b0010011),
            1,
            32'h55aa_0f0f,
            0,
            32'd0,
            5,
            32'h0000_0000
        );
        run_register_instruction(
            "SLLI",
            encode_i_type(4, 5'd1, 3'b001, 5'd5, 7'b0010011),
            1,
            32'd3,
            0,
            32'd0,
            5,
            32'd48
        );
        run_register_instruction(
            "SRLI",
            encode_i_type(4, 5'd1, 3'b101, 5'd5, 7'b0010011),
            1,
            32'h8000_0000,
            0,
            32'd0,
            5,
            32'h0800_0000
        );
        run_register_instruction(
            "SRAI",
            encode_i_type(12'h404, 5'd1, 3'b101, 5'd5, 7'b0010011),
            1,
            32'h8000_0000,
            0,
            32'd0,
            5,
            32'hf800_0000
        );

        run_register_instruction(
            "LUI",
            encode_u_type(20'habcde, 5'd5, 7'b0110111),
            0,
            32'd0,
            0,
            32'd0,
            5,
            32'habcde000
        );
        run_register_instruction(
            "AUIPC",
            encode_u_type(20'h00012, 5'd5, 7'b0010111),
            0,
            32'd0,
            0,
            32'd0,
            5,
            32'h00012000
        );

        run_load_instruction("LB", 3'b000, 1, 32'hffff_ff80);
        run_load_instruction("LH", 3'b001, 0, 32'hffff_8034);
        run_load_instruction("LW", 3'b010, 0, 32'h7f00_8034);
        run_load_instruction("LBU", 3'b100, 1, 32'h0000_0080);
        run_load_instruction("LHU", 3'b101, 0, 32'h0000_8034);

        run_store_instruction(
            "SB",
            3'b000,
            1,
            32'h1122_3344,
            32'h1122_d444
        );
        run_store_instruction(
            "SH",
            3'b001,
            2,
            32'h1122_3344,
            32'hc3d4_3344
        );
        run_store_instruction(
            "SW",
            3'b010,
            0,
            32'h1122_3344,
            32'ha1b2_c3d4
        );

        run_branch_instruction(
            "BEQ",
            3'b000,
            32'd9,
            32'd9,
            32'd9,
            32'd8
        );
        run_branch_instruction(
            "BNE",
            3'b001,
            32'd9,
            32'd8,
            32'd9,
            32'd9
        );
        run_branch_instruction(
            "BLT",
            3'b100,
            32'hffff_ffff,
            32'd1,
            32'd1,
            32'hffff_ffff
        );
        run_branch_instruction(
            "BGE",
            3'b101,
            32'd1,
            32'hffff_ffff,
            32'hffff_ffff,
            32'd1
        );
        run_branch_instruction(
            "BLTU",
            3'b110,
            32'd1,
            32'hffff_ffff,
            32'hffff_ffff,
            32'd1
        );
        run_branch_instruction(
            "BGEU",
            3'b111,
            32'hffff_ffff,
            32'd1,
            32'd1,
            32'hffff_ffff
        );

        run_jal_instruction();
        run_jalr_instruction();

        run_system_instruction("FENCE", 32'h0000_000f);
        run_system_instruction("ECALL", 32'h0000_0073);
        run_system_instruction("EBREAK", 32'h0010_0073);

        run_forwarding_sequences();
        run_load_use_sequence();
        run_store_forwarding_sequence();
        run_branch_flush_sequence();
        run_backward_branch_sequence();

        check_value(
            "Instruction case count",
            instruction_case_count,
            EXPECTED_INSTRUCTION_CASES
        );
        check_value(
            "Pipeline sequence count",
            sequence_case_count,
            EXPECTED_SEQUENCE_CASES
        );

        regression_done = 1'b1;
        $display("\n============================================================");
        $display(
            "RV32I REGRESSION SUMMARY: PASS=%0d FAIL=%0d TOTAL=%0d",
            pass_count,
            fail_count,
            pass_count + fail_count
        );
        $display(
            "INSTRUCTION_CASES=%0d SEQUENCE_CASES=%0d",
            instruction_case_count,
            sequence_case_count
        );
        $display("============================================================\n");

        if (fail_count != 0) begin
            $fatal(1, "RV32I regression failed with %0d error(s)", fail_count);
        end

        $finish;
    end

    initial begin
        #1ms;
        if (!regression_done) begin
            $fatal(1, "RV32I regression timeout");
        end
    end

endmodule
