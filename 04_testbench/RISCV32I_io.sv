`ifndef RISCV32I_IO_SV
`define RISCV32I_IO_SV
interface RISCV32I_io(
    input bit clock_i
);
    logic reset_n;
    int test_kind, test_group, rd_index;
    string test_name;
    logic [31:0] instruction;
    logic [31:0] rs1_value, rs2_value;
    logic [31:0] expected_value, expected_aux_value;
    logic [31:0] actual_value, actual_aux_value;
    event request_event, complete_event;

    clocking driver_cb @(posedge clock_i);
        default input #1step;
        default output #0;
        input actual_value;
        input actual_aux_value;
        output reset_n;
    endclocking

    task automatic execute_test(
        input string test_name_i,
        input int test_kind_i,
        input int test_group_i,
        input int rd_index_i,
        input logic [31:0] instruction_i,
        input logic [31:0] rs1_value_i,
        input logic [31:0] rs2_value_i,
        input logic [31:0] expected_value_i,
        input logic [31:0] expected_aux_value_i,
        output logic [31:0] actual_value_o,
        output logic [31:0] actual_aux_value_o
    );
        test_name=test_name_i; test_kind=test_kind_i; test_group=test_group_i;
        rd_index=rd_index_i; instruction=instruction_i;
        rs1_value=rs1_value_i; rs2_value=rs2_value_i;
        expected_value=expected_value_i; expected_aux_value=expected_aux_value_i;
        ->request_event; @complete_event;
        actual_value_o=actual_value; actual_aux_value_o=actual_aux_value;
    endtask
endinterface
`endif
