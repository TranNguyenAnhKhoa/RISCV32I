`ifndef RISCV32I_TEST_SV
`define RISCV32I_TEST_SV
program automatic RISCV32I_Test(RISCV32I_io testbench_interface);
    `include "RISCV32I_Packet.sv"
    `include "RISCV32I_Generator.sv"
    `include "RISCV32I_Driver.sv"
    `include "RISCV32I_Monitor.sv"
    `include "RISCV32I_Scoreboard.sv"

    localparam int NUMBER_OF_TESTS=40;
    riscv_packet_mbox generator_to_driver_mbox=new();
    riscv_packet_mbox driver_to_monitor_mbox=new();
    riscv_packet_mbox monitor_to_scoreboard_mbox=new();
    RISCV32I_Generator generator;
    RISCV32I_Driver driver;
    RISCV32I_Monitor monitor;
    RISCV32I_Scoreboard scoreboard;

    initial begin
        generator   = new(generator_to_driver_mbox);
        driver      = new(testbench_interface,generator_to_driver_mbox,driver_to_monitor_mbox);
        monitor     = new(driver_to_monitor_mbox,monitor_to_scoreboard_mbox);
        scoreboard  = new(monitor_to_scoreboard_mbox);
        fork
            generator.start();
            driver.start(NUMBER_OF_TESTS);
            monitor.start(NUMBER_OF_TESTS);
            scoreboard.start(NUMBER_OF_TESTS);
        join_none
        @scoreboard.done_event;
        if (scoreboard.fail_count != 0) begin
            $fatal(1, "[TEST] RV32I regression failed: %0d case(s)", scoreboard.fail_count);
        end
        $finish;
    end
endprogram
`endif
