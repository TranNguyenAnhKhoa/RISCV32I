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
        bufp->chgIData(oldp+0,(vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r),32);
        bufp->chgBit(oldp+1,(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__branch_r));
        bufp->chgBit(oldp+2,(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_read_r));
        bufp->chgBit(oldp+3,(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_to_reg_r));
        bufp->chgBit(oldp+4,(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_write_r));
        bufp->chgBit(oldp+5,(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUsrc_r));
        bufp->chgBit(oldp+6,(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__reg_write_r));
        bufp->chgCData(oldp+7,(vlSelf->top__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r),2);
    }
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[2U])) {
        bufp->chgIData(oldp+8,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r1_q),32);
        bufp->chgIData(oldp+9,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r2_q),32);
        bufp->chgIData(oldp+10,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r3_q),32);
        bufp->chgIData(oldp+11,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r4_q),32);
        bufp->chgIData(oldp+12,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r5_q),32);
        bufp->chgIData(oldp+13,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r6_q),32);
        bufp->chgIData(oldp+14,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r7_q),32);
        bufp->chgIData(oldp+15,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r8_q),32);
        bufp->chgIData(oldp+16,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r9_q),32);
        bufp->chgIData(oldp+17,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r10_q),32);
        bufp->chgIData(oldp+18,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r11_q),32);
        bufp->chgIData(oldp+19,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r12_q),32);
        bufp->chgIData(oldp+20,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r13_q),32);
        bufp->chgIData(oldp+21,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r14_q),32);
        bufp->chgIData(oldp+22,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r15_q),32);
        bufp->chgIData(oldp+23,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r16_q),32);
        bufp->chgIData(oldp+24,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r17_q),32);
        bufp->chgIData(oldp+25,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r18_q),32);
        bufp->chgIData(oldp+26,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r19_q),32);
        bufp->chgIData(oldp+27,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r20_q),32);
        bufp->chgIData(oldp+28,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r21_q),32);
        bufp->chgIData(oldp+29,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r22_q),32);
        bufp->chgIData(oldp+30,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r23_q),32);
        bufp->chgIData(oldp+31,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r24_q),32);
        bufp->chgIData(oldp+32,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r25_q),32);
        bufp->chgIData(oldp+33,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r26_q),32);
        bufp->chgIData(oldp+34,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r27_q),32);
        bufp->chgIData(oldp+35,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r28_q),32);
        bufp->chgIData(oldp+36,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r29_q),32);
        bufp->chgIData(oldp+37,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r30_q),32);
        bufp->chgIData(oldp+38,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r31_q),32);
    }
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[3U])) {
        bufp->chgIData(oldp+39,(vlSelf->top__DOT__ID_stage_inst__DOT__addr_current_r),32);
        bufp->chgBit(oldp+40,(vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_branch_r));
        bufp->chgBit(oldp+41,(vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_mem_read_r));
        bufp->chgBit(oldp+42,(vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_mem_to_reg_r));
        bufp->chgBit(oldp+43,(vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_mem_write_r));
        bufp->chgBit(oldp+44,(vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_ALUsrc_r));
        bufp->chgBit(oldp+45,(vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_reg_write_r));
        bufp->chgCData(oldp+46,(vlSelf->top__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r),2);
        bufp->chgIData(oldp+47,(vlSelf->top__DOT__ID_stage_inst__DOT__imm_gen_r),32);
        bufp->chgBit(oldp+48,(vlSelf->top__DOT__ID_stage_inst__DOT__funct7_30_r));
        bufp->chgCData(oldp+49,(vlSelf->top__DOT__ID_stage_inst__DOT__funct3_r),3);
        bufp->chgCData(oldp+50,(vlSelf->top__DOT__ID_stage_inst__DOT__rs1_r),5);
        bufp->chgCData(oldp+51,(vlSelf->top__DOT__ID_stage_inst__DOT__rs2_r),5);
        bufp->chgCData(oldp+52,(vlSelf->top__DOT__ID_stage_inst__DOT__rd_r),5);
        bufp->chgIData(oldp+53,(vlSelf->top__DOT__ID_stage_inst__DOT__rd1_r),32);
        bufp->chgIData(oldp+54,(vlSelf->top__DOT__ID_stage_inst__DOT__rd2_r),32);
    }
    bufp->chgBit(oldp+55,(vlSelf->clk_i));
    bufp->chgBit(oldp+56,(vlSelf->rstn_i));
    bufp->chgIData(oldp+57,(vlSelf->instruction_i),32);
    bufp->chgIData(oldp+58,(vlSelf->addr_current_i),32);
    bufp->chgIData(oldp+59,(vlSelf->write_back_data_i),32);
    bufp->chgCData(oldp+60,(vlSelf->write_rd_i),5);
    bufp->chgBit(oldp+61,(vlSelf->hz_ctrl_i));
    bufp->chgBit(oldp+62,(vlSelf->reg_write_en_i));
    bufp->chgBit(oldp+63,(vlSelf->ctrl_branch_o));
    bufp->chgBit(oldp+64,(vlSelf->ctrl_mem_read_o));
    bufp->chgBit(oldp+65,(vlSelf->ctrl_mem_to_reg_o));
    bufp->chgBit(oldp+66,(vlSelf->ctrl_mem_write_o));
    bufp->chgBit(oldp+67,(vlSelf->ctrl_ALUsrc_o));
    bufp->chgBit(oldp+68,(vlSelf->ctrl_reg_write_o));
    bufp->chgCData(oldp+69,(vlSelf->ctrl_ALUOp_o),2);
    bufp->chgIData(oldp+70,(vlSelf->rd1_o),32);
    bufp->chgIData(oldp+71,(vlSelf->rd2_o),32);
    bufp->chgIData(oldp+72,(vlSelf->addr_current_o),32);
    bufp->chgIData(oldp+73,(vlSelf->imm_gen_o),32);
    bufp->chgBit(oldp+74,(vlSelf->top__DOT__clk_l));
    bufp->chgBit(oldp+75,(vlSelf->top__DOT__rstn_l));
    bufp->chgIData(oldp+76,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__rs1_value_r),32);
    bufp->chgIData(oldp+77,(vlSelf->top__DOT__ID_stage_inst__DOT__RF_inst0__DOT__rs2_value_r),32);
    bufp->chgCData(oldp+78,((0x1fU & (vlSelf->instruction_i 
                                      >> 0xfU))),5);
    bufp->chgCData(oldp+79,((0x1fU & (vlSelf->instruction_i 
                                      >> 0x14U))),5);
    bufp->chgCData(oldp+80,((0x7fU & vlSelf->instruction_i)),7);
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
    vlSymsp->TOP.__Vm_traceActivity[2U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[3U] = 0U;
}
