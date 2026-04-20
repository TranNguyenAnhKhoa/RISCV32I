// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "Vtop__pch.h"
#include "Vtop___024root.h"

VL_INLINE_OPT void Vtop___024root___ico_sequent__TOP__0(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___ico_sequent__TOP__0\n"); );
    // Body
    if (vlSelf->flush_i) {
        vlSelf->instruction_o = 0U;
        vlSelf->addr_current_o = 0U;
    } else {
        vlSelf->instruction_o = vlSelf->top__DOT__IF_stage_inst__DOT__instruction_r;
        vlSelf->addr_current_o = vlSelf->top__DOT__IF_stage_inst__DOT__addr_current_r;
    }
    vlSelf->top__DOT__IF_stage_inst__DOT__addr_next_w 
        = ((IData)(vlSelf->branch_i) ? vlSelf->addr_branch_i
            : ((IData)(4U) + vlSelf->top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r));
}

void Vtop___024root___eval_ico(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_ico\n"); );
    // Body
    if ((1ULL & vlSelf->__VicoTriggered.word(0U))) {
        Vtop___024root___ico_sequent__TOP__0(vlSelf);
    }
}

void Vtop___024root___eval_triggers__ico(Vtop___024root* vlSelf);

bool Vtop___024root___eval_phase__ico(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_phase__ico\n"); );
    // Init
    CData/*0:0*/ __VicoExecute;
    // Body
    Vtop___024root___eval_triggers__ico(vlSelf);
    __VicoExecute = vlSelf->__VicoTriggered.any();
    if (__VicoExecute) {
        Vtop___024root___eval_ico(vlSelf);
    }
    return (__VicoExecute);
}

void Vtop___024root___eval_act(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_act\n"); );
}

VL_INLINE_OPT void Vtop___024root___nba_sequent__TOP__0(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___nba_sequent__TOP__0\n"); );
    // Init
    IData/*31:0*/ __Vdly__top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r;
    __Vdly__top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r = 0;
    // Body
    __Vdly__top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r 
        = vlSelf->top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r;
    if (vlSelf->rstn_i) {
        __Vdly__top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r 
            = ((IData)(vlSelf->write_PC_en_i) ? vlSelf->top__DOT__IF_stage_inst__DOT__addr_next_w
                : vlSelf->top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r);
        vlSelf->top__DOT__IF_stage_inst__DOT__addr_current_r 
            = vlSelf->top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r;
        vlSelf->top__DOT__IF_stage_inst__DOT__instruction_r 
            = ((vlSelf->top__DOT__IF_stage_inst__DOT__IMEM_inst0__DOT__imem
                [(0x3ffU & vlSelf->top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r)] 
                << 0x18U) | ((vlSelf->top__DOT__IF_stage_inst__DOT__IMEM_inst0__DOT__imem
                              [(0x3ffU & ((IData)(1U) 
                                          + vlSelf->top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r))] 
                              << 0x10U) | ((vlSelf->top__DOT__IF_stage_inst__DOT__IMEM_inst0__DOT__imem
                                            [(0x3ffU 
                                              & ((IData)(2U) 
                                                 + vlSelf->top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r))] 
                                            << 8U) 
                                           | vlSelf->top__DOT__IF_stage_inst__DOT__IMEM_inst0__DOT__imem
                                           [(0x3ffU 
                                             & ((IData)(3U) 
                                                + vlSelf->top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r))])));
    } else {
        __Vdly__top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r = 0U;
        vlSelf->top__DOT__IF_stage_inst__DOT__addr_current_r = 0U;
        vlSelf->top__DOT__IF_stage_inst__DOT__instruction_r = 0U;
    }
    vlSelf->top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r 
        = __Vdly__top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r;
    if (vlSelf->flush_i) {
        vlSelf->addr_current_o = 0U;
        vlSelf->instruction_o = 0U;
    } else {
        vlSelf->addr_current_o = vlSelf->top__DOT__IF_stage_inst__DOT__addr_current_r;
        vlSelf->instruction_o = vlSelf->top__DOT__IF_stage_inst__DOT__instruction_r;
    }
    vlSelf->top__DOT__IF_stage_inst__DOT__addr_next_w 
        = ((IData)(vlSelf->branch_i) ? vlSelf->addr_branch_i
            : ((IData)(4U) + vlSelf->top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r));
}

void Vtop___024root___eval_nba(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_nba\n"); );
    // Body
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtop___024root___nba_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
    }
}

