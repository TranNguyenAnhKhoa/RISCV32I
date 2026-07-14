`ifndef RISCV32I_GENERATOR_SV
`define RISCV32I_GENERATOR_SV
class RISCV32I_Generator;
    riscv_packet_mbox output_mbox;
    int generated_count;
    function new(
        input riscv_packet_mbox output_mbox_i
    );
        this.output_mbox=output_mbox_i; generated_count=0;
    endfunction

    function logic [31:0] encode_r_type(
        input int funct7_i,
        input int rs2_i,
        input int rs1_i,
        input int funct3_i,
        input int rd_i
    );
        return {funct7_i[6:0],rs2_i[4:0],rs1_i[4:0],funct3_i[2:0],rd_i[4:0],7'h33};
    endfunction
    function logic [31:0] encode_i_type(
        input int immediate_i,
        input int rs1_i,
        input int funct3_i,
        input int rd_i,
        input int opcode_i=7'h13
    );
        return {immediate_i[11:0],rs1_i[4:0],funct3_i[2:0],rd_i[4:0],opcode_i[6:0]};
    endfunction
    function logic [31:0] encode_s_type(
        input int immediate_i,
        input int rs2_i,
        input int rs1_i,
        input int funct3_i
    );
        return {immediate_i[11:5],rs2_i[4:0],rs1_i[4:0],funct3_i[2:0],immediate_i[4:0],7'h23};
    endfunction
    function logic [31:0] encode_b_type(
        input int immediate_i,
        input int rs2_i,
        input int rs1_i,
        input int funct3_i
    );
        return {immediate_i[12],immediate_i[10:5],rs2_i[4:0],rs1_i[4:0],funct3_i[2:0],immediate_i[4:1],immediate_i[11],7'h63};
    endfunction
    function logic [31:0] encode_u_type(
        input int immediate_i,
        input int rd_i,
        input int opcode_i
    );
        return {immediate_i[19:0],rd_i[4:0],opcode_i[6:0]};
    endfunction
    function logic [31:0] encode_j_type(
        input int immediate_i,
        input int rd_i
    );
        return {immediate_i[20],immediate_i[10:1],immediate_i[11],immediate_i[19:12],rd_i[4:0],7'h6f};
    endfunction

    task add_test(
        input string test_name_i,
        input int test_kind_i,
        input int test_group_i,
        input logic [31:0] instruction_i,
        input logic [31:0] rs1_value_i,
        input logic [31:0] rs2_value_i,
        input int rd_index_i,
        input logic [31:0] expected_value_i,
        input logic [31:0] expected_aux_value_i=0
    );
        RISCV32I_Packet packet=new(test_name_i);
        packet.test_kind=test_kind_i; packet.test_group=test_group_i;
        packet.instruction=instruction_i; packet.rs1_value=rs1_value_i;
        packet.rs2_value=rs2_value_i; packet.rd_index=rd_index_i;
        packet.expected_value=expected_value_i;
        packet.expected_aux_value=expected_aux_value_i;
        output_mbox.put(packet); generated_count++;
    endtask

    task start();
        // kind: 0=register, 1=load, 2=store, 3=branch, 4=jump, 5=system
        // group: 0=R, 1=I, 2=U, 3=load, 4=store, 5=branch, 6=jump, 7=system
        add_test("ADD",0,0,encode_r_type(0,2,1,0,5),15,6,5,21); add_test("SUB",0,0,encode_r_type(32,2,1,0,5),15,6,5,9);
        add_test("SLL",0,0,encode_r_type(0,2,1,1,5),3,4,5,48); add_test("SLT",0,0,encode_r_type(0,2,1,2,5),32'hffffffff,1,5,1);
        add_test("SLTU",0,0,encode_r_type(0,2,1,3,5),1,32'hffffffff,5,1); add_test("XOR",0,0,encode_r_type(0,2,1,4,5),32'h55aa0f0f,32'h0ff03333,5,32'h5a5a3c3c);
        add_test("SRL",0,0,encode_r_type(0,2,1,5,5),32'h80000000,4,5,32'h08000000); add_test("SRA",0,0,encode_r_type(32,2,1,5,5),32'h80000000,4,5,32'hf8000000);
        add_test("OR",0,0,encode_r_type(0,2,1,6,5),32'h55000f00,32'h00aa00f0,5,32'h55aa0ff0); add_test("AND",0,0,encode_r_type(0,2,1,7,5),32'h55aa0f0f,32'h0ff03333,5,32'h05a00303);
        add_test("ADDI",0,1,encode_i_type(-7,1,0,11),20,0,11,13); add_test("SLTI",0,1,encode_i_type(1,1,2,5),32'hffffffff,0,5,1);
        add_test("SLTIU",0,1,encode_i_type(-1,1,3,5),1,0,5,1); add_test("XORI",0,1,encode_i_type('hf0,1,4,5),32'h55aa0f0f,0,5,32'h55aa0fff);
        add_test("ORI",0,1,encode_i_type('hf0,1,6,5),32'h5500000f,0,5,32'h550000ff); add_test("ANDI",0,1,encode_i_type('hf0,1,7,5),32'h55aa0f0f,0,5,0);
        add_test("SLLI",0,1,encode_i_type(4,1,1,5),3,0,5,48); add_test("SRLI",0,1,encode_i_type(4,1,5,5),32'h80000000,0,5,32'h08000000);
        add_test("SRAI",0,1,encode_i_type('h404,1,5,5),32'h80000000,0,5,32'hf8000000);
        add_test("LUI",0,2,encode_u_type('habcde,5,'h37),0,0,5,32'habcde000); add_test("AUIPC",0,2,encode_u_type('h12,5,'h17),0,0,5,32'h00012000);
        add_test("LB",1,3,encode_i_type(0,1,0,5,'h03),8,0,5,32'h34); add_test("LH",1,3,encode_i_type(0,1,1,5,'h03),8,0,5,32'hffff8034);
        add_test("LW",1,3,encode_i_type(0,1,2,5,'h03),8,0,5,32'h7f008034); add_test("LBU",1,3,encode_i_type(0,1,4,5,'h03),8,0,5,32'h34);
        add_test("LHU",1,3,encode_i_type(0,1,5,5,'h03),8,0,5,32'h8034);
        add_test("SB",2,4,encode_s_type(0,2,1,0),16,32'ha1b2c3d4,0,32'hd4); add_test("SH",2,4,encode_s_type(0,2,1,1),16,32'ha1b2c3d4,0,32'hc3d4);
        add_test("SW",2,4,encode_s_type(0,2,1,2),16,32'ha1b2c3d4,0,32'ha1b2c3d4);
        add_test("BEQ",3,5,encode_b_type(32,2,1,0),9,9,0,32); add_test("BNE",3,5,encode_b_type(32,2,1,1),9,8,0,32);
        add_test("BLT",3,5,encode_b_type(32,2,1,4),32'hffffffff,1,0,32); add_test("BGE",3,5,encode_b_type(32,2,1,5),1,32'hffffffff,0,32);
        add_test("BLTU",3,5,encode_b_type(32,2,1,6),1,32'hffffffff,0,32); add_test("BGEU",3,5,encode_b_type(32,2,1,7),32'hffffffff,1,0,32);
        add_test("JAL",4,6,encode_j_type(32,5),0,0,5,32,4); add_test("JALR",4,6,encode_i_type(4,1,0,5,'h67),28,0,5,32,4);
        add_test("FENCE",5,7,32'h0000000f,0,0,0,32'h13579bdf); add_test("ECALL",5,7,32'h00000073,0,0,0,32'h13579bdf);
        add_test("EBREAK",5,7,32'h00100073,0,0,0,32'h13579bdf);
        $display("[GEN] Generated %0d directed RV32I tests",generated_count);
    endtask
endclass
`endif
