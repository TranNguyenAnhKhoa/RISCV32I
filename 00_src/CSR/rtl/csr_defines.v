//--------------------------------------------------------------------
// File: csr_defines.v
// Module: RISC-V Control and Status Register Definitions
// Description: CSR addresses, operations, and exception causes
//              conforming to RISC-V Privileged Specification v1.12.
//--------------------------------------------------------------------

`ifndef CSR_DEFINES_V
`define CSR_DEFINES_V

//--------------------------------------------------------------------
// CSR Operations (funct3 encoding for SYSTEM instructions)
//--------------------------------------------------------------------
`define CSR_OP_NONE                3'b000
`define CSR_OP_CSRRW               3'b001
`define CSR_OP_CSRRS               3'b010
`define CSR_OP_CSRRC               3'b011
`define CSR_OP_CSRRWI              3'b101
`define CSR_OP_CSRRSI              3'b110
`define CSR_OP_CSRRCI              3'b111

//--------------------------------------------------------------------
// Machine Information Registers (Read-Only)
//--------------------------------------------------------------------
`define CSR_ADDR_MVENDORID         12'hF11
`define CSR_ADDR_MARCHID           12'hF12
`define CSR_ADDR_MIMPID            12'hF13
`define CSR_ADDR_MHARTID           12'hF14
`define CSR_ADDR_MCONFIGPTR        12'hF15

//--------------------------------------------------------------------
// Machine Trap Setup Registers
//--------------------------------------------------------------------
`define CSR_ADDR_MSTATUS           12'h300
`define CSR_ADDR_MISA              12'h301
`define CSR_ADDR_MEDELEG           12'h302
`define CSR_ADDR_MIDELEG           12'h303
`define CSR_ADDR_MIE               12'h304
`define CSR_ADDR_MTVEC             12'h305
`define CSR_ADDR_MCOUNTEREN        12'h306
`define CSR_ADDR_MSTATUSH          12'h310

//--------------------------------------------------------------------
// Machine Trap Handling Registers
//--------------------------------------------------------------------
`define CSR_ADDR_MSCRATCH          12'h340
`define CSR_ADDR_MEPC              12'h341
`define CSR_ADDR_MCAUSE            12'h342
`define CSR_ADDR_MTVAL             12'h343
`define CSR_ADDR_MIP               12'h344

//--------------------------------------------------------------------
// Machine Counter / Timer Registers
//--------------------------------------------------------------------
`define CSR_ADDR_MCYCLE            12'hB00
`define CSR_ADDR_MINSTRET          12'hB02
`define CSR_ADDR_MCYCLEH           12'hB80
`define CSR_ADDR_MINSTRETH         12'hB82

//--------------------------------------------------------------------
// User / Unprivileged Shadow Counters (Read-Only)
//--------------------------------------------------------------------
`define CSR_ADDR_CYCLE             12'hC00
`define CSR_ADDR_TIME              12'hC01
`define CSR_ADDR_INSTRET           12'hC02
`define CSR_ADDR_CYCLEH            12'hC80
`define CSR_ADDR_TIMEH             12'hC81
`define CSR_ADDR_INSTRETH          12'hC82

//--------------------------------------------------------------------
// mstatus Field Masks & Bit Positions
//--------------------------------------------------------------------
`define MSTATUS_UIE_BIT            0
`define MSTATUS_SIE_BIT            1
`define MSTATUS_MIE_BIT            3
`define MSTATUS_UPIE_BIT           4
`define MSTATUS_SPIE_BIT           5
`define MSTATUS_MPIE_BIT           7
`define MSTATUS_SPP_BIT            8
`define MSTATUS_MPP_OFFSET         11
`define MSTATUS_MPP_WIDTH          2

//--------------------------------------------------------------------
// mtvec Field Masks & Modes
//--------------------------------------------------------------------
`define MTVEC_MODE_DIRECT          2'b00
`define MTVEC_MODE_VECTORED        2'b01

//--------------------------------------------------------------------
// Interrupt & Exception Causes (mcause[30:0])
//--------------------------------------------------------------------
// Synchronous Exceptions (mcause[31] = 0)
`define EXC_MISALIGNED_FETCH       5'd0
`define EXC_FETCH_ACCESS_FAULT     5'd1
`define EXC_ILLEGAL_INSTRUCTION    5'd2
`define EXC_BREAKPOINT             5'd3
`define EXC_MISALIGNED_LOAD        5'd4
`define EXC_LOAD_ACCESS_FAULT      5'd5
`define EXC_MISALIGNED_STORE       5'd6
`define EXC_STORE_ACCESS_FAULT     5'd7
`define EXC_ECALL_U                5'd8
`define EXC_ECALL_S                5'd9
`define EXC_ECALL_M                5'd11
`define EXC_PAGE_FAULT_FETCH       5'd12
`define EXC_PAGE_FAULT_LOAD        5'd13
`define EXC_PAGE_FAULT_STORE       5'd15

// Asynchronous Interrupts (mcause[31] = 1)
`define IRQ_SOFTWARE_M             5'd3
`define IRQ_TIMER_M                5'd7
`define IRQ_EXTERNAL_M             5'd11

//--------------------------------------------------------------------
// mie / mip Bit Positions
//--------------------------------------------------------------------
`define MIE_MSIE_BIT               3
`define MIE_MTIE_BIT               7
`define MIE_MEIE_BIT               11

`define MIP_MSIP_BIT               3
`define MIP_MTIP_BIT               7
`define MIP_MEIP_BIT               11

`endif // CSR_DEFINES_V
