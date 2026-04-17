// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_fst_c.h"
#include "Vtop__Syms.h"


void Vtop___024root__trace_chg_0_sub_0(Vtop___024root* vlSelf, VerilatedFst::Buffer* bufp);

void Vtop___024root__trace_chg_0(void* voidSelf, VerilatedFst::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_chg_0\n"); );
    // Init
    Vtop___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtop___024root*>(voidSelf);
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    if (VL_UNLIKELY(!vlSymsp->__Vm_activity)) return;
    // Body
    Vtop___024root__trace_chg_0_sub_0((&vlSymsp->TOP), bufp);
}

void Vtop___024root__trace_chg_0_sub_0(Vtop___024root* vlSelf, VerilatedFst::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_chg_0_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode + 1);
    // Body
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[1U])) {
        bufp->chgIData(oldp+0,(((IData)(4U) + vlSelf->top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r)),32);
        bufp->chgIData(oldp+1,(vlSelf->top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r),32);
        bufp->chgIData(oldp+2,(((vlSelf->top__DOT__IF_stage_inst__DOT__IMEM_inst0__DOT__imem
                                 [(0x3ffU & vlSelf->top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r)] 
                                 << 0x18U) | ((vlSelf->top__DOT__IF_stage_inst__DOT__IMEM_inst0__DOT__imem
                                               [(0x3ffU 
                                                 & ((IData)(1U) 
                                                    + vlSelf->top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r))] 
                                               << 0x10U) 
                                              | ((vlSelf->top__DOT__IF_stage_inst__DOT__IMEM_inst0__DOT__imem
                                                  [
                                                  (0x3ffU 
                                                   & ((IData)(2U) 
                                                      + vlSelf->top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r))] 
                                                  << 8U) 
                                                 | vlSelf->top__DOT__IF_stage_inst__DOT__IMEM_inst0__DOT__imem
                                                 [(0x3ffU 
                                                   & ((IData)(3U) 
                                                      + vlSelf->top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r))])))),32);
        bufp->chgIData(oldp+3,(vlSelf->top__DOT__IF_stage_inst__DOT__addr_current_r),32);
        bufp->chgIData(oldp+4,(vlSelf->top__DOT__IF_stage_inst__DOT__instruction_r),32);
    }
    bufp->chgBit(oldp+5,(vlSelf->clk_i));
    bufp->chgBit(oldp+6,(vlSelf->rstn_i));
    bufp->chgBit(oldp+7,(vlSelf->branch_i));
    bufp->chgBit(oldp+8,(vlSelf->flush_i));
    bufp->chgBit(oldp+9,(vlSelf->write_PC_en_i));
    bufp->chgIData(oldp+10,(vlSelf->addr_branch_i),32);
    bufp->chgIData(oldp+11,(vlSelf->instruction_o),32);
    bufp->chgIData(oldp+12,(vlSelf->addr_current_o),32);
    bufp->chgBit(oldp+13,(vlSelf->top__DOT__clk_l));
    bufp->chgBit(oldp+14,(vlSelf->top__DOT__rstn_l));
    bufp->chgIData(oldp+15,(((IData)(vlSelf->branch_i)
                              ? vlSelf->addr_branch_i
                              : ((IData)(4U) + vlSelf->top__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r))),32);
}

void Vtop___024root__trace_cleanup(void* voidSelf, VerilatedFst* /*unused*/) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_cleanup\n"); );
    // Init
    Vtop___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtop___024root*>(voidSelf);
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    vlSymsp->__Vm_activity = false;
    vlSymsp->TOP.__Vm_traceActivity[0U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[1U] = 0U;
}
