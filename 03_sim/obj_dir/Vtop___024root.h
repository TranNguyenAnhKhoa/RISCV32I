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
    VL_IN8(clk_i,0,0);
    VL_IN8(rstn_i,0,0);
    VL_IN8(branch_i,0,0);
    VL_IN8(flush_i,0,0);
    VL_IN8(write_PC_en_i,0,0);
    CData/*0:0*/ __VstlFirstIteration;
    CData/*0:0*/ __VicoFirstIteration;
    CData/*0:0*/ __Vtrigprevexpr___TOP__clk_i__0;
    CData/*0:0*/ __VactContinue;
    VL_IN(addr_branch_i,31,0);
    VL_OUT(instruction_o,31,0);
    VL_OUT(addr_current_o,31,0);
    IData/*31:0*/ top__DOT__IF_stage_inst__DOT__addr_next_w;
    IData/*31:0*/ top__DOT__IF_stage_inst__DOT__addr_current_r;
    IData/*31:0*/ top__DOT__IF_stage_inst__DOT__instruction_r;
    IData/*31:0*/ top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r;
    IData/*31:0*/ __VactIterCount;
    VlUnpacked<CData/*7:0*/, 1024> top__DOT__IF_stage_inst__DOT__IMEM_inst0__DOT__imem;
    VlUnpacked<CData/*0:0*/, 2> __Vm_traceActivity;
    VlTriggerVec<1> __VstlTriggered;
    VlTriggerVec<1> __VicoTriggered;
    VlTriggerVec<1> __VactTriggered;
    VlTriggerVec<1> __VnbaTriggered;

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
