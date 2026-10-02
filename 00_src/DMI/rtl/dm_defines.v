//--------------------------------------------------------------------
// File: dm_defines.v
// Module: RISC-V Debug Module Definitions (Spec v0.13.2)
// Description: Constants, DMI addresses, command types, and bitfields.
//--------------------------------------------------------------------

`ifndef DM_DEFINES_V
`define DM_DEFINES_V

//--------------------------------------------------------------------
// DMI Register Addresses (7-bit address space)
//--------------------------------------------------------------------
`define DM_ADDR_DATA0          7'h04
`define DM_ADDR_DATA1          7'h05
`define DM_ADDR_DMCONTROL      7'h10
`define DM_ADDR_DMSTATUS       7'h11
`define DM_ADDR_HARTINFO       7'h12
`define DM_ADDR_HALTSUM0       7'h13
`define DM_ADDR_HAWINDOWSEL    7'h14
`define DM_ADDR_HAWINDOW       7'h15
`define DM_ADDR_ABSTRACTCS     7'h16
`define DM_ADDR_COMMAND        7'h17
`define DM_ADDR_ABSTRACTAUTO   7'h18
`define DM_ADDR_CONFSTRPTR0    7'h19
`define DM_ADDR_NEXTDM         7'h1D
`define DM_ADDR_PROGBUF0       7'h20
`define DM_ADDR_AUTHDATA       7'h30
`define DM_ADDR_HALTSUM1       7'h34
`define DM_ADDR_SBCS           7'h38
`define DM_ADDR_HALTSUM0_ALIAS 7'h40

//--------------------------------------------------------------------
// DMI Operations (op[1:0])
//--------------------------------------------------------------------
`define DMI_OP_NOP             2'b00
`define DMI_OP_READ            2'b01
`define DMI_OP_WRITE           2'b10

//--------------------------------------------------------------------
// DMI Response Codes (resp[1:0])
//--------------------------------------------------------------------
`define DMI_RESP_SUCCESS        2'b00
`define DMI_RESP_FAILED         2'b01
`define DMI_RESP_BUSY           2'b10

//--------------------------------------------------------------------
// dmcontrol Bit Positions and Fields
//--------------------------------------------------------------------
`define DMCONTROL_DMACTIVE          0
`define DMCONTROL_NDMRESET          1
`define DMCONTROL_CLRRESETHALTREQ   26
`define DMCONTROL_SETRESETHALTREQ   27
`define DMCONTROL_HARTSELLO_OFFSET  16
`define DMCONTROL_HARTSELLO_WIDTH   10
`define DMCONTROL_RESUMEREQ         30
`define DMCONTROL_HALTREQ           31

//--------------------------------------------------------------------
// dmstatus Fields & Version
//--------------------------------------------------------------------
`define DMSTATUS_VERSION_0_13       4'h2

//--------------------------------------------------------------------
// abstractcs: Command Error Codes (cmderr[2:0])
//--------------------------------------------------------------------
`define CMDERR_NONE                 3'd0
`define CMDERR_BUSY                 3'd1
`define CMDERR_NOT_SUPPORTED        3'd2
`define CMDERR_EXCEPTION            3'd3
`define CMDERR_HALT_RESUME          3'd4
`define CMDERR_OTHER                3'd7

//--------------------------------------------------------------------
// command: Command Types (cmdtype[31:24])
//--------------------------------------------------------------------
`define CMDTYPE_ACCESS_REG          8'h00
`define CMDTYPE_QUICK_ACCESS        8'h01
`define CMDTYPE_ACCESS_MEM          8'h02

//--------------------------------------------------------------------
// command: Access Register Command Fields
//--------------------------------------------------------------------
`define AARSIZE_32                  3'd2
`define AARSIZE_64                  3'd3

//--------------------------------------------------------------------
// Register Numbers for Access Register Command (regno[15:0])
//--------------------------------------------------------------------
`define REGNO_GPR_BASE              16'h1000
`define REGNO_GPR_END               16'h101F
`define REGNO_CSR_DCSR              16'h07B0
`define REGNO_CSR_DPC               16'h07B1
`define REGNO_CSR_DSCRATCH0         16'h07B2
`define REGNO_CSR_DSCRATCH1         16'h07B3

//--------------------------------------------------------------------
// DCSR Cause Fields (dcsr.cause[8:6])
//--------------------------------------------------------------------
`define DCSR_CAUSE_EBREAK           3'd1
`define DCSR_CAUSE_TRIGGER          3'd2
`define DCSR_CAUSE_HALTREQ          3'd3
`define DCSR_CAUSE_STEP             3'd4
`define DCSR_CAUSE_RESETHALT        3'd5

`endif // DM_DEFINES_V
