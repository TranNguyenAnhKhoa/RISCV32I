// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vtop.h for the primary calling header

#include "Vtop__pch.h"
#include "Vtop___024root.h"

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
    CData/*1:0*/ __Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r;
    __Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r = 0;
    // Body
    vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_write_r 
        = vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_write_r;
    vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_to_reg_r 
        = vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_to_reg_r;
    __Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r 
        = vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r;
    vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_read_r 
        = vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_read_r;
    vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_reg_write_r 
        = vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_reg_write_r;
    vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_branch_r 
        = vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_branch_r;
    vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r 
        = vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r;
    vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r 
        = vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r;
    if (vlSelf->top__DOT__RISCV_inst__DOT__hz_ctrl_w) {
        vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_write_r = 0U;
        vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_to_reg_r = 0U;
        __Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r = 0U;
        vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_read_r = 0U;
        vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_reg_write_r = 0U;
        vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_branch_r = 0U;
    }
    vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_write_r 
        = ((IData)(vlSelf->top__DOT__rstn_l) && ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__hz_write_IDEX_w)
                                                  ? (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_write_r)
                                                  : (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_write_r)));
    if (vlSelf->top__DOT__rstn_l) {
        if (vlSelf->top__DOT__RISCV_inst__DOT__hz_write_IDEX_w) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_r 
                = vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r;
            __Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r 
                = vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r;
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd2_r 
                = vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__rs2_value_r;
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                = vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__rs1_value_r;
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__addr_current_r 
                = vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__addr_current_r;
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rs2_r 
                = (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                            >> 0x14U));
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rs1_r 
                = (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                            >> 0xfU));
            vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r 
                = (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                            >> 7U));
            vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r 
                = (7U & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                         >> 0xcU));
        } else {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_r 
                = vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_r;
            __Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r 
                = vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r;
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd2_r 
                = vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd2_r;
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                = vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r;
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__addr_current_r 
                = vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__addr_current_r;
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rs2_r 
                = (0x1fU & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rs2_r));
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rs1_r 
                = (0x1fU & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rs1_r));
            vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r 
                = (0x1fU & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r));
            vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r 
                = (7U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r));
        }
    } else {
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_r = 0U;
        __Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd2_r = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__addr_current_r = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rs2_r = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rs1_r = 0U;
        vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r = 0U;
        vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r = 0U;
    }
    vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_to_reg_r 
        = ((IData)(vlSelf->top__DOT__rstn_l) && ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__hz_write_IDEX_w)
                                                  ? (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_to_reg_r)
                                                  : (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_to_reg_r)));
    vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_read_r 
        = ((IData)(vlSelf->top__DOT__rstn_l) && ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__hz_write_IDEX_w)
                                                  ? (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_read_r)
                                                  : (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_read_r)));
    vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_reg_write_r 
        = ((IData)(vlSelf->top__DOT__rstn_l) && ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__hz_write_IDEX_w)
                                                  ? (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__reg_write_r)
                                                  : (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_reg_write_r)));
    vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_branch_r 
        = ((IData)(vlSelf->top__DOT__rstn_l) && ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__hz_write_IDEX_w)
                                                  ? (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__branch_r)
                                                  : (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_branch_r)));
    vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct7_30_r 
        = ((IData)(vlSelf->top__DOT__rstn_l) && (1U 
                                                 & ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__hz_write_IDEX_w)
                                                     ? 
                                                    (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                     >> 0x1eU)
                                                     : (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct7_30_r))));
    vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r 
        = __Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r;
}