void Vtop___024root___eval_triggers__act(Vtop___024root* vlSelf);

bool Vtop___024root___eval_phase__act(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_phase__act\n"); );
    // Init
    VlTriggerVec<1> __VpreTriggered;
    CData/*0:0*/ __VactExecute;
    // Body
    Vtop___024root___eval_triggers__act(vlSelf);
    __VactExecute = vlSelf->__VactTriggered.any();
    if (__VactExecute) {
        __VpreTriggered.andNot(vlSelf->__VactTriggered, vlSelf->__VnbaTriggered);
        vlSelf->__VnbaTriggered.thisOr(vlSelf->__VactTriggered);
        Vtop___024root___eval_act(vlSelf);
    }
    return (__VactExecute);
}

bool Vtop___024root___eval_phase__nba(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_phase__nba\n"); );
    // Init
    CData/*0:0*/ __VnbaExecute;
    // Body
    __VnbaExecute = vlSelf->__VnbaTriggered.any();
    if (__VnbaExecute) {
        Vtop___024root___eval_nba(vlSelf);
        vlSelf->__VnbaTriggered.clear();
    }
    return (__VnbaExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__ico(Vtop___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__nba(Vtop___024root* vlSelf);
#endif  // VL_DEBUG
#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__act(Vtop___024root* vlSelf);
#endif  // VL_DEBUG

void Vtop___024root___eval(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval\n"); );
    // Init
    IData/*31:0*/ __VicoIterCount;
    CData/*0:0*/ __VicoContinue;
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
    __VicoIterCount = 0U;
    vlSelf->__VicoFirstIteration = 1U;
    __VicoContinue = 1U;
    while (__VicoContinue) {
        if (VL_UNLIKELY((0x64U < __VicoIterCount))) {
#ifdef VL_DEBUG
            Vtop___024root___dump_triggers__ico(vlSelf);
#endif
            VL_FATAL_MT("../04_testbench/top.sv", 1, "", "Input combinational region did not converge.");
        }
        __VicoIterCount = ((IData)(1U) + __VicoIterCount);
        __VicoContinue = 0U;
        if (Vtop___024root___eval_phase__ico(vlSelf)) {
            __VicoContinue = 1U;
        }
        vlSelf->__VicoFirstIteration = 0U;
    }
    __VnbaIterCount = 0U;
    __VnbaContinue = 1U;
    while (__VnbaContinue) {
        if (VL_UNLIKELY((0x64U < __VnbaIterCount))) {
#ifdef VL_DEBUG
            Vtop___024root___dump_triggers__nba(vlSelf);
#endif
            VL_FATAL_MT("../04_testbench/top.sv", 1, "", "NBA region did not converge.");
        }
        __VnbaIterCount = ((IData)(1U) + __VnbaIterCount);
        __VnbaContinue = 0U;
        vlSelf->__VactIterCount = 0U;
        vlSelf->__VactContinue = 1U;
        while (vlSelf->__VactContinue) {
            if (VL_UNLIKELY((0x64U < vlSelf->__VactIterCount))) {
#ifdef VL_DEBUG
                Vtop___024root___dump_triggers__act(vlSelf);
#endif
                VL_FATAL_MT("../04_testbench/top.sv", 1, "", "Active region did not converge.");
            }
            vlSelf->__VactIterCount = ((IData)(1U) 
                                       + vlSelf->__VactIterCount);
            vlSelf->__VactContinue = 0U;
            if (Vtop___024root___eval_phase__act(vlSelf)) {
                vlSelf->__VactContinue = 1U;
            }
        }
        if (Vtop___024root___eval_phase__nba(vlSelf)) {
            __VnbaContinue = 1U;
        }
    }
}

#ifdef VL_DEBUG
void Vtop___024root___eval_debug_assertions(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((vlSelf->clk_i & 0xfeU))) {
        Verilated::overWidthError("clk_i");}
    if (VL_UNLIKELY((vlSelf->rstn_i & 0xfeU))) {
        Verilated::overWidthError("rstn_i");}
    if (VL_UNLIKELY((vlSelf->branch_i & 0xfeU))) {
        Verilated::overWidthError("branch_i");}
    if (VL_UNLIKELY((vlSelf->flush_i & 0xfeU))) {
        Verilated::overWidthError("flush_i");}
    if (VL_UNLIKELY((vlSelf->write_PC_en_i & 0xfeU))) {
        Verilated::overWidthError("write_PC_en_i");}
}
#endif  // VL_DEBUG
