`ifndef RISCV32I_DRIVER_SV
`define RISCV32I_DRIVER_SV
class RISCV32I_Driver;
    virtual RISCV32I_io virtual_interface;
    riscv_packet_mbox input_mbox, output_mbox;
    function new(
        input virtual RISCV32I_io virtual_interface_i,
        input riscv_packet_mbox input_mbox_i,
        input riscv_packet_mbox output_mbox_i
    );
        this.virtual_interface=virtual_interface_i;
        this.input_mbox=input_mbox_i; this.output_mbox=output_mbox_i;
    endfunction
    task start(
        input int number_of_tests
    );
        RISCV32I_Packet packet;
        repeat(number_of_tests) begin
            input_mbox.get(packet);
            virtual_interface.execute_test(
                packet.test_name,packet.test_kind,packet.test_group,
                packet.rd_index,packet.instruction,packet.rs1_value,
                packet.rs2_value,packet.expected_value,
                packet.expected_aux_value,packet.actual_value,
                packet.actual_aux_value);
            output_mbox.put(packet.copy());
        end
    endtask
endclass
`endif
