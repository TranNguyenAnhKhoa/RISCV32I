// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "Vtop__pch.h"
#include "Vtop__Syms.h"
#include "Vtop___024root.h"

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__act(Vtop___024root* vlSelf);
#endif  // VL_DEBUG

void Vtop___024root___eval_triggers__act(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_triggers__act\n"); );
    // Body
    vlSelf->__VactTriggered.set(0U, (((IData)(vlSelf->clk_i) 
                                      & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__clk_i__0))) 
                                     | ((IData)(vlSelf->rstn_i) 
                                        != (IData)(vlSelf->__Vtrigprevexpr___TOP__rstn_i__0))));
    vlSelf->__VactTriggered.set(1U, ((((IData)(vlSelf->top__DOT__RISCV_inst__DOT__hz_flush_w) 
                                       != (IData)(vlSelf->__Vtrigprevexpr___TOP__top__DOT__RISCV_inst__DOT__hz_flush_w__0)) 
                                      | ((IData)(vlSelf->top__DOT__clk_l) 
                                         & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__top__DOT__clk_l__0)))) 
                                     | ((IData)(vlSelf->top__DOT__rstn_l) 
                                        != (IData)(vlSelf->__Vtrigprevexpr___TOP__top__DOT__rstn_l__0))));
    vlSelf->__VactTriggered.set(2U, (((IData)(vlSelf->top__DOT__clk_l) 
                                      & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__top__DOT__clk_l__0))) 
                                     | ((IData)(vlSelf->top__DOT__rstn_l) 
                                        != (IData)(vlSelf->__Vtrigprevexpr___TOP__top__DOT__rstn_l__0))));
    vlSelf->__VactTriggered.set(3U, ((((IData)(vlSelf->top__DOT__RISCV_inst__DOT__hz_ctrl_w) 
                                       != (IData)(vlSelf->__Vtrigprevexpr___TOP__top__DOT__RISCV_inst__DOT__hz_ctrl_w__0)) 
                                      | ((IData)(vlSelf->top__DOT__clk_l) 
                                         & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__top__DOT__clk_l__0)))) 
                                     | ((IData)(vlSelf->top__DOT__rstn_l) 
                                        != (IData)(vlSelf->__Vtrigprevexpr___TOP__top__DOT__rstn_l__0))));
    vlSelf->__VactTriggered.set(4U, (((IData)(vlSelf->top__DOT__clk_l) 
                                      & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__top__DOT__clk_l__0))) 
                                     | ((~ (IData)(vlSelf->top__DOT__rstn_l)) 
                                        & (IData)(vlSelf->__Vtrigprevexpr___TOP__top__DOT__rstn_l__0))));
    vlSelf->__VactTriggered.set(5U, ((IData)(vlSelf->top__DOT__clk_l) 
                                     & (~ (IData)(vlSelf->__Vtrigprevexpr___TOP__top__DOT__clk_l__0))));
    vlSelf->__Vtrigprevexpr___TOP__clk_i__0 = vlSelf->clk_i;
    vlSelf->__Vtrigprevexpr___TOP__rstn_i__0 = vlSelf->rstn_i;
    vlSelf->__Vtrigprevexpr___TOP__top__DOT__RISCV_inst__DOT__hz_flush_w__0 
        = vlSelf->top__DOT__RISCV_inst__DOT__hz_flush_w;
    vlSelf->__Vtrigprevexpr___TOP__top__DOT__clk_l__0 
        = vlSelf->top__DOT__clk_l;
    vlSelf->__Vtrigprevexpr___TOP__top__DOT__rstn_l__0 
        = vlSelf->top__DOT__rstn_l;
    vlSelf->__Vtrigprevexpr___TOP__top__DOT__RISCV_inst__DOT__hz_ctrl_w__0 
        = vlSelf->top__DOT__RISCV_inst__DOT__hz_ctrl_w;
    if (VL_UNLIKELY((1U & (~ (IData)(vlSelf->__VactDidInit))))) {
        vlSelf->__VactDidInit = 1U;
        vlSelf->__VactTriggered.set(0U, 1U);
        vlSelf->__VactTriggered.set(1U, 1U);
        vlSelf->__VactTriggered.set(2U, 1U);
        vlSelf->__VactTriggered.set(3U, 1U);
    }
#ifdef VL_DEBUG
    if (VL_UNLIKELY(vlSymsp->_vm_contextp__->debug())) {
        Vtop___024root___dump_triggers__act(vlSelf);
    }
#endif
}
