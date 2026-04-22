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

void Vtop___024root___eval_ico(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_ico\n"); );
    // Body
    if ((1ULL & vlSelf->__VicoTriggered.word(0U))) {
        Vtop___024root___ico_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
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
    // Body
    vlSelf->top__DOT__clk_l = vlSelf->clk_i;
}

VL_INLINE_OPT void Vtop___024root___nba_sequent__TOP__1(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___nba_sequent__TOP__1\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->top__DOT__rstn_l)))) {
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r11_q = 0U;
    }
    if (vlSelf->top__DOT__rstn_l) {
        if ((0x1fU == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r31_q 
                = vlSelf->write_back_data_i;
        }
        if ((0xfU == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r15_q 
                = vlSelf->write_back_data_i;
        }
        if ((7U == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r7_q 
                = vlSelf->write_back_data_i;
        }
        if ((3U == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r3_q 
                = vlSelf->write_back_data_i;
        }
        if ((0x10U == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r16_q 
                = vlSelf->write_back_data_i;
        }
        if ((8U == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r8_q 
                = vlSelf->write_back_data_i;
        }
        if ((1U == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r1_q 
                = vlSelf->write_back_data_i;
        }
        if ((4U == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r4_q 
                = vlSelf->write_back_data_i;
        }
        if ((9U == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r9_q 
                = vlSelf->write_back_data_i;
        }
        if ((5U == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r5_q 
                = vlSelf->write_back_data_i;
        }
        if ((2U == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r2_q 
                = vlSelf->write_back_data_i;
        }
        if ((0xaU == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r10_q 
                = vlSelf->write_back_data_i;
        }
        if ((6U == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r6_q 
                = vlSelf->write_back_data_i;
        }
        if ((0xcU == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r12_q 
                = vlSelf->write_back_data_i;
        }
        if ((0xdU == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r13_q 
                = vlSelf->write_back_data_i;
        }
        if ((0xeU == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r14_q 
                = vlSelf->write_back_data_i;
        }
        if ((0x11U == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r17_q 
                = vlSelf->write_back_data_i;
        }
        if ((0x12U == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r18_q 
                = vlSelf->write_back_data_i;
        }
        if ((0x13U == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r19_q 
                = vlSelf->write_back_data_i;
        }
        if ((0x14U == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r20_q 
                = vlSelf->write_back_data_i;
        }
        if ((0x15U == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r21_q 
                = vlSelf->write_back_data_i;
        }
        if ((0x16U == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r22_q 
                = vlSelf->write_back_data_i;
        }
        if ((0x17U == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r23_q 
                = vlSelf->write_back_data_i;
        }
        if ((0x18U == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r24_q 
                = vlSelf->write_back_data_i;
        }
        if ((0x19U == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r25_q 
                = vlSelf->write_back_data_i;
        }
        if ((0x1aU == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r26_q 
                = vlSelf->write_back_data_i;
        }
        if ((0x1bU == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r27_q 
                = vlSelf->write_back_data_i;
        }
        if ((0x1cU == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r28_q 
                = vlSelf->write_back_data_i;
        }
        if ((0x1dU == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r29_q 
                = vlSelf->write_back_data_i;
        }
        if ((0x1eU == (IData)(vlSelf->write_rd_i))) {
            vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r30_q 
                = vlSelf->write_back_data_i;
        }
    } else {
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r31_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r15_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r7_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r3_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r16_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r8_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r1_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r4_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r9_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r5_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r2_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r10_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r6_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r12_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r13_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r14_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r17_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r18_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r19_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r20_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r21_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r22_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r23_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r24_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r25_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r26_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r27_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r28_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r29_q = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r30_q = 0U;
    }
}

VL_INLINE_OPT void Vtop___024root___nba_sequent__TOP__2(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___nba_sequent__TOP__2\n"); );
    // Body
    vlSelf->top__DOT__ID_stage_inst__DOT__funct7_30_r 
        = ((IData)(vlSelf->top__DOT__rstn_l) && (1U 
                                                 & (vlSelf->instruction_i 
                                                    >> 0x1eU)));
    if (vlSelf->hz_ctrl_i) {
        vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_mem_read_r = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_mem_write_r = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_reg_write_r = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_branch_r = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_ALUsrc_r = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_mem_to_reg_r = 0U;
    }
    if (vlSelf->top__DOT__rstn_l) {
        vlSelf->top__DOT__ID_stage_inst__DOT__addr_current_r 
            = vlSelf->addr_current_i;
        vlSelf->top__DOT__ID_stage_inst__DOT__rs2_r 
            = (0x1fU & (vlSelf->instruction_i >> 0x14U));
        vlSelf->top__DOT__ID_stage_inst__DOT__rs1_r 
            = (0x1fU & (vlSelf->instruction_i >> 0xfU));
        vlSelf->top__DOT__ID_stage_inst__DOT__rd_r 
            = (0x1fU & (vlSelf->instruction_i >> 7U));
        vlSelf->top__DOT__ID_stage_inst__DOT__funct3_r 
            = (7U & (vlSelf->instruction_i >> 0xcU));
        vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_r 
            = vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r;
        vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r 
            = vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r;
        vlSelf->top__DOT__ID_stage_inst__DOT__rd2_r 
            = vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__rs2_value_r;
        vlSelf->top__DOT__ID_stage_inst__DOT__rd1_r 
            = vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__rs1_value_r;
    } else {
        vlSelf->top__DOT__ID_stage_inst__DOT__addr_current_r = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__rs2_r = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__rs1_r = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__rd_r = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__funct3_r = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_r = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__rd2_r = 0U;
        vlSelf->top__DOT__ID_stage_inst__DOT__rd1_r = 0U;
    }
    vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_mem_read_r 
        = ((IData)(vlSelf->top__DOT__rstn_l) && (IData)(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_read_r));
    vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_mem_write_r 
        = ((IData)(vlSelf->top__DOT__rstn_l) && (IData)(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_write_r));
    vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_reg_write_r 
        = ((IData)(vlSelf->top__DOT__rstn_l) && (IData)(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__reg_write_r));
    vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_branch_r 
        = ((IData)(vlSelf->top__DOT__rstn_l) && (IData)(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__branch_r));
    vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_ALUsrc_r 
        = ((IData)(vlSelf->top__DOT__rstn_l) && (IData)(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUsrc_r));
    vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_mem_to_reg_r 
        = ((IData)(vlSelf->top__DOT__rstn_l) && (IData)(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_to_reg_r));
    vlSelf->addr_current_o = vlSelf->top__DOT__ID_stage_inst__DOT__addr_current_r;
    vlSelf->imm_gen_o = vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_r;
    vlSelf->ctrl_mem_read_o = vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_mem_read_r;
    vlSelf->ctrl_mem_write_o = vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_mem_write_r;
    vlSelf->ctrl_reg_write_o = vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_reg_write_r;
    vlSelf->ctrl_branch_o = vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_branch_r;
    vlSelf->ctrl_ALUsrc_o = vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_ALUsrc_r;
    vlSelf->ctrl_ALUOp_o = vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r;
    vlSelf->ctrl_mem_to_reg_o = vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_mem_to_reg_r;
    vlSelf->rd2_o = vlSelf->top__DOT__ID_stage_inst__DOT__rd2_r;
    vlSelf->rd1_o = vlSelf->top__DOT__ID_stage_inst__DOT__rd1_r;
}

VL_INLINE_OPT void Vtop___024root___nba_sequent__TOP__3(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___nba_sequent__TOP__3\n"); );
    // Body
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
}

VL_INLINE_OPT void Vtop___024root___nba_sequent__TOP__4(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___nba_sequent__TOP__4\n"); );
    // Body
    vlSelf->top__DOT__rstn_l = vlSelf->rstn_i;
}

void Vtop___024root___eval_nba(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_nba\n"); );
    // Body
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtop___024root___nba_sequent__TOP__0(vlSelf);
    }
    if ((4ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtop___024root___nba_sequent__TOP__1(vlSelf);
        vlSelf->__Vm_traceActivity[2U] = 1U;
    }
    if ((2ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtop___024root___nba_sequent__TOP__2(vlSelf);
        vlSelf->__Vm_traceActivity[3U] = 1U;
    }
    if ((4ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtop___024root___nba_sequent__TOP__3(vlSelf);
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtop___024root___nba_sequent__TOP__4(vlSelf);
    }
}

void Vtop___024root___eval_triggers__act(Vtop___024root* vlSelf);

bool Vtop___024root___eval_phase__act(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_phase__act\n"); );
    // Init
    VlTriggerVec<3> __VpreTriggered;
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
    if (VL_UNLIKELY((vlSelf->write_rd_i & 0xe0U))) {
        Verilated::overWidthError("write_rd_i");}
    if (VL_UNLIKELY((vlSelf->hz_ctrl_i & 0xfeU))) {
        Verilated::overWidthError("hz_ctrl_i");}
    if (VL_UNLIKELY((vlSelf->reg_write_en_i & 0xfeU))) {
        Verilated::overWidthError("reg_write_en_i");}
}
#endif  // VL_DEBUG