VL_INLINE_OPT void Vtop___024root___nba_sequent__TOP__1(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___nba_sequent__TOP__1\n"); );
    // Init
    IData/*31:0*/ __Vdly__top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r;
    __Vdly__top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r = 0;
    // Body
    __Vdly__top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r 
        = vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r;
    if (vlSelf->top__DOT__rstn_l) {
        __Vdly__top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r 
            = (((((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_read_r) 
                  & (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r) 
                      == (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                   >> 0xfU))) | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r) 
                                                 == 
                                                 (0x1fU 
                                                  & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                     >> 0x14U))))) 
                 | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_branch_r) 
                    & (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_reg_write_r) 
                        & (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r) 
                            == (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                         >> 0xfU))) 
                           | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r) 
                              == (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                           >> 0x14U))))) 
                       | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_read_r) 
                          & (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r) 
                              == (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                           >> 0xfU))) 
                             | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r) 
                                == (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                             >> 0x14U)))))))) 
                | ((0x67U == (0x707fU & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) 
                   & (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r) 
                       == (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                    >> 0xfU))) | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_read_r) 
                                                  & ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r) 
                                                     == 
                                                     (0x1fU 
                                                      & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                         >> 0xfU)))))))
                ? vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r
                : vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__addr_next_w);
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_data_r 
            = (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out0 
               | (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out1 
                  | (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out2 
                     | (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out3 
                        | (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out4 
                           | (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out5 
                              | (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out6 
                                 | (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out7 
                                    | (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out8 
                                       | (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out9 
                                          | (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out10 
                                             | (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out11 
                                                | (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out12 
                                                   | (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out13 
                                                      | vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out15))))))))))))));
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ALUresult_r 
            = vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r;
        vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__addr_current_r 
            = vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r;
        vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
            = ((vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__IMEM_inst0__DOT__imem
                [(0x3ffU & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r)] 
                << 0x18U) | ((vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__IMEM_inst0__DOT__imem
                              [(0x3ffU & ((IData)(1U) 
                                          + vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r))] 
                              << 0x10U) | ((vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__IMEM_inst0__DOT__imem
                                            [(0x3ffU 
                                              & ((IData)(2U) 
                                                 + vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r))] 
                                            << 8U) 
                                           | vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__IMEM_inst0__DOT__imem
                                           [(0x3ffU 
                                             & ((IData)(3U) 
                                                + vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r))])));
    } else {
        __Vdly__top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_data_r = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ALUresult_r = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__addr_current_r = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r = 0U;
    }
    vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ctrl_mem_to_reg_r 
        = ((IData)(vlSelf->top__DOT__rstn_l) && (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_to_reg_r));
    vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ctrl_reg_write_r 
        = ((IData)(vlSelf->top__DOT__rstn_l) && (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_reg_write_r));
    vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_read_r 
        = ((1U & (~ (IData)(vlSelf->top__DOT__rstn_l))) 
           && (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_read_r));
    vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_to_reg_r 
        = ((1U & (~ (IData)(vlSelf->top__DOT__rstn_l))) 
           && (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_to_reg_r));
    vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_reg_write_r 
        = ((1U & (~ (IData)(vlSelf->top__DOT__rstn_l))) 
           && (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_reg_write_r));
    vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r 
        = __Vdly__top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r;
    if ((1U & (~ (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_read_r)))) {
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out15 = 0U;
    }
    vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_write_r 
        = ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                     >> 6U))) && ((1U & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                         >> 5U)) && 
                                  ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                             >> 4U))) 
                                   && ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                 >> 3U))) 
                                       && ((1U & (~ 
                                                  (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                   >> 2U))) 
                                           && ((1U 
                                                & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                   >> 1U)) 
                                               && (1U 
                                                   & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)))))));
    vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_read_r 
        = ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                     >> 6U))) && ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                            >> 5U))) 
                                  && ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                >> 4U))) 
                                      && ((1U & (~ 
                                                 (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                  >> 3U))) 
                                          && ((1U & 
                                               (~ (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                   >> 2U))) 
                                              && ((1U 
                                                   & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                      >> 1U)) 
                                                  && (1U 
                                                      & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)))))));
    if ((0x40U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) {
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__reg_write_r 
            = ((1U & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                      >> 5U)) && ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                            >> 4U))) 
                                  && ((8U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                                       ? ((1U & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                 >> 2U)) 
                                          && ((1U & 
                                               (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)))
                                       : ((1U & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                 >> 2U)) 
                                          && ((1U & 
                                               (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r))))));
        if ((0x20U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) {
            if ((0x10U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) {
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = 0U;
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = 0U;
            } else if ((8U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) {
                if ((4U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) {
                    vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r 
                        = (((- (IData)((vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                        >> 0x1fU))) 
                            << 0x15U) | ((0x100000U 
                                          & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                             >> 0xbU)) 
                                         | ((0xff000U 
                                             & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r) 
                                            | ((0x800U 
                                                & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                   >> 9U)) 
                                               | (0x7feU 
                                                  & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                     >> 0x14U))))));
                    vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r 
                        = ((2U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? ((1U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                                ? (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d9647ad__0)
                                : 0U) : 0U);
                } else {
                    vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = 0U;
                    vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = 0U;
                }
            } else if ((4U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) {
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r 
                    = (((- (IData)((vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                    >> 0x1fU))) << 0xcU) 
                       | (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                          >> 0x14U));
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r 
                    = ((2U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((1U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d9647ad__1)
                            : 0U) : 0U);
            } else {
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r 
                    = (((- (IData)((vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                    >> 0x1fU))) << 0xcU) 
                       | ((0x800U & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                     << 4U)) | ((0x7e0U 
                                                 & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                    >> 0x14U)) 
                                                | (0x1eU 
                                                   & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                      >> 7U)))));
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r 
                    = ((2U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((1U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? 2U : 0U) : 0U);
            }
        } else {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = 0U;
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = 0U;
        }
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__branch_r 
            = ((1U & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                      >> 5U)) && ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                            >> 4U))) 
                                  && ((8U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                                       ? ((1U & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                 >> 2U)) 
                                          && ((1U & 
                                               (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)))
                                       : ((4U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                                           ? ((1U & 
                                               (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r))
                                           : ((1U & 
                                               (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                >> 1U)) 
                                              && ((1U 
                                                   & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r) 
                                                  && (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__3)))))));
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_to_reg_r 
            = ((1U & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                      >> 5U)) && ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                            >> 4U))) 
                                  && ((8U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                                       ? ((1U & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                 >> 2U)) 
                                          && ((1U & 
                                               (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                >> 1U)) 
                                              && ((1U 
                                                   & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r) 
                                                  && (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__4))))
                                       : ((4U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                                           ? ((1U & 
                                               (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                >> 1U)) 
                                              && ((1U 
                                                   & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r) 
                                                  && (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__5)))
                                           : ((1U & 
                                               (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                >> 1U)) 
                                              && ((1U 
                                                   & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r) 
                                                  && (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__2)))))));
    } else if ((0x20U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) {
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__reg_write_r 
            = ((1U & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                      >> 4U)) && ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                            >> 3U))) 
                                  && ((4U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                                       ? ((1U & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                 >> 1U)) 
                                          && (1U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r))
                                       : ((1U & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                 >> 1U)) 
                                          && (1U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)))));
        if ((0x10U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) {
            if ((8U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) {
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = 0U;
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = 0U;
            } else if ((4U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) {
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r 
                    = (0xfffff000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r);
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r 
                    = ((2U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((1U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? 3U : 0U) : 0U);
            } else {
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r 
                    = vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT____Vxrand_h8d93fe75__0;
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = 0U;
            }
        } else if ((8U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = 0U;
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = 0U;
        } else if ((4U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = 0U;
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = 0U;
        } else {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r 
                = (((- (IData)((vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                >> 0x1fU))) << 0xcU) 
                   | ((0xfe0U & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                 >> 0x14U)) | (0x1fU 
                                               & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                  >> 7U))));
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r 
                = ((2U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                    ? ((1U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? 1U : 0U) : 0U);
        }
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__branch_r 
            = ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                         >> 4U))) && ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                >> 3U))) 
                                      && ((1U & (~ 
                                                 (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                  >> 2U))) 
                                          && ((1U & 
                                               (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                >> 1U)) 
                                              && ((1U 
                                                   & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r) 
                                                  && (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__1))))));
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_to_reg_r 
            = ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                         >> 4U))) && ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                >> 3U))) 
                                      && ((1U & (~ 
                                                 (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                  >> 2U))) 
                                          && ((1U & 
                                               (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                >> 1U)) 
                                              && ((1U 
                                                   & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r) 
                                                  && (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__0))))));
    } else {
        if ((0x10U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__reg_write_r 
                = ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                             >> 3U))) && ((4U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                                           ? ((1U & 
                                               (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r))
                                           : ((1U & 
                                               (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r))));
            if ((8U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) {
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = 0U;
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = 0U;
            } else if ((4U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) {
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = 0U;
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r 
                    = ((2U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((1U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d9647ad__2)
                            : 0U) : 0U);
            } else {
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r 
                    = (((- (IData)((vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                    >> 0x1fU))) << 0xcU) 
                       | (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                          >> 0x14U));
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r 
                    = ((2U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((1U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? 2U : 0U) : 0U);
            }
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_to_reg_r 
                = ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                             >> 3U))) && ((1U & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                 >> 2U)) 
                                          && ((1U & 
                                               (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                >> 1U)) 
                                              && ((1U 
                                                   & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r) 
                                                  && (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT____Vxrand_h8d96565c__6)))));
        } else {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__reg_write_r 
                = ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                             >> 3U))) && ((1U & (~ 
                                                 (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                  >> 2U))) 
                                          && ((1U & 
                                               (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r))));
            if ((8U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) {
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = 0U;
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = 0U;
            } else if ((4U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) {
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r = 0U;
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r = 0U;
            } else {
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r 
                    = (((- (IData)((vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                    >> 0x1fU))) << 0xcU) 
                       | (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                          >> 0x14U));
                vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r 
                    = ((2U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((1U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? 1U : 0U) : 0U);
            }
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_to_reg_r 
                = ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                             >> 3U))) && ((1U & (~ 
                                                 (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                  >> 2U))) 
                                          && ((1U & 
                                               (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                >> 1U)) 
                                              && (1U 
                                                  & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r))));
        }
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__branch_r 
            = ((1U & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                      >> 4U)) && ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                            >> 3U))) 
                                  && ((1U & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                             >> 2U)) 
                                      && ((1U & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                 >> 1U)) 
                                          && (1U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)))));
    }
}

