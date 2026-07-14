`ifndef RISCV32I_SCOREBOARD_SV
`define RISCV32I_SCOREBOARD_SV
class RISCV32I_Scoreboard;
    riscv_packet_mbox input_mbox;
    int pass_count=0, fail_count=0, group_count[0:7];
    event done_event;
    function new(
        input riscv_packet_mbox input_mbox_i
    );
        this.input_mbox=input_mbox_i;
    endfunction
    function void compare_packet(
        input RISCV32I_Packet packet
    );
        bit comparison_failed;
        comparison_failed=(packet.actual_value!==packet.expected_value);
        if (packet.test_kind==4)
            comparison_failed|=(packet.actual_aux_value!==packet.expected_aux_value);
        group_count[packet.test_group]++;
        if(comparison_failed) begin
            fail_count++;
            $display("[FAIL] %-8s exp=%08h/%08h got=%08h/%08h",
                packet.test_name,packet.expected_value,packet.expected_aux_value,
                packet.actual_value,packet.actual_aux_value);
        end else begin
            pass_count++;
            $display("[PASS] %-8s value=%08h",packet.test_name,packet.actual_value);
        end
    endfunction
    task start(
        input int number_of_tests
    );
        RISCV32I_Packet packet;
        repeat(number_of_tests) begin input_mbox.get(packet); compare_packet(packet); end
        $display("\n============================================================");
        $display("RV32I SUMMARY: PASS=%0d FAIL=%0d TOTAL=%0d",pass_count,fail_count,pass_count+fail_count);
        $display("R=%0d I=%0d U=%0d LOAD=%0d STORE=%0d BRANCH=%0d JUMP=%0d SYSTEM=%0d",
          group_count[0],group_count[1],group_count[2],group_count[3],group_count[4],group_count[5],group_count[6],group_count[7]);
        $display("============================================================\n");
        ->done_event;
    endtask
endclass
`endif
