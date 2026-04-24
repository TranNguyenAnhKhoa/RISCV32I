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
        bufp->chgBit(oldp+0,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_read_r));
        bufp->chgBit(oldp+1,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_to_reg_r));
        bufp->chgBit(oldp+2,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_write_r));
        bufp->chgBit(oldp+3,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_reg_write_r));
        bufp->chgCData(oldp+4,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__funct3_r),3);
        bufp->chgIData(oldp+5,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r),32);
        bufp->chgIData(oldp+6,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_r),32);
        bufp->chgBit(oldp+7,(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ctrl_mem_to_reg_r));
        bufp->chgBit(oldp+8,(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ctrl_reg_write_r));
        bufp->chgIData(oldp+9,(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_data_r),32);
        bufp->chgIData(oldp+10,(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ALUresult_r),32);
        bufp->chgIData(oldp+11,(VL_SHIFTR_III(32,32,32, vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r, 2U)),32);
    }
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[2U])) {
        bufp->chgIData(oldp+12,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r1_q),32);
        bufp->chgIData(oldp+13,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r2_q),32);
        bufp->chgIData(oldp+14,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r3_q),32);
        bufp->chgIData(oldp+15,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r4_q),32);
        bufp->chgIData(oldp+16,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r5_q),32);
        bufp->chgIData(oldp+17,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r6_q),32);
        bufp->chgIData(oldp+18,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r7_q),32);
        bufp->chgIData(oldp+19,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r8_q),32);
        bufp->chgIData(oldp+20,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r9_q),32);
        bufp->chgIData(oldp+21,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r10_q),32);
        bufp->chgIData(oldp+22,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r11_q),32);
        bufp->chgIData(oldp+23,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r12_q),32);
        bufp->chgIData(oldp+24,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r13_q),32);
        bufp->chgIData(oldp+25,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r14_q),32);
        bufp->chgIData(oldp+26,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r15_q),32);
        bufp->chgIData(oldp+27,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r16_q),32);
        bufp->chgIData(oldp+28,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r17_q),32);
        bufp->chgIData(oldp+29,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r18_q),32);
        bufp->chgIData(oldp+30,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r19_q),32);
        bufp->chgIData(oldp+31,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r20_q),32);
        bufp->chgIData(oldp+32,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r21_q),32);
        bufp->chgIData(oldp+33,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r22_q),32);
        bufp->chgIData(oldp+34,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r23_q),32);
        bufp->chgIData(oldp+35,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r24_q),32);
        bufp->chgIData(oldp+36,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r25_q),32);
        bufp->chgIData(oldp+37,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r26_q),32);
        bufp->chgIData(oldp+38,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r27_q),32);
        bufp->chgIData(oldp+39,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r28_q),32);
        bufp->chgIData(oldp+40,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r29_q),32);
        bufp->chgIData(oldp+41,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r30_q),32);
        bufp->chgIData(oldp+42,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r31_q),32);
    }
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[3U])) {
        bufp->chgBit(oldp+43,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_branch_r));
        bufp->chgBit(oldp+44,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_read_r));
        bufp->chgBit(oldp+45,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_to_reg_r));
        bufp->chgBit(oldp+46,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_write_r));
        bufp->chgCData(oldp+47,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r),2);
        bufp->chgBit(oldp+48,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_reg_write_r));
        bufp->chgIData(oldp+49,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r),32);
        bufp->chgIData(oldp+50,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd2_r),32);
        bufp->chgIData(oldp+51,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__addr_current_r),32);
        bufp->chgIData(oldp+52,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_r),32);
        bufp->chgBit(oldp+53,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct7_30_r));
        bufp->chgCData(oldp+54,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r),3);
        bufp->chgCData(oldp+55,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rs1_r),5);
        bufp->chgCData(oldp+56,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rs2_r),5);
        bufp->chgIData(oldp+57,((vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__addr_current_r 
                                 + vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_r)),32);
        bufp->chgBit(oldp+58,((((4U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))
                                 ? ((2U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))
                                     ? (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r)
                                     : ((1U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))
                                         ? (((vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                              >> 0x1fU) 
                                             == (vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                                 >> 0x1fU)) 
                                            || (vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                                >> 0x1fU))
                                         : (((vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                              >> 0x1fU) 
                                             != (vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                                 >> 0x1fU)) 
                                            && (vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                                >> 0x1fU))))
                                 : ((1U & (~ ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r) 
                                              >> 1U))) 
                                    && (1U & (~ (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))))) 
                               & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_branch_r))));
        bufp->chgBit(oldp+59,((1U & ((4U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))
                                      ? ((2U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))
                                          ? (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r)
                                          : ((1U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))
                                              ? (((vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                                   >> 0x1fU) 
                                                  == 
                                                  (vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                                   >> 0x1fU)) 
                                                 || (vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                                     >> 0x1fU))
                                              : (((vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                                   >> 0x1fU) 
                                                  != 
                                                  (vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                                   >> 0x1fU)) 
                                                 && (vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                                     >> 0x1fU))))
                                      : ((1U & (~ ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r) 
                                                   >> 1U))) 
                                         && (1U & (~ (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))))))));
        bufp->chgCData(oldp+60,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w),4);
    }
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[4U])) {
        bufp->chgCData(oldp+61,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r),5);
        bufp->chgCData(oldp+62,(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r),5);
        bufp->chgIData(oldp+63,(vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w),32);
    }
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[5U])) {
        bufp->chgCData(oldp+64,(vlSelf->top__DOT__RISCV_inst__DOT__hz_ALU1_w),2);
        bufp->chgCData(oldp+65,(vlSelf->top__DOT__RISCV_inst__DOT__hz_ALU2_w),2);
        bufp->chgIData(oldp+66,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w),32);
        bufp->chgIData(oldp+67,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w),32);
        bufp->chgIData(oldp+68,((vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w 
                                 - vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w)),32);
    }
    if (VL_UNLIKELY(vlSelf->__Vm_traceActivity[6U])) {
        bufp->chgIData(oldp+69,(vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r),32);
        bufp->chgIData(oldp+70,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r),32);
        bufp->chgBit(oldp+71,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__branch_r));
        bufp->chgBit(oldp+72,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_read_r));
        bufp->chgBit(oldp+73,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_to_reg_r));
        bufp->chgBit(oldp+74,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_write_r));
        bufp->chgBit(oldp+75,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__reg_write_r));
        bufp->chgCData(oldp+76,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r),2);
        bufp->chgCData(oldp+77,((0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                          >> 0xfU))),5);
        bufp->chgCData(oldp+78,((0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                          >> 0x14U))),5);
        bufp->chgCData(oldp+79,((0x7fU & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)),7);
        bufp->chgBit(oldp+80,((0x67U == (0x707fU & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r))));
    }
    bufp->chgBit(oldp+81,(vlSelf->clk_i));
    bufp->chgBit(oldp+82,(vlSelf->rstn_i));
    bufp->chgBit(oldp+83,(vlSelf->top__DOT__clk_l));
    bufp->chgBit(oldp+84,(vlSelf->top__DOT__rstn_l));
    bufp->chgIData(oldp+85,(vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__addr_current_r),32);
    bufp->chgCData(oldp+86,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r),5);
    bufp->chgBit(oldp+87,(vlSelf->top__DOT__RISCV_inst__DOT__hz_flush_w));
    bufp->chgBit(oldp+88,((1U & (~ ((((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_read_r) 
                                      & (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r) 
                                          == (0x1fU 
                                              & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                 >> 0xfU))) 
                                         | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r) 
                                            == (0x1fU 
                                                & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                   >> 0x14U))))) 
                                     | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_branch_r) 
                                        & (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_reg_write_r) 
                                            & (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r) 
                                                == 
                                                (0x1fU 
                                                 & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                    >> 0xfU))) 
                                               | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r) 
                                                  == 
                                                  (0x1fU 
                                                   & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                      >> 0x14U))))) 
                                           | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_read_r) 
                                              & (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r) 
                                                  == 
                                                  (0x1fU 
                                                   & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                      >> 0xfU))) 
                                                 | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r) 
                                                    == 
                                                    (0x1fU 
                                                     & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                        >> 0x14U)))))))) 
                                    | ((0x67U == (0x707fU 
                                                  & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)) 
                                       & (((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r) 
                                           == (0x1fU 
                                               & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                  >> 0xfU))) 
                                          | ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_read_r) 
                                             & ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r) 
                                                == 
                                                (0x1fU 
                                                 & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                                    >> 0xfU)))))))))));
    bufp->chgBit(oldp+89,(vlSelf->top__DOT__RISCV_inst__DOT__hz_ctrl_w));
    bufp->chgIData(oldp+90,(((8U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                              ? ((4U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                                  ? ((2U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                                      ? 0xdeadU : (
                                                   (1U 
                                                    & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                                                    ? 
                                                   (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w 
                                                    >> 
                                                    (0x1fU 
                                                     & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w))
                                                    : 0xdeadU))
                                  : ((2U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                                      ? 0xdeadU : (
                                                   (1U 
                                                    & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                                                    ? 0xdeadU
                                                    : 
                                                   (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w 
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
                                             >> (0x1fU 
                                                 & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w))
                                          : (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w 
                                             ^ vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w)))
                                  : ((2U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                                      ? 0xdeadU : (
                                                   (1U 
                                                    & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                                                    ? 
                                                   (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w 
                                                    << 
                                                    (0x1fU 
                                                     & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w))
                                                    : 
                                                   (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w 
                                                    + vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w)))))),32);
    bufp->chgIData(oldp+91,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__rs1_value_r),32);
    bufp->chgIData(oldp+92,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__rs2_value_r),32);
    bufp->chgIData(oldp+93,(((((4U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))
                                ? ((2U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))
                                    ? (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r)
                                    : ((1U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))
                                        ? (((vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                             >> 0x1fU) 
                                            == (vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                                >> 0x1fU)) 
                                           || (vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                               >> 0x1fU))
                                        : (((vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                             >> 0x1fU) 
                                            != (vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                                >> 0x1fU)) 
                                           && (vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r 
                                               >> 0x1fU))))
                                : ((1U & (~ ((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r) 
                                             >> 1U))) 
                                   && (1U & (~ (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))))) 
                              & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_branch_r))
                              ? (vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__addr_current_r 
                                 + vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_r)
                              : ((IData)(4U) + vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r))),32);
    bufp->chgIData(oldp+94,(vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r),32);
    bufp->chgIData(oldp+95,(((vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__IMEM_inst0__DOT__imem
                              [(0x3ffU & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r)] 
                              << 0x18U) | ((vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__IMEM_inst0__DOT__imem
                                            [(0x3ffU 
                                              & ((IData)(1U) 
                                                 + vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r))] 
                                            << 0x10U) 
                                           | ((vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__IMEM_inst0__DOT__imem
                                               [(0x3ffU 
                                                 & ((IData)(2U) 
                                                    + vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r))] 
                                               << 8U) 
                                              | vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__IMEM_inst0__DOT__imem
                                              [(0x3ffU 
                                                & ((IData)(3U) 
                                                   + vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r))])))),32);
    bufp->chgIData(oldp+96,((vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out0 
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
                                                                    | vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out15))))))))))))))),32);
    bufp->chgCData(oldp+97,(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3
                            [(0x3fU & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r)]),8);
    bufp->chgCData(oldp+98,(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2
                            [(0x3fU & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r)]),8);
    bufp->chgCData(oldp+99,(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1
                            [(0x3fU & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r)]),8);
    bufp->chgCData(oldp+100,(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0
                             [(0x3fU & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r)]),8);
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
    vlSymsp->TOP.__Vm_traceActivity[4U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[5U] = 0U;
    vlSymsp->TOP.__Vm_traceActivity[6U] = 0U;
}
