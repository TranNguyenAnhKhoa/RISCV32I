// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design internal header
// See Vtop.h for the primary calling header

#ifndef VERILATED_VTOP___024ROOT_H_
#define VERILATED_VTOP___024ROOT_H_  // guard

#include "verilated.h"


class Vtop__Syms;

class alignas(VL_CACHE_LINE_BYTES) Vtop___024root final : public VerilatedModule {
  public:

    // DESIGN SPECIFIC STATE
    // Anonymous structures to workaround compiler member-count bugs
    struct {
        VL_IN8(clk_i,0,0);
        VL_IN8(rstn_i,0,0);
        CData/*0:0*/ top__DOT__clk_l;
        CData/*0:0*/ top__DOT__rstn_l;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__hz_flush_w;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__hz_ctrl_w;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__write_IDEX_w;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__write_PC_w;
        CData/*2:0*/ top__DOT__RISCV_inst__DOT__funct3_MEM_w;
        CData/*1:0*/ top__DOT__RISCV_inst__DOT__hz_ALU1_w;
        CData/*1:0*/ top__DOT__RISCV_inst__DOT__hz_ALU2_w;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_branch_r;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_read_r;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_to_reg_r;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_write_r;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_reg_write_r;
        CData/*1:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct7_30_r;
        CData/*2:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r;
        CData/*4:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rs1_r;
        CData/*4:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rs2_r;
        CData/*4:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__6;
        CData/*1:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d9647ad__2;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__5;
        CData/*1:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d9647ad__1;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__4;
        CData/*1:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d9647ad__0;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__3;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__2;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__1;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__0;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__branch_r;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_read_r;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_to_reg_r;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_write_r;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__reg_write_r;
        CData/*1:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_read_w;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_to_reg_w;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_write_w;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_reg_write_w;
        CData/*3:0*/ top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_read_r;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_to_reg_r;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_write_r;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_reg_write_r;
        CData/*2:0*/ top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__funct3_r;
        CData/*4:0*/ top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__comparator_inst0__DOT__slt_w;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ctrl_reg_write_w;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ctrl_mem_to_reg_w;
        CData/*4:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ctrl_reg_write_r;
        CData/*0:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ctrl_mem_to_reg_r;
        CData/*0:0*/ __VstlFirstIteration;
        CData/*0:0*/ __Vtrigprevexpr___TOP__clk_i__0;
        CData/*0:0*/ __Vtrigprevexpr___TOP__rstn_i__0;
        CData/*0:0*/ __Vtrigprevexpr___TOP__top__DOT__RISCV_inst__DOT__hz_flush_w__0;
        CData/*0:0*/ __Vtrigprevexpr___TOP__top__DOT__clk_l__0;
        CData/*0:0*/ __Vtrigprevexpr___TOP__top__DOT__rstn_l__0;
        CData/*0:0*/ __Vtrigprevexpr___TOP__top__DOT__RISCV_inst__DOT__hz_ctrl_w__0;
        CData/*0:0*/ __VactDidInit;
        CData/*0:0*/ __VactContinue;
    };
    struct {
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__addr_branch_MEM_w;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__data_WB_w;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__addr_next_w;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__addr_current_r;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__addr_current_w;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__w_addr_branch;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__addr_next_w;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__addr_current_r;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__instruction_r;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_r;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd2_r;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r1_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r2_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r3_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r4_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r5_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r6_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r7_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r8_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r9_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r10_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r11_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r12_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r13_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r14_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r15_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r16_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r17_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r18_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r19_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r20_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r21_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r22_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r23_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r24_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r25_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r26_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r27_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r28_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r29_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r30_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r31_q;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__rs1_value_r;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__rs2_value_r;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT____Vxrand_h8d93fe75__0;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_r;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ALUresult_r;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_data_r;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out0;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out1;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out2;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out3;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out4;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out5;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out6;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out7;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out8;
    };
    struct {
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out9;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out10;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out11;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out12;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out13;
        IData/*31:0*/ top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out15;
        IData/*31:0*/ __Vdly__top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r;
        IData/*31:0*/ __VactIterCount;
        VlUnpacked<CData/*7:0*/, 1024> top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__IMEM_inst0__DOT__imem;
        VlUnpacked<CData/*7:0*/, 64> top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0;
        VlUnpacked<CData/*7:0*/, 64> top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1;
        VlUnpacked<CData/*7:0*/, 64> top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2;
        VlUnpacked<CData/*7:0*/, 64> top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3;
        VlUnpacked<CData/*0:0*/, 7> __Vm_traceActivity;
    };
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<6> __VactTriggered;
    VlTriggerVec<6> __VnbaTriggered;

    // INTERNAL VARIABLES
    Vtop__Syms* const vlSymsp;

    // CONSTRUCTORS
    Vtop___024root(Vtop__Syms* symsp, const char* v__name);
    ~Vtop___024root();
    VL_UNCOPYABLE(Vtop___024root);

    // INTERNAL METHODS
    void __Vconfigure(bool first);
};


#endif  // guard
