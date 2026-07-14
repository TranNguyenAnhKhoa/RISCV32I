# Fully-associative L1 caches

This folder contains synthesizable blocking L1 instruction and data caches for a 32-bit RISC-V core.

## Modules

- `l1_icache_fa.v`: read-only, read-allocate instruction cache.
- `l1_dcache_fa.v`: write-back, write-allocate data cache with byte strobes and flush support.
- `cache_backing_memory.v`: behavioral word memory used by the testbench.
- `cache_l1_tb.v`: self-checking Verilog regression.

All RTL and testbench source files use Verilog-2001 syntax. Multi-word cache storage is flattened into one-dimensional memories, so no SystemVerilog unpacked multi-dimensional arrays are required.

Both caches are fully associative: every valid tag is compared with the requested line tag. An invalid line is selected first; when all lines are valid, replacement uses a deterministic round-robin pointer.

Default parameters are four cache lines and four 32-bit words per line. `LINE_COUNT` may be any positive value. `WORDS_PER_LINE` must be a power of two.

## CPU protocol

The requester asserts `cpu_request_valid_i` together with the request fields and holds them until `cpu_request_ready_o` is high on a rising clock edge. The cache later pulses `cpu_response_valid_o` for one cycle. These are blocking caches and accept only one outstanding CPU request.

The D-cache accepts a raw aligned 32-bit word plus `cpu_write_strobe_i[3:0]`. The core adapter must place byte/halfword store data in the selected byte lanes. Loads return the raw 32-bit word; LB/LBU/LH/LHU extraction and sign extension should be performed in the core-side adapter.

## Backing-memory protocol

`memory_request_valid_o` and all request fields remain stable until `memory_request_ready_i` is sampled high. A write is complete at that handshake. A read returns later with `memory_response_valid_i` and `memory_read_data_i`.

## Integration warning

The current `IF_stage` and `MEM_stage` in this repository have no cache-miss handshake. When integrating these caches, stall PC and all affected pipeline registers from request acceptance until `cpu_response_valid_o`. Do not replace the asynchronous IMEM/DMEM directly without adding that stall path.

Use `invalidate_i` on the I-cache for `FENCE.I`. Use `flush_i` on the D-cache before shutdown, DMA handoff, or any operation that requires dirty data to reach backing memory.

## Vivado XSim

From this directory:

```text
xvlog -f cache_filelist.f
xelab cache_l1_tb -s cache_l1_tb_sim --debug typical --timescale 1ns/1ps
xsim cache_l1_tb_sim -runall
```

## Verilator

```text
verilator --binary --timing --trace -Wall -Wno-fatal \
  l1_icache_fa.v l1_dcache_fa.v cache_backing_memory.v cache_l1_tb.v \
  --top-module cache_l1_tb
```
