`timescale 1ns/1ps

`ifdef VERILATOR

// Verilator automatically defines VERILATOR.  This small wrapper is used by
// the C++ harness and keeps XSim-only class/program code out of Verilator.
module top(
    input logic clk_i,
    input logic rstn_i
);
    RISCV #(
        .IMEM_FILE ("../01_data_mem/IMEM.mem"),
        .DMEM_FILE ("../01_data_mem/DMEM.mem")
    ) dut(
        .clk_i  (clk_i),
        .rstn_i (rstn_i)
    );
endmodule

`endif