VL_INLINE_OPT void Vtop___024root___nba_sequent__TOP__2(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___nba_sequent__TOP__2\n"); );
    // Init
    CData/*5:0*/ __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v0;
    __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v0 = 0;
    CData/*7:0*/ __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v0;
    __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v0 = 0;
    CData/*0:0*/ __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v0;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v0 = 0;
    CData/*5:0*/ __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v1;
    __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v1 = 0;
    CData/*7:0*/ __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v1;
    __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v1 = 0;
    CData/*0:0*/ __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v1;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v1 = 0;
    CData/*5:0*/ __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v2;
    __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v2 = 0;
    CData/*7:0*/ __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v2;
    __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v2 = 0;
    CData/*0:0*/ __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v2;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v2 = 0;
    CData/*5:0*/ __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v3;
    __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v3 = 0;
    CData/*0:0*/ __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v3;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v3 = 0;
    CData/*5:0*/ __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v0;
    __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v0 = 0;
    CData/*7:0*/ __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v0;
    __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v0 = 0;
    CData/*0:0*/ __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v0;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v0 = 0;
    CData/*5:0*/ __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v1;
    __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v1 = 0;
    CData/*7:0*/ __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v1;
    __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v1 = 0;
    CData/*0:0*/ __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v1;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v1 = 0;
    CData/*5:0*/ __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v2;
    __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v2 = 0;
    CData/*7:0*/ __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v2;
    __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v2 = 0;
    CData/*0:0*/ __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v2;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v2 = 0;
    CData/*5:0*/ __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v3;
    __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v3 = 0;
    CData/*0:0*/ __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v3;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v3 = 0;
    CData/*5:0*/ __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v0;
    __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v0 = 0;
    CData/*7:0*/ __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v0;
    __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v0 = 0;
    CData/*0:0*/ __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v0;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v0 = 0;
    CData/*5:0*/ __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v1;
    __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v1 = 0;
    CData/*7:0*/ __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v1;
    __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v1 = 0;
    CData/*0:0*/ __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v1;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v1 = 0;
    CData/*5:0*/ __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v2;
    __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v2 = 0;
    CData/*7:0*/ __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v2;
    __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v2 = 0;
    CData/*0:0*/ __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v2;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v2 = 0;
    CData/*5:0*/ __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v3;
    __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v3 = 0;
    CData/*0:0*/ __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v3;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v3 = 0;
    CData/*5:0*/ __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v0;
    __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v0 = 0;
    CData/*7:0*/ __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v0;
    __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v0 = 0;
    CData/*0:0*/ __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v0;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v0 = 0;
    CData/*5:0*/ __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v1;
    __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v1 = 0;
    CData/*7:0*/ __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v1;
    __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v1 = 0;
    CData/*0:0*/ __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v1;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v1 = 0;
    CData/*5:0*/ __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v2;
    __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v2 = 0;
    CData/*7:0*/ __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v2;
    __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v2 = 0;
    CData/*0:0*/ __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v2;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v2 = 0;
    CData/*5:0*/ __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v3;
    __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v3 = 0;
    CData/*0:0*/ __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v3;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v3 = 0;
    // Body
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v0 = 0U;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v1 = 0U;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v2 = 0U;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v3 = 0U;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v0 = 0U;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v1 = 0U;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v2 = 0U;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v3 = 0U;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v0 = 0U;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v1 = 0U;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v2 = 0U;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v3 = 0U;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v0 = 0U;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v1 = 0U;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v2 = 0U;
    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v3 = 0U;
    if (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_write_r) {
        if ((2U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__funct3_r))) {
            __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v0 
                = (0xffU & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_r);
            __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v0 = 1U;
            __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v0 
                = (0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                            >> 2U));
            __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v0 
                = (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_r 
                   >> 0x18U);
            __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v0 = 1U;
            __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v0 
                = (0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                            >> 2U));
            __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v0 
                = (0xffU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_r 
                            >> 8U));
            __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v0 = 1U;
            __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v0 
                = (0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                            >> 2U));
            __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v0 
                = (0xffU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_r 
                            >> 0x10U));
            __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v0 = 1U;
            __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v0 
                = (0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                            >> 2U));
        } else if ((1U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__funct3_r))) {
            if ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                          >> 1U)))) {
                __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v1 
                    = (0xffU & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_r);
                __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v1 = 1U;
                __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v1 
                    = (0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                >> 2U));
                __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v1 
                    = (0xffU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_r 
                                >> 8U));
                __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v1 = 1U;
                __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v1 
                    = (0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                >> 2U));
            }
            if ((2U & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r)) {
                __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v1 
                    = (0xffU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_r 
                                >> 8U));
                __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v1 = 1U;
                __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v1 
                    = (0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                >> 2U));
                __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v1 
                    = (0xffU & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_r);
                __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v1 = 1U;
                __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v1 
                    = (0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                >> 2U));
            }
        } else if ((0U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__funct3_r))) {
            if ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                          >> 1U)))) {
                if ((1U & (~ vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r))) {
                    __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v2 
                        = (0xffU & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_r);
                    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v2 = 1U;
                    __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v2 
                        = (0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                    >> 2U));
                }
                if ((1U & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r)) {
                    __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v2 
                        = (0xffU & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_r);
                    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v2 = 1U;
                    __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v2 
                        = (0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                    >> 2U));
                }
            }
            if ((2U & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r)) {
                if ((1U & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r)) {
                    __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v2 
                        = (0xffU & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_r);
                    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v2 = 1U;
                    __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v2 
                        = (0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                    >> 2U));
                }
                if ((1U & (~ vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r))) {
                    __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v2 
                        = (0xffU & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_r);
                    __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v2 = 1U;
                    __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v2 
                        = (0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                    >> 2U));
                }
            }
        } else {
            __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v3 = 1U;
            __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v3 
                = (0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                            >> 2U));
            __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v3 = 1U;
            __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v3 
                = (0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                            >> 2U));
            __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v3 = 1U;
            __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v3 
                = (0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                            >> 2U));
            __Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v3 = 1U;
            __Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v3 
                = (0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                            >> 2U));
        }
    }
    if (__Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v0) {
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0[__Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v0] 
            = __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v0;
    }
    if (__Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v1) {
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0[__Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v1] 
            = __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v1;
    }
    if (__Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v2) {
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0[__Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v2] 
            = __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v2;
    }
    if (__Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v3) {
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0[__Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0__v3] = 0U;
    }
    if (__Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v0) {
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3[__Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v0] 
            = __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v0;
    }
    if (__Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v1) {
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3[__Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v1] 
            = __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v1;
    }
    if (__Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v2) {
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3[__Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v2] 
            = __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v2;
    }
    if (__Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v3) {
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3[__Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3__v3] = 0U;
    }
    if (__Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v0) {
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1[__Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v0] 
            = __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v0;
    }
    if (__Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v1) {
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1[__Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v1] 
            = __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v1;
    }
    if (__Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v2) {
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1[__Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v2] 
            = __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v2;
    }
    if (__Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v3) {
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1[__Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1__v3] = 0U;
    }
    if (__Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v0) {
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2[__Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v0] 
            = __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v0;
    }
    if (__Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v1) {
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2[__Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v1] 
            = __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v1;
    }
    if (__Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v2) {
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2[__Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v2] 
            = __Vdlyvval__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v2;
    }
    if (__Vdlyvset__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v3) {
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2[__Vdlyvdim0__top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2__v3] = 0U;
    }
}

