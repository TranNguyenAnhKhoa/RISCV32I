// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "Vtop__pch.h"
#include "Vtop___024root.h"

VL_ATTR_COLD void Vtop___024root___eval_static(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_static\n"); );
}

VL_ATTR_COLD void Vtop___024root___eval_initial__TOP(Vtop___024root* vlSelf);

VL_ATTR_COLD void Vtop___024root___eval_initial(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_initial\n"); );
    // Body
    Vtop___024root___eval_initial__TOP(vlSelf);
    vlSelf->__Vtrigprevexpr___TOP__clk_i__0 = vlSelf->clk_i;
    vlSelf->__Vtrigprevexpr___TOP__rstn_i__0 = vlSelf->rstn_i;
    vlSelf->__Vtrigprevexpr___TOP__hz_ctrl_i__0 = vlSelf->hz_ctrl_i;
    vlSelf->__Vtrigprevexpr___TOP__top__DOT__clk_l__0 
        = vlSelf->top__DOT__clk_l;
    vlSelf->__Vtrigprevexpr___TOP__top__DOT__rstn_l__0 
        = vlSelf->top__DOT__rstn_l;
}

VL_ATTR_COLD void Vtop___024root___eval_initial__TOP(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_initial__TOP\n"); );
    // Body
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__8 
        = (1U & VL_RAND_RESET_I(1));
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__7 
        = (1U & VL_RAND_RESET_I(1));
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d9647ad__2 
        = (3U & VL_RAND_RESET_I(2));
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__6 
        = (1U & VL_RAND_RESET_I(1));
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__5 
        = (1U & VL_RAND_RESET_I(1));
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d9647ad__1 
        = (3U & VL_RAND_RESET_I(2));
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__4 
        = (1U & VL_RAND_RESET_I(1));
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d9647ad__0 
        = (3U & VL_RAND_RESET_I(2));
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__3 
        = (1U & VL_RAND_RESET_I(1));
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__2 
        = (1U & VL_RAND_RESET_I(1));
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__1 
        = (1U & VL_RAND_RESET_I(1));
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__0 
        = (1U & VL_RAND_RESET_I(1));
    vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT____Vxrand_h8d93fe75__0 
        = VL_RAND_RESET_I(32);
}

