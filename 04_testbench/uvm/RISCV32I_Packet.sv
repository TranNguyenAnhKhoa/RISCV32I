`ifndef RISCV32I_PACKET_SV
`define RISCV32I_PACKET_SV
class RISCV32I_Packet;
    string test_name;
    int test_kind, test_group, rd_index;
    logic [31:0] instruction;
    logic [31:0] rs1_value, rs2_value;
    logic [31:0] expected_value, expected_aux_value;
    logic [31:0] actual_value, actual_aux_value;

    function new(
        input string test_name_i=""
    );
        this.test_name=test_name_i;
    endfunction
    function RISCV32I_Packet copy();
        RISCV32I_Packet packet_copy=new(test_name);
        packet_copy.test_kind=test_kind; packet_copy.test_group=test_group;
        packet_copy.rd_index=rd_index; packet_copy.instruction=instruction;
        packet_copy.rs1_value=rs1_value; packet_copy.rs2_value=rs2_value;
        packet_copy.expected_value=expected_value;
        packet_copy.expected_aux_value=expected_aux_value;
        packet_copy.actual_value=actual_value;
        packet_copy.actual_aux_value=actual_aux_value;
        return packet_copy;
    endfunction
    function void display(
        input string prefix="PKT"
    );
        $display("[%s] %-10s insn=%08h expected=%08h actual=%08h",
                 prefix,test_name,instruction,expected_value,actual_value);
    endfunction
endclass
typedef mailbox #(RISCV32I_Packet) riscv_packet_mbox;
`endif