VL_INLINE_OPT void Vtop___024root___nba_sequent__TOP__3(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___nba_sequent__TOP__3\n"); );
    // Body
    vlSelf->top__DOT__clk_l = vlSelf->clk_i;
}

VL_INLINE_OPT void Vtop___024root___nba_sequent__TOP__4(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___nba_sequent__TOP__4\n"); );
    // Body
    if ((1U & (~ (IData)(vlSelf->top__DOT__rstn_l)))) {
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r11_q = 0U;
    }
    if (vlSelf->top__DOT__rstn_l) {
        if ((0x1fU == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r31_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((0xfU == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r15_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((7U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r7_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((3U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r3_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((0x10U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r16_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((8U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r8_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((1U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r1_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((4U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r4_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((9U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r9_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((5U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r5_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((2U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r2_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((0xaU == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r10_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((6U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r6_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((0xcU == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r12_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((0xdU == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r13_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((0xeU == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r14_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((0x11U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r17_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((0x12U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r18_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((0x13U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r19_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((0x14U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r20_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((0x15U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r21_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((0x16U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r22_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((0x17U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r23_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((0x18U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r24_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((0x19U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r25_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((0x1aU == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r26_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((0x1bU == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r27_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((0x1cU == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r28_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((0x1dU == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r29_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
        if ((0x1eU == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) {
            vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r30_q 
                = vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w;
        }
    } else {
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r31_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r15_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r7_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r3_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r16_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r8_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r1_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r4_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r9_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r5_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r2_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r10_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r6_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r12_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r13_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r14_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r17_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r18_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r19_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r20_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r21_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r22_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r23_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r24_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r25_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r26_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r27_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r28_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r29_q = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r30_q = 0U;
    }
}

VL_INLINE_OPT void Vtop___024root___nba_sequent__TOP__5(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___nba_sequent__TOP__5\n"); );
    // Body
    vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_branch_r 
        = vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_branch_r;
    vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_read_r 
        = vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_read_r;
    vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_to_reg_r 
        = vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_to_reg_r;
    vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_reg_write_r 
        = vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_reg_write_r;
}

VL_INLINE_OPT void Vtop___024root___nba_sequent__TOP__6(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___nba_sequent__TOP__6\n"); );
    // Body
    vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w = 
        ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ctrl_mem_to_reg_r)
          ? vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_data_r
          : vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ALUresult_r);
    vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_write_r 
        = ((1U & (~ (IData)(vlSelf->top__DOT__rstn_l))) 
           && (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_write_r));
    if (vlSelf->top__DOT__rstn_l) {
        vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_r = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__funct3_r = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r 
            = vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r;
        vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r = 0U;
    } else {
        vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_r 
            = vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w;
        vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__funct3_r 
            = vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r;
        vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
            = ((8U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                ? ((4U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                    ? ((2U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                        ? 0xdeadU : ((1U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                                      ? (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w 
                                         >> (0x1fU 
                                             & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w))
                                      : 0xdeadU)) : 
                   ((2U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                     ? 0xdeadU : ((1U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                                   ? 0xdeadU : (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w 
                                                - vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w))))
                : ((4U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                    ? ((2U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                        ? ((1U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                            ? (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w 
                               & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w)
                            : (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w 
                               | vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w))
                        : ((1U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                            ? (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w 
                               >> (0x1fU & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w))
                            : (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w 
                               ^ vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w)))
                    : ((2U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                        ? 0xdeadU : ((1U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                                      ? (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w 
                                         << (0x1fU 
                                             & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w))
                                      : (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w 
                                         + vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w)))));
        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r = 0U;
        vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r 
            = vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r;
    }
}

VL_INLINE_OPT void Vtop___024root___nba_comb__TOP__0(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___nba_comb__TOP__0\n"); );
    // Body
    vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__rs1_value_r 
        = ((0x80000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
            ? ((0x40000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                ? ((0x20000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                    ? ((0x10000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((0x8000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r31_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r30_q)
                        : ((0x8000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r29_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r28_q))
                    : ((0x10000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((0x8000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r27_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r26_q)
                        : ((0x8000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r25_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r24_q)))
                : ((0x20000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                    ? ((0x10000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((0x8000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r23_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r22_q)
                        : ((0x8000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r21_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r20_q))
                    : ((0x10000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((0x8000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r19_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r18_q)
                        : ((0x8000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r17_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r16_q))))
            : ((0x40000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                ? ((0x20000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                    ? ((0x10000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((0x8000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r15_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r14_q)
                        : ((0x8000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r13_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r12_q))
                    : ((0x10000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((0x8000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? 0U : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r10_q)
                        : ((0x8000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r9_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r8_q)))
                : ((0x20000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                    ? ((0x10000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((0x8000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r7_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r6_q)
                        : ((0x8000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r5_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r4_q))
                    : ((0x10000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((0x8000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r3_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r2_q)
                        : ((0x8000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r1_q
                            : 0U)))));
    vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__rs2_value_r 
        = ((0x1000000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
            ? ((0x800000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                ? ((0x400000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                    ? ((0x200000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((0x100000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r31_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r30_q)
                        : ((0x100000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r29_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r28_q))
                    : ((0x200000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((0x100000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r27_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r26_q)
                        : ((0x100000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r25_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r24_q)))
                : ((0x400000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                    ? ((0x200000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((0x100000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r23_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r22_q)
                        : ((0x100000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r21_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r20_q))
                    : ((0x200000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((0x100000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r19_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r18_q)
                        : ((0x100000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r17_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r16_q))))
            : ((0x800000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                ? ((0x400000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                    ? ((0x200000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((0x100000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r15_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r14_q)
                        : ((0x100000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r13_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r12_q))
                    : ((0x200000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((0x100000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? 0U : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r10_q)
                        : ((0x100000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r9_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r8_q)))
                : ((0x400000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                    ? ((0x200000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((0x100000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r7_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r6_q)
                        : ((0x100000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r5_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r4_q))
                    : ((0x200000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                        ? ((0x100000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r3_q
                            : vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r2_q)
                        : ((0x100000U & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)
                            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r1_q
                            : 0U)))));
}

VL_INLINE_OPT void Vtop___024root___nba_sequent__TOP__7(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___nba_sequent__TOP__7\n"); );
    // Init
    CData/*3:0*/ top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU_control_inst0__DOT____VdfgTmp_h8c6cd3b7__0;
    top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU_control_inst0__DOT____VdfgTmp_h8c6cd3b7__0 = 0;
    // Body
    vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_write_r 
        = vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_write_r;
    vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r 
        = vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r;
    vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r 
        = vlSelf->__Vdly__top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r;
    top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU_control_inst0__DOT____VdfgTmp_h8c6cd3b7__0 
        = (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct7_30_r) 
            << 3U) | (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r));
    vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w 
        = ((0U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r))
            ? 0U : ((1U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r))
                     ? 8U : ((2U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r))
                              ? ((0U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))
                                  ? (IData)(top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU_control_inst0__DOT____VdfgTmp_h8c6cd3b7__0)
                                  : ((1U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))
                                      ? 1U : ((4U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))
                                               ? 4U
                                               : ((5U 
                                                   == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))
                                                   ? (IData)(top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU_control_inst0__DOT____VdfgTmp_h8c6cd3b7__0)
                                                   : 
                                                  ((6U 
                                                    == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))
                                                    ? 6U
                                                    : 0U)))))
                              : ((3U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r))
                                  ? 0xfU : 0U))));
}

VL_INLINE_OPT void Vtop___024root___nba_comb__TOP__1(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___nba_comb__TOP__1\n"); );
    // Body
    if (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_read_r) {
        if ((1U & (~ ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__funct3_r) 
                      >> 2U)))) {
            if ((1U & (~ ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__funct3_r) 
                          >> 1U)))) {
                if ((1U & (~ (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__funct3_r)))) {
                    if ((2U & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r)) {
                        if ((1U & (~ vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r))) {
                            vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out2 
                                = (((- (IData)((1U 
                                                & (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2
                                                   [
                                                   (0x3fU 
                                                    & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                                       >> 2U))] 
                                                   >> 7U)))) 
                                    << 8U) | vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2
                                   [(0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                              >> 2U))]);
                        }
                        if ((1U & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r)) {
                            vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out3 
                                = (((- (IData)((1U 
                                                & (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3
                                                   [
                                                   (0x3fU 
                                                    & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                                       >> 2U))] 
                                                   >> 7U)))) 
                                    << 8U) | vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3
                                   [(0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                              >> 2U))]);
                        }
                    }
                    if ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                  >> 1U)))) {
                        if ((1U & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r)) {
                            vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out1 
                                = (((- (IData)((1U 
                                                & (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1
                                                   [
                                                   (0x3fU 
                                                    & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                                       >> 2U))] 
                                                   >> 7U)))) 
                                    << 8U) | vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1
                                   [(0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                              >> 2U))]);
                        }
                        if ((1U & (~ vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r))) {
                            vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out0 
                                = (((- (IData)((1U 
                                                & (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0
                                                   [
                                                   (0x3fU 
                                                    & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                                       >> 2U))] 
                                                   >> 7U)))) 
                                    << 8U) | vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0
                                   [(0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                              >> 2U))]);
                        }
                    }
                }
                if ((1U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__funct3_r))) {
                    if ((2U & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r)) {
                        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out4 
                            = (((- (IData)((1U & (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3
                                                  [
                                                  (0x3fU 
                                                   & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                                      >> 2U))] 
                                                  >> 7U)))) 
                                << 0x10U) | ((vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3
                                              [(0x3fU 
                                                & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                                   >> 2U))] 
                                              << 8U) 
                                             | vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2
                                             [(0x3fU 
                                               & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                                  >> 2U))]));
                    }
                    if ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                  >> 1U)))) {
                        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out5 
                            = (((- (IData)((1U & (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2
                                                  [
                                                  (0x3fU 
                                                   & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                                      >> 2U))] 
                                                  >> 7U)))) 
                                << 0x10U) | ((vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1
                                              [(0x3fU 
                                                & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                                   >> 2U))] 
                                              << 8U) 
                                             | vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0
                                             [(0x3fU 
                                               & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                                  >> 2U))]));
                    }
                }
            }
            if ((2U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__funct3_r))) {
                if ((1U & (~ (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__funct3_r)))) {
                    vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out7 
                        = ((0xffffU & vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out7) 
                           | ((vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3
                               [(0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                          >> 2U))] 
                               << 0x18U) | (vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2
                                            [(0x3fU 
                                              & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                                 >> 2U))] 
                                            << 0x10U)));
                    vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out6 
                        = ((0xffff0000U & vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out6) 
                           | ((vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1
                               [(0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                          >> 2U))] 
                               << 8U) | vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0
                              [(0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                         >> 2U))]));
                }
            }
        }
        if ((4U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__funct3_r))) {
            if ((1U & (~ ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__funct3_r) 
                          >> 1U)))) {
                if ((1U & (~ (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__funct3_r)))) {
                    if ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                  >> 1U)))) {
                        if ((1U & (~ vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r))) {
                            vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out8 
                                = vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0
                                [(0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                           >> 2U))];
                        }
                        if ((1U & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r)) {
                            vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out9 
                                = vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1
                                [(0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                           >> 2U))];
                        }
                    }
                    if ((2U & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r)) {
                        if ((1U & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r)) {
                            vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out11 
                                = vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3
                                [(0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                           >> 2U))];
                        }
                        if ((1U & (~ vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r))) {
                            vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out10 
                                = vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2
                                [(0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                           >> 2U))];
                        }
                    }
                }
                if ((1U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__funct3_r))) {
                    if ((1U & (~ (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                  >> 1U)))) {
                        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out13 
                            = ((vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2
                                [(0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                           >> 2U))] 
                                << 8U) | vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1
                               [(0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                          >> 2U))]);
                    }
                    if ((2U & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r)) {
                        vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out12 
                            = ((vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3
                                [(0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                           >> 2U))] 
                                << 8U) | vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2
                               [(0x3fU & (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r 
                                          >> 2U))]);
                    }
                }
            }
        }
    }
}

VL_INLINE_OPT void Vtop___024root___nba_sequent__TOP__8(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___nba_sequent__TOP__8\n"); );
    // Body
    vlSelf->top__DOT__rstn_l = vlSelf->rstn_i;
}

VL_INLINE_OPT void Vtop___024root___nba_comb__TOP__2(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___nba_comb__TOP__2\n"); );
    // Body
    vlSelf->top__DOT__RISCV_inst__DOT__hz_ALU1_w = 
        ((((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_reg_write_r) 
           & (0U != (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r))) 
          & ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r) 
             == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rs1_r)))
          ? 1U : ((((IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ctrl_reg_write_r) 
                    & (0U != (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) 
                   & ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r) 
                      == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rs1_r)))
                   ? 2U : 0U));
    vlSelf->top__DOT__RISCV_inst__DOT__hz_ALU2_w = 
        ((((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_reg_write_r) 
           & (0U != (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r))) 
          & ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r) 
             == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rs2_r)))
          ? 1U : ((((IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ctrl_reg_write_r) 
                    & (0U != (IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r))) 
                   & ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r) 
                      == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rs2_r)))
                   ? 2U : 0U));
    vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__addr_next_w 
        = ((((4U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))
              ? ((2U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))
                  ? (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r)
                  : ((1U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))
                      ? (((vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                           >> 0x1fU) == (vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                         >> 0x1fU)) 
                         || (vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                             >> 0x1fU)) : (((vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                             >> 0x1fU) 
                                            != (vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                                >> 0x1fU)) 
                                           && (vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                               >> 0x1fU))))
              : ((1U & (~ ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r) 
                           >> 1U))) && (1U & (~ (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))))) 
            & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_branch_r))
            ? (vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__addr_current_r 
               + vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_r)
            : ((IData)(4U) + vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r));
    vlSelf->top__DOT__RISCV_inst__DOT__hz_write_IDEX_w 
        = (1U & (~ ((((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_read_r) 
                      & (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r) 
                          == (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                       >> 0xfU))) | 
                         ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r) 
                          == (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                       >> 0x14U))))) 
                     | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_branch_r) 
                        & (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_reg_write_r) 
                            & (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r) 
                                == (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                             >> 0xfU))) 
                               | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r) 
                                  == (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                               >> 0x14U))))) 
                           | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_read_r) 
                              & (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r) 
                                  == (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                               >> 0xfU))) 
                                 | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r) 
                                    == (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                 >> 0x14U)))))))) 
                    | ((0x67U == (0x707fU & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) 
                       & (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r) 
                           == (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                        >> 0xfU))) 
                          | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_read_r) 
                             & ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r) 
                                == (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                             >> 0xfU)))))))));
    vlSelf->top__DOT__RISCV_inst__DOT__hz_ctrl_w = 
        ((((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_read_r) 
           & (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r) 
               == (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                            >> 0xfU))) | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r) 
                                          == (0x1fU 
                                              & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                 >> 0x14U))))) 
          | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_branch_r) 
             & (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_reg_write_r) 
                 & (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r) 
                     == (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                  >> 0xfU))) | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r) 
                                                == 
                                                (0x1fU 
                                                 & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                    >> 0x14U))))) 
                | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_read_r) 
                   & (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r) 
                       == (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                    >> 0xfU))) | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r) 
                                                  == 
                                                  (0x1fU 
                                                   & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                      >> 0x14U)))))))) 
         | ((0x67U == (0x707fU & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) 
            & (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r) 
                == (0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                             >> 0xfU))) | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_read_r) 
                                           & ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r) 
                                              == (0x1fU 
                                                  & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                     >> 0xfU)))))));
    vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w 
        = ((0U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__hz_ALU1_w))
            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r
            : ((1U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__hz_ALU1_w))
                ? vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w
                : ((2U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__hz_ALU1_w))
                    ? vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ALUresult_r
                    : 0U)));
    vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w 
        = ((0U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__hz_ALU2_w))
            ? vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd2_r
            : ((1U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__hz_ALU2_w))
                ? vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ALUresult_r
                : ((2U == (IData)(vlSelf->top__DOT__RISCV_inst__DOT__hz_ALU2_w))
                    ? vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w
                    : 0U)));
}