VL_ATTR_COLD void Vtop___024root___eval_final(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_final\n"); );
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__stl(Vtop___024root* vlSelf);
#endif  // VL_DEBUG
VL_ATTR_COLD bool Vtop___024root___eval_phase__stl(Vtop___024root* vlSelf);

VL_ATTR_COLD void Vtop___024root___eval_settle(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_settle\n"); );
    // Init
    IData/*31:0*/ __VstlIterCount;
    CData/*0:0*/ __VstlContinue;
    // Body
    __VstlIterCount = 0U;
    vlSelf->__VstlFirstIteration = 1U;
    __VstlContinue = 1U;
    while (__VstlContinue) {
        if (VL_UNLIKELY((0x64U < __VstlIterCount))) {
#ifdef VL_DEBUG
            Vtop___024root___dump_triggers__stl(vlSelf);
#endif
            VL_FATAL_MT("../04_testbench/top.sv", 1, "", "Settle region did not converge.");
        }
        __VstlIterCount = ((IData)(1U) + __VstlIterCount);
        __VstlContinue = 0U;
        if (Vtop___024root___eval_phase__stl(vlSelf)) {
            __VstlContinue = 1U;
        }
        vlSelf->__VstlFirstIteration = 0U;
    }
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__stl(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___dump_triggers__stl\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VstlTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        VL_DBG_MSGF("         'stl' region trigger index 0 is active: Internal 'stl' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vtop___024root___stl_sequent__TOP__0(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___stl_sequent__TOP__0\n"); );
    // Body
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_read_r 
        = ((1U & (~ (vlSelf->instruction_i >> 6U))) 
           && ((1U & (~ (vlSelf->instruction_i >> 5U))) 
               && ((1U & (~ (vlSelf->instruction_i 
                             >> 4U))) && ((1U & (~ 
                                                 (vlSelf->instruction_i 
                                                  >> 3U))) 
                                          && ((1U & 
                                               (~ (vlSelf->instruction_i 
                                                   >> 2U))) 
                                              && ((1U 
                                                   & (vlSelf->instruction_i 
                                                      >> 1U)) 
                                                  && (1U 
                                                      & vlSelf->instruction_i)))))));
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_write_r 
        = ((1U & (~ (vlSelf->instruction_i >> 6U))) 
           && ((1U & (vlSelf->instruction_i >> 5U)) 
               && ((1U & (~ (vlSelf->instruction_i 
                             >> 4U))) && ((1U & (~ 
                                                 (vlSelf->instruction_i 
                                                  >> 3U))) 
                                          && ((1U & 
                                               (~ (vlSelf->instruction_i 
                                                   >> 2U))) 
                                              && ((1U 
                                                   & (vlSelf->instruction_i 
                                                      >> 1U)) 
                                                  && (1U 
                                                      & vlSelf->instruction_i)))))));
    if ((0x40U & vlSelf->instruction_i)) {
        vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__reg_write_r 
            = ((1U & (vlSelf->instruction_i >> 5U)) 
               && ((1U & (~ (vlSelf->instruction_i 
                             >> 4U))) && ((8U & vlSelf->instruction_i)
                                           ? ((1U & 
                                               (vlSelf->instruction_i 
                                                >> 2U)) 
                                              && ((1U 
                                                   & (vlSelf->instruction_i 
                                                      >> 1U)) 
                                                  && (1U 
                                                      & vlSelf->instruction_i)))
                                           : ((1U & 
                                               (vlSelf->instruction_i 
                                                >> 2U)) 
                                              && ((1U 
                                                   & (vlSelf->instruction_i 
                                                      >> 1U)) 
                                                  && (1U 
                                                      & vlSelf->instruction_i))))));
        if ((0x20U & vlSelf->instruction_i)) {
            if ((0x10U & vlSelf->instruction_i)) {
                vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = 0U;
                vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = 0U;
            } else if ((8U & vlSelf->instruction_i)) {
                if ((4U & vlSelf->instruction_i)) {
                    vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r 
                        = (((- (IData)((vlSelf->instruction_i 
                                        >> 0x1fU))) 
                            << 0x15U) | ((0x100000U 
                                          & (vlSelf->instruction_i 
                                             >> 0xbU)) 
                                         | ((0xff000U 
                                             & vlSelf->instruction_i) 
                                            | ((0x800U 
                                                & (vlSelf->instruction_i 
                                                   >> 9U)) 
                                               | (0x7feU 
                                                  & (vlSelf->instruction_i 
                                                     >> 0x14U))))));
                    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r 
                        = ((2U & vlSelf->instruction_i)
                            ? ((1U & vlSelf->instruction_i)
                                ? (IData)(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d9647ad__0)
                                : 0U) : 0U);
                } else {
                    vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = 0U;
                    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = 0U;
                }
            } else if ((4U & vlSelf->instruction_i)) {
                vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r 
                    = (((- (IData)((vlSelf->instruction_i 
                                    >> 0x1fU))) << 0xcU) 
                       | (vlSelf->instruction_i >> 0x14U));
                vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r 
                    = ((2U & vlSelf->instruction_i)
                        ? ((1U & vlSelf->instruction_i)
                            ? (IData)(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d9647ad__1)
                            : 0U) : 0U);
            } else {
                vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r 
                    = (((- (IData)((vlSelf->instruction_i 
                                    >> 0x1fU))) << 0xcU) 
                       | ((0x800U & (vlSelf->instruction_i 
                                     << 4U)) | ((0x7e0U 
                                                 & (vlSelf->instruction_i 
                                                    >> 0x14U)) 
                                                | (0x1eU 
                                                   & (vlSelf->instruction_i 
                                                      >> 7U)))));
                vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r 
                    = ((2U & vlSelf->instruction_i)
                        ? ((1U & vlSelf->instruction_i)
                            ? 2U : 0U) : 0U);
            }
        } else {
            vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = 0U;
            vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = 0U;
        }
        vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUsrc_r 
            = ((1U & (vlSelf->instruction_i >> 5U)) 
               && ((1U & (~ (vlSelf->instruction_i 
                             >> 4U))) && ((1U & (~ 
                                                 (vlSelf->instruction_i 
                                                  >> 3U))) 
                                          && ((1U & 
                                               (vlSelf->instruction_i 
                                                >> 2U)) 
                                              && ((1U 
                                                   & (vlSelf->instruction_i 
                                                      >> 1U)) 
                                                  && ((1U 
                                                       & vlSelf->instruction_i) 
                                                      && (IData)(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__5)))))));
        vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__branch_r 
            = ((1U & (vlSelf->instruction_i >> 5U)) 
               && ((1U & (~ (vlSelf->instruction_i 
                             >> 4U))) && ((8U & vlSelf->instruction_i)
                                           ? ((1U & 
                                               (vlSelf->instruction_i 
                                                >> 2U)) 
                                              && ((1U 
                                                   & (vlSelf->instruction_i 
                                                      >> 1U)) 
                                                  && (1U 
                                                      & vlSelf->instruction_i)))
                                           : ((4U & vlSelf->instruction_i)
                                               ? ((1U 
                                                   & (vlSelf->instruction_i 
                                                      >> 1U)) 
                                                  && (1U 
                                                      & vlSelf->instruction_i))
                                               : ((1U 
                                                   & (vlSelf->instruction_i 
                                                      >> 1U)) 
                                                  && ((1U 
                                                       & vlSelf->instruction_i) 
                                                      && (IData)(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__3)))))));
        vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_to_reg_r 
            = ((1U & (vlSelf->instruction_i >> 5U)) 
               && ((1U & (~ (vlSelf->instruction_i 
                             >> 4U))) && ((8U & vlSelf->instruction_i)
                                           ? ((1U & 
                                               (vlSelf->instruction_i 
                                                >> 2U)) 
                                              && ((1U 
                                                   & (vlSelf->instruction_i 
                                                      >> 1U)) 
                                                  && ((1U 
                                                       & vlSelf->instruction_i) 
                                                      && (IData)(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__4))))
                                           : ((4U & vlSelf->instruction_i)
                                               ? ((1U 
                                                   & (vlSelf->instruction_i 
                                                      >> 1U)) 
                                                  && ((1U 
                                                       & vlSelf->instruction_i) 
                                                      && (IData)(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__6)))
                                               : ((1U 
                                                   & (vlSelf->instruction_i 
                                                      >> 1U)) 
                                                  && ((1U 
                                                       & vlSelf->instruction_i) 
                                                      && (IData)(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__2)))))));
    } else if ((0x20U & vlSelf->instruction_i)) {
        vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__reg_write_r 
            = ((1U & (vlSelf->instruction_i >> 4U)) 
               && ((1U & (~ (vlSelf->instruction_i 
                             >> 3U))) && ((4U & vlSelf->instruction_i)
                                           ? ((1U & 
                                               (vlSelf->instruction_i 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->instruction_i))
                                           : ((1U & 
                                               (vlSelf->instruction_i 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->instruction_i)))));
        if ((0x10U & vlSelf->instruction_i)) {
            if ((8U & vlSelf->instruction_i)) {
                vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = 0U;
                vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = 0U;
            } else if ((4U & vlSelf->instruction_i)) {
                vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r 
                    = (0xfffff000U & vlSelf->instruction_i);
                vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r 
                    = ((2U & vlSelf->instruction_i)
                        ? ((1U & vlSelf->instruction_i)
                            ? 3U : 0U) : 0U);
            } else {
                vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r 
                    = vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT____Vxrand_h8d93fe75__0;
                vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = 0U;
            }
            vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUsrc_r 
                = ((1U & (~ (vlSelf->instruction_i 
                             >> 3U))) && ((1U & (vlSelf->instruction_i 
                                                 >> 2U)) 
                                          && ((1U & 
                                               (vlSelf->instruction_i 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->instruction_i))));
        } else {
            if ((8U & vlSelf->instruction_i)) {
                vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = 0U;
                vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = 0U;
            } else if ((4U & vlSelf->instruction_i)) {
                vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = 0U;
                vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = 0U;
            } else {
                vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r 
                    = (((- (IData)((vlSelf->instruction_i 
                                    >> 0x1fU))) << 0xcU) 
                       | ((0xfe0U & (vlSelf->instruction_i 
                                     >> 0x14U)) | (0x1fU 
                                                   & (vlSelf->instruction_i 
                                                      >> 7U))));
                vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r 
                    = ((2U & vlSelf->instruction_i)
                        ? ((1U & vlSelf->instruction_i)
                            ? 1U : 0U) : 0U);
            }
            vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUsrc_r 
                = ((1U & (~ (vlSelf->instruction_i 
                             >> 3U))) && ((1U & (~ 
                                                 (vlSelf->instruction_i 
                                                  >> 2U))) 
                                          && ((1U & 
                                               (vlSelf->instruction_i 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->instruction_i))));
        }
        vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__branch_r 
            = ((1U & (~ (vlSelf->instruction_i >> 4U))) 
               && ((1U & (~ (vlSelf->instruction_i 
                             >> 3U))) && ((1U & (~ 
                                                 (vlSelf->instruction_i 
                                                  >> 2U))) 
                                          && ((1U & 
                                               (vlSelf->instruction_i 
                                                >> 1U)) 
                                              && ((1U 
                                                   & vlSelf->instruction_i) 
                                                  && (IData)(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__1))))));
        vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_to_reg_r 
            = ((1U & (~ (vlSelf->instruction_i >> 4U))) 
               && ((1U & (~ (vlSelf->instruction_i 
                             >> 3U))) && ((1U & (~ 
                                                 (vlSelf->instruction_i 
                                                  >> 2U))) 
                                          && ((1U & 
                                               (vlSelf->instruction_i 
                                                >> 1U)) 
                                              && ((1U 
                                                   & vlSelf->instruction_i) 
                                                  && (IData)(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__0))))));
    } else {
        if ((0x10U & vlSelf->instruction_i)) {
            vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__reg_write_r 
                = ((1U & (~ (vlSelf->instruction_i 
                             >> 3U))) && ((4U & vlSelf->instruction_i)
                                           ? ((1U & 
                                               (vlSelf->instruction_i 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->instruction_i))
                                           : ((1U & 
                                               (vlSelf->instruction_i 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->instruction_i))));
            if ((8U & vlSelf->instruction_i)) {
                vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = 0U;
                vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = 0U;
            } else if ((4U & vlSelf->instruction_i)) {
                vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = 0U;
                vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r 
                    = ((2U & vlSelf->instruction_i)
                        ? ((1U & vlSelf->instruction_i)
                            ? (IData)(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d9647ad__2)
                            : 0U) : 0U);
            } else {
                vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r 
                    = (((- (IData)((vlSelf->instruction_i 
                                    >> 0x1fU))) << 0xcU) 
                       | (vlSelf->instruction_i >> 0x14U));
                vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r 
                    = ((2U & vlSelf->instruction_i)
                        ? ((1U & vlSelf->instruction_i)
                            ? 2U : 0U) : 0U);
            }
            vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUsrc_r 
                = ((1U & (~ (vlSelf->instruction_i 
                             >> 3U))) && ((4U & vlSelf->instruction_i)
                                           ? ((1U & 
                                               (vlSelf->instruction_i 
                                                >> 1U)) 
                                              && ((1U 
                                                   & vlSelf->instruction_i) 
                                                  && (IData)(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__7)))
                                           : ((1U & 
                                               (vlSelf->instruction_i 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->instruction_i))));
            vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_to_reg_r 
                = ((1U & (~ (vlSelf->instruction_i 
                             >> 3U))) && ((1U & (vlSelf->instruction_i 
                                                 >> 2U)) 
                                          && ((1U & 
                                               (vlSelf->instruction_i 
                                                >> 1U)) 
                                              && ((1U 
                                                   & vlSelf->instruction_i) 
                                                  && (IData)(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__8)))));
        } else {
            vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__reg_write_r 
                = ((1U & (~ (vlSelf->instruction_i 
                             >> 3U))) && ((1U & (~ 
                                                 (vlSelf->instruction_i 
                                                  >> 2U))) 
                                          && ((1U & 
                                               (vlSelf->instruction_i 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->instruction_i))));
            if ((8U & vlSelf->instruction_i)) {
                vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = 0U;
                vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = 0U;
            } else if ((4U & vlSelf->instruction_i)) {
                vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = 0U;
                vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = 0U;
            } else {
                vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r 
                    = (((- (IData)((vlSelf->instruction_i 
                                    >> 0x1fU))) << 0xcU) 
                       | (vlSelf->instruction_i >> 0x14U));
                vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r 
                    = ((2U & vlSelf->instruction_i)
                        ? ((1U & vlSelf->instruction_i)
                            ? 1U : 0U) : 0U);
            }
            vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUsrc_r 
                = ((1U & (~ (vlSelf->instruction_i 
                             >> 3U))) && ((1U & (~ 
                                                 (vlSelf->instruction_i 
                                                  >> 2U))) 
                                          && ((1U & 
                                               (vlSelf->instruction_i 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->instruction_i))));
            vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_to_reg_r 
                = ((1U & (~ (vlSelf->instruction_i 
                             >> 3U))) && ((1U & (~ 
                                                 (vlSelf->instruction_i 
                                                  >> 2U))) 
                                          && ((1U & 
                                               (vlSelf->instruction_i 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->instruction_i))));
        }
        vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__branch_r 
            = ((1U & (vlSelf->instruction_i >> 4U)) 
               && ((1U & (~ (vlSelf->instruction_i 
                             >> 3U))) && ((1U & (vlSelf->instruction_i 
                                                 >> 2U)) 
                                          && ((1U & 
                                               (vlSelf->instruction_i 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->instruction_i)))));
    }
    vlSelf->ctrl_branch_o = vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_branch_r;
    vlSelf->ctrl_mem_read_o = vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_mem_read_r;
    vlSelf->ctrl_mem_to_reg_o = vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_mem_to_reg_r;
    vlSelf->ctrl_mem_write_o = vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_mem_write_r;
    vlSelf->ctrl_ALUsrc_o = vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_ALUsrc_r;
    vlSelf->ctrl_reg_write_o = vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_reg_write_r;
    vlSelf->ctrl_ALUOp_o = vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r;
    vlSelf->rd1_o = vlSelf->top__DOT__ID_stage_inst__DOT__rd1_r;
    vlSelf->rd2_o = vlSelf->top__DOT__ID_stage_inst__DOT__rd2_r;
    vlSelf->addr_current_o = vlSelf->top__DOT__ID_stage_inst__DOT__addr_current_r;
    vlSelf->imm_gen_o = vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_r;
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__rs1_value_r 
        = ((0x80000U & vlSelf->instruction_i) ? ((0x40000U 
                                                  & vlSelf->instruction_i)
                                                  ? 
                                                 ((0x20000U 
                                                   & vlSelf->instruction_i)
                                                   ? 
                                                  ((0x10000U 
                                                    & vlSelf->instruction_i)
                                                    ? 
                                                   ((0x8000U 
                                                     & vlSelf->instruction_i)
                                                     ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r31_q
                                                     : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r30_q)
                                                    : 
                                                   ((0x8000U 
                                                     & vlSelf->instruction_i)
                                                     ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r29_q
                                                     : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r28_q))
                                                   : 
                                                  ((0x10000U 
                                                    & vlSelf->instruction_i)
                                                    ? 
                                                   ((0x8000U 
                                                     & vlSelf->instruction_i)
                                                     ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r27_q
                                                     : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r26_q)
                                                    : 
                                                   ((0x8000U 
                                                     & vlSelf->instruction_i)
                                                     ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r25_q
                                                     : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r24_q)))
                                                  : 
                                                 ((0x20000U 
                                                   & vlSelf->instruction_i)
                                                   ? 
                                                  ((0x10000U 
                                                    & vlSelf->instruction_i)
                                                    ? 
                                                   ((0x8000U 
                                                     & vlSelf->instruction_i)
                                                     ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r23_q
                                                     : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r22_q)
                                                    : 
                                                   ((0x8000U 
                                                     & vlSelf->instruction_i)
                                                     ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r21_q
                                                     : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r20_q))
                                                   : 
                                                  ((0x10000U 
                                                    & vlSelf->instruction_i)
                                                    ? 
                                                   ((0x8000U 
                                                     & vlSelf->instruction_i)
                                                     ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r19_q
                                                     : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r18_q)
                                                    : 
                                                   ((0x8000U 
                                                     & vlSelf->instruction_i)
                                                     ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r17_q
                                                     : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r16_q))))
            : ((0x40000U & vlSelf->instruction_i) ? 
               ((0x20000U & vlSelf->instruction_i) ? 
                ((0x10000U & vlSelf->instruction_i)
                  ? ((0x8000U & vlSelf->instruction_i)
                      ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r15_q
                      : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r14_q)
                  : ((0x8000U & vlSelf->instruction_i)
                      ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r13_q
                      : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r12_q))
                 : ((0x10000U & vlSelf->instruction_i)
                     ? ((0x8000U & vlSelf->instruction_i)
                         ? 0U : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r10_q)
                     : ((0x8000U & vlSelf->instruction_i)
                         ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r9_q
                         : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r8_q)))
                : ((0x20000U & vlSelf->instruction_i)
                    ? ((0x10000U & vlSelf->instruction_i)
                        ? ((0x8000U & vlSelf->instruction_i)
                            ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r7_q
                            : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r6_q)
                        : ((0x8000U & vlSelf->instruction_i)
                            ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r5_q
                            : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r4_q))
                    : ((0x10000U & vlSelf->instruction_i)
                        ? ((0x8000U & vlSelf->instruction_i)
                            ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r3_q
                            : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r2_q)
                        : ((0x8000U & vlSelf->instruction_i)
                            ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r1_q
                            : 0U)))));
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__rs2_value_r 
        = ((0x1000000U & vlSelf->instruction_i) ? (
                                                   (0x800000U 
                                                    & vlSelf->instruction_i)
                                                    ? 
                                                   ((0x400000U 
                                                     & vlSelf->instruction_i)
                                                     ? 
                                                    ((0x200000U 
                                                      & vlSelf->instruction_i)
                                                      ? 
                                                     ((0x100000U 
                                                       & vlSelf->instruction_i)
                                                       ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r31_q
                                                       : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r30_q)
                                                      : 
                                                     ((0x100000U 
                                                       & vlSelf->instruction_i)
                                                       ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r29_q
                                                       : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r28_q))
                                                     : 
                                                    ((0x200000U 
                                                      & vlSelf->instruction_i)
                                                      ? 
                                                     ((0x100000U 
                                                       & vlSelf->instruction_i)
                                                       ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r27_q
                                                       : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r26_q)
                                                      : 
                                                     ((0x100000U 
                                                       & vlSelf->instruction_i)
                                                       ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r25_q
                                                       : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r24_q)))
                                                    : 
                                                   ((0x400000U 
                                                     & vlSelf->instruction_i)
                                                     ? 
                                                    ((0x200000U 
                                                      & vlSelf->instruction_i)
                                                      ? 
                                                     ((0x100000U 
                                                       & vlSelf->instruction_i)
                                                       ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r23_q
                                                       : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r22_q)
                                                      : 
                                                     ((0x100000U 
                                                       & vlSelf->instruction_i)
                                                       ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r21_q
                                                       : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r20_q))
                                                     : 
                                                    ((0x200000U 
                                                      & vlSelf->instruction_i)
                                                      ? 
                                                     ((0x100000U 
                                                       & vlSelf->instruction_i)
                                                       ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r19_q
                                                       : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r18_q)
                                                      : 
                                                     ((0x100000U 
                                                       & vlSelf->instruction_i)
                                                       ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r17_q
                                                       : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r16_q))))
            : ((0x800000U & vlSelf->instruction_i) ? 
               ((0x400000U & vlSelf->instruction_i)
                 ? ((0x200000U & vlSelf->instruction_i)
                     ? ((0x100000U & vlSelf->instruction_i)
                         ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r15_q
                         : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r14_q)
                     : ((0x100000U & vlSelf->instruction_i)
                         ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r13_q
                         : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r12_q))
                 : ((0x200000U & vlSelf->instruction_i)
                     ? ((0x100000U & vlSelf->instruction_i)
                         ? 0U : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r10_q)
                     : ((0x100000U & vlSelf->instruction_i)
                         ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r9_q
                         : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r8_q)))
                : ((0x400000U & vlSelf->instruction_i)
                    ? ((0x200000U & vlSelf->instruction_i)
                        ? ((0x100000U & vlSelf->instruction_i)
                            ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r7_q
                            : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r6_q)
                        : ((0x100000U & vlSelf->instruction_i)
                            ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r5_q
                            : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r4_q))
                    : ((0x200000U & vlSelf->instruction_i)
                        ? ((0x100000U & vlSelf->instruction_i)
                            ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r3_q
                            : vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r2_q)
                        : ((0x100000U & vlSelf->instruction_i)
                            ? vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r1_q
                            : 0U)))));
}

VL_ATTR_COLD void Vtop___024root___eval_stl(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_stl\n"); );
    // Body
    if ((1ULL & vlSelf->__VstlTriggered.word(0U))) {
        Vtop___024root___stl_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[3U] = 1U;
        vlSelf->__Vm_traceActivity[2U] = 1U;
        vlSelf->__Vm_traceActivity[1U] = 1U;
        vlSelf->__Vm_traceActivity[0U] = 1U;
    }
}

VL_ATTR_COLD void Vtop___024root___eval_triggers__stl(Vtop___024root* vlSelf);

VL_ATTR_COLD bool Vtop___024root___eval_phase__stl(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_phase__stl\n"); );
    // Init
    CData/*0:0*/ __VstlExecute;
    // Body
    Vtop___024root___eval_triggers__stl(vlSelf);
    __VstlExecute = vlSelf->__VstlTriggered.any();
    if (__VstlExecute) {
        Vtop___024root___eval_stl(vlSelf);
    }
    return (__VstlExecute);
}

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__ico(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___dump_triggers__ico\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VicoTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VicoTriggered.word(0U))) {
        VL_DBG_MSGF("         'ico' region trigger index 0 is active: Internal 'ico' trigger - first iteration\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__act(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___dump_triggers__act\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VactTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 0 is active: @(posedge clk_i or negedge rstn_i)\n");
    }
    if ((2ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 1 is active: @([changed] hz_ctrl_i or posedge top.clk_l or [changed] top.rstn_l)\n");
    }
    if ((4ULL & vlSelf->__VactTriggered.word(0U))) {
        VL_DBG_MSGF("         'act' region trigger index 2 is active: @(posedge top.clk_l or negedge top.rstn_l)\n");
    }
}
#endif  // VL_DEBUG

#ifdef VL_DEBUG
VL_ATTR_COLD void Vtop___024root___dump_triggers__nba(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___dump_triggers__nba\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->__VnbaTriggered.any())))) {
        VL_DBG_MSGF("         No triggers active\n");
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 0 is active: @(posedge clk_i or negedge rstn_i)\n");
    }
    if ((2ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 1 is active: @([changed] hz_ctrl_i or posedge top.clk_l or [changed] top.rstn_l)\n");
    }
    if ((4ULL & vlSelf->__VnbaTriggered.word(0U))) {
        VL_DBG_MSGF("         'nba' region trigger index 2 is active: @(posedge top.clk_l or negedge top.rstn_l)\n");
    }
}
#endif  // VL_DEBUG

VL_ATTR_COLD void Vtop___024root___ctor_var_reset(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___ctor_var_reset\n"); );
    // Body
    vlSelf->clk_i = VL_RAND_RESET_I(1);
    vlSelf->rstn_i = VL_RAND_RESET_I(1);
    vlSelf->instruction_i = VL_RAND_RESET_I(32);
    vlSelf->addr_current_i = VL_RAND_RESET_I(32);
    vlSelf->write_back_data_i = VL_RAND_RESET_I(32);
    vlSelf->write_rd_i = VL_RAND_RESET_I(5);
    vlSelf->hz_ctrl_i = VL_RAND_RESET_I(1);
    vlSelf->reg_write_en_i = VL_RAND_RESET_I(1);
    vlSelf->ctrl_branch_o = VL_RAND_RESET_I(1);
    vlSelf->ctrl_mem_read_o = VL_RAND_RESET_I(1);
    vlSelf->ctrl_mem_to_reg_o = VL_RAND_RESET_I(1);
    vlSelf->ctrl_mem_write_o = VL_RAND_RESET_I(1);
    vlSelf->ctrl_ALUsrc_o = VL_RAND_RESET_I(1);
    vlSelf->ctrl_reg_write_o = VL_RAND_RESET_I(1);
    vlSelf->ctrl_ALUOp_o = VL_RAND_RESET_I(2);
    vlSelf->rd1_o = VL_RAND_RESET_I(32);
    vlSelf->rd2_o = VL_RAND_RESET_I(32);
    vlSelf->addr_current_o = VL_RAND_RESET_I(32);
    vlSelf->imm_gen_o = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__clk_l = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__rstn_l = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__addr_current_w = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__w_addr_branch = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__addr_next_w = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__w_addr_plus4 = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__addr_current_r = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__instruction_r = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_branch_r = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_mem_read_r = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_mem_to_reg_r = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_mem_write_r = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_ALUsrc_r = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_reg_write_r = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r = VL_RAND_RESET_I(2);
    vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_r = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__funct7_30_r = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__funct3_r = VL_RAND_RESET_I(3);
    vlSelf->top__DOT__ID_stage_inst__DOT__rs1_r = VL_RAND_RESET_I(5);
    vlSelf->top__DOT__ID_stage_inst__DOT__rs2_r = VL_RAND_RESET_I(5);
    vlSelf->top__DOT__ID_stage_inst__DOT__rd_r = VL_RAND_RESET_I(5);
    vlSelf->top__DOT__ID_stage_inst__DOT__rd1_r = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__rd2_r = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__8 = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__7 = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d9647ad__2 = VL_RAND_RESET_I(2);
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__6 = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__5 = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d9647ad__1 = VL_RAND_RESET_I(2);
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__4 = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d9647ad__0 = VL_RAND_RESET_I(2);
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__3 = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__2 = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__1 = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__0 = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__branch_r = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_read_r = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_to_reg_r = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_write_r = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUsrc_r = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__reg_write_r = VL_RAND_RESET_I(1);
    vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = VL_RAND_RESET_I(2);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r1_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r2_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r3_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r4_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r5_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r6_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r7_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r8_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r9_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r10_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r11_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r12_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r13_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r14_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r15_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r16_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r17_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r18_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r19_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r20_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r21_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r22_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r23_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r24_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r25_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r26_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r27_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r28_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r29_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r30_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r31_q = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__rs1_value_r = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__rs2_value_r = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT____Vxrand_h8d93fe75__0 = VL_RAND_RESET_I(32);
    vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = VL_RAND_RESET_I(32);
    vlSelf->__Vtrigprevexpr___TOP__clk_i__0 = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__rstn_i__0 = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__hz_ctrl_i__0 = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__top__DOT__clk_l__0 = VL_RAND_RESET_I(1);
    vlSelf->__Vtrigprevexpr___TOP__top__DOT__rstn_l__0 = VL_RAND_RESET_I(1);
    vlSelf->__VactDidInit = 0;
    for (int __Vi0 = 0; __Vi0 < 4; ++__Vi0) {
        vlSelf->__Vm_traceActivity[__Vi0] = 0;
    }
}
