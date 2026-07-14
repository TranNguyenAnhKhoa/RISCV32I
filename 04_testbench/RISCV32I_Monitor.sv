`ifndef RISCV32I_MONITOR_SV
`define RISCV32I_MONITOR_SV
class RISCV32I_Monitor;
    riscv_packet_mbox input_mbox, output_mbox;
    function new(
        input riscv_packet_mbox input_mbox_i,
        input riscv_packet_mbox output_mbox_i
    );
        this.input_mbox=input_mbox_i; this.output_mbox=output_mbox_i;
    endfunction
    task start(
        input int number_of_tests
    );
        RISCV32I_Packet packet;
        repeat(number_of_tests) begin
            input_mbox.get(packet); packet.display("MON");
            output_mbox.put(packet.copy());
        end
    endtask
endclass
`endif