void Vtop___024root___eval_nba(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_nba\n"); );
    // Body
    if ((4ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtop___024root___nba_sequent__TOP__0(vlSelf);
        vlSelf->__Vm_traceActivity[1U] = 1U;
    }
    if ((2ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtop___024root___nba_sequent__TOP__1(vlSelf);
        vlSelf->__Vm_traceActivity[2U] = 1U;
    }
    if ((0x10ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtop___024root___nba_sequent__TOP__2(vlSelf);
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtop___024root___nba_sequent__TOP__3(vlSelf);
    }
    if ((8ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtop___024root___nba_sequent__TOP__4(vlSelf);
        vlSelf->__Vm_traceActivity[3U] = 1U;
    }
    if ((4ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtop___024root___nba_sequent__TOP__5(vlSelf);
        vlSelf->__Vm_traceActivity[4U] = 1U;
    }
    if ((2ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtop___024root___nba_sequent__TOP__6(vlSelf);
        vlSelf->__Vm_traceActivity[5U] = 1U;
    }
    if ((0xaULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtop___024root___nba_comb__TOP__0(vlSelf);
    }
    if ((4ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtop___024root___nba_sequent__TOP__7(vlSelf);
        vlSelf->__Vm_traceActivity[6U] = 1U;
    }
    if ((0x12ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtop___024root___nba_comb__TOP__1(vlSelf);
    }
    if ((1ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtop___024root___nba_sequent__TOP__8(vlSelf);
    }
    if ((6ULL & vlSelf->__VnbaTriggered.word(0U))) {
        Vtop___024root___nba_comb__TOP__2(vlSelf);
        vlSelf->__Vm_traceActivity[7U] = 1U;
    }
}

void Vtop___024root___eval_triggers__act(Vtop___024root* vlSelf);

bool Vtop___024root___eval_phase__act(Vtop___024root* vlSelf) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root___eval_phase__act\n"); );
    // Init
    VlTriggerVec<5> __VpreTriggered;
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
    IData/*31:0*/ __VnbaIterCount;
    CData/*0:0*/ __VnbaContinue;
    // Body
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
}
#endif  // VL_DEBUG
