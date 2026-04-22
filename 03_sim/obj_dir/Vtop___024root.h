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
        VL_IN8(hz_ctrl_i,0,0);
        CData/*0:0*/ top__DOT__clk_l;
        CData/*0:0*/ top__DOT__rstn_l;
        VL_IN8(write_rd_i,4,0);
        VL_IN8(reg_write_en_i,0,0);
        VL_OUT8(ctrl_branch_o,0,0);
        VL_OUT8(ctrl_mem_read_o,0,0);
        VL_OUT8(ctrl_mem_to_reg_o,0,0);
        VL_OUT8(ctrl_mem_write_o,0,0);
        VL_OUT8(ctrl_ALUsrc_o,0,0);
        VL_OUT8(ctrl_reg_write_o,0,0);
        VL_OUT8(ctrl_ALUOp_o,1,0);
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__ctrl_branch_r;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__ctrl_mem_read_r;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__ctrl_mem_to_reg_r;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__ctrl_mem_write_r;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__ctrl_ALUsrc_r;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__ctrl_reg_write_r;
        CData/*1:0*/ top__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__funct7_30_r;
        CData/*2:0*/ top__DOT__ID_stage_inst__DOT__funct3_r;
        CData/*4:0*/ top__DOT__ID_stage_inst__DOT__rs1_r;
        CData/*4:0*/ top__DOT__ID_stage_inst__DOT__rs2_r;
        CData/*4:0*/ top__DOT__ID_stage_inst__DOT__rd_r;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__8;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__7;
        CData/*1:0*/ top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d9647ad__2;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__6;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__5;
        CData/*1:0*/ top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d9647ad__1;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__4;
        CData/*1:0*/ top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d9647ad__0;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__3;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__2;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__1;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__0;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__branch_r;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_read_r;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_to_reg_r;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_write_r;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUsrc_r;
        CData/*0:0*/ top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__reg_write_r;
        CData/*1:0*/ top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r;
        CData/*0:0*/ __VstlFirstIteration;
        CData/*0:0*/ __VicoFirstIteration;
        CData/*0:0*/ __Vtrigprevexpr___TOP__clk_i__0;
        CData/*0:0*/ __Vtrigprevexpr___TOP__rstn_i__0;
        CData/*0:0*/ __Vtrigprevexpr___TOP__hz_ctrl_i__0;
        CData/*0:0*/ __Vtrigprevexpr___TOP__top__DOT__clk_l__0;
        CData/*0:0*/ __Vtrigprevexpr___TOP__top__DOT__rstn_l__0;
        CData/*0:0*/ __VactDidInit;
        CData/*0:0*/ __VactContinue;
        VL_IN(instruction_i,31,0);
        VL_IN(addr_current_i,31,0);
        VL_IN(write_back_data_i,31,0);
        VL_OUT(rd1_o,31,0);
        VL_OUT(rd2_o,31,0);
        VL_OUT(addr_current_o,31,0);
        VL_OUT(imm_gen_o,31,0);
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__addr_current_w;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__w_addr_branch;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__addr_next_w;
    };
    struct {
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__w_addr_plus4;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__addr_current_r;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__instruction_r;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__imm_gen_r;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__rd1_r;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__rd2_r;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r1_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r2_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r3_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r4_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r5_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r6_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r7_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r8_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r9_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r10_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r11_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r12_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r13_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r14_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r15_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r16_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r17_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r18_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r19_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r20_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r21_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r22_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r23_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r24_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r25_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r26_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r27_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r28_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r29_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r30_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r31_q;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__rs1_value_r;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__rs2_value_r;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT____Vxrand_h8d93fe75__0;
        IData/*31:0*/ top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r;
        IData/*31:0*/ __VactIterCount;
        VlUnpacked<CData/*0:0*/, 4> __Vm_traceActivity;
    };
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VicoTriggered;
    VlTriggerVec<3> __VactTriggered;
    VlTriggerVec<3> __VnbaTriggered;

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
