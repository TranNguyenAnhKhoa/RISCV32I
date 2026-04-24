// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_fst_c.h"
#include "Vtop__Syms.h"


VL_ATTR_COLD void Vtop___024root__trace_init_sub__TOP__0(Vtop___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_init_sub__TOP__0\n"); );
    // Init
    const int c = vlSymsp->__Vm_baseCode;
    // Body
    tracep->declBit(c+82,0,"clk_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+83,0,"rstn_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("top", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+82,0,"clk_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+83,0,"rstn_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+84,0,"clk_l",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+85,0,"rstn_l",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("RISCV_inst", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+84,0,"clk_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+85,0,"rstn_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+70,0,"instr_IF_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+86,0,"addr_IF_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+44,0,"ctrl_branch_ID_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+45,0,"ctrl_mem_read_ID_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+46,0,"ctrl_mem_to_reg_ID_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+47,0,"ctrl_mem_write_ID_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+48,0,"ctrl_ALUOp_ID_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBit(c+49,0,"ctrl_reg_write_ID_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+50,0,"rd1_ID_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+51,0,"rd2_ID_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+52,0,"addr_current_ID_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+53,0,"imm_gen_ID_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+54,0,"funct7_30_ID_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+55,0,"funct3_ID_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+56,0,"rs1_ID_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+57,0,"rs2_ID_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+87,0,"write_rd_ID_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+58,0,"addr_branch_EXE_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+1,0,"ctrl_mem_read_EXE_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+2,0,"ctrl_mem_to_reg_EXE_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+3,0,"ctrl_mem_write_EXE_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+4,0,"ctrl_reg_write_EXE_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+5,0,"funct3_EXE_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+62,0,"write_rd_EXE_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+6,0,"ALUresult_EXE_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+7,0,"ALU2_i_EXE_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+59,0,"is_branch_EXE_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+102,0,"write_IDEX_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+103,0,"write_PC_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+8,0,"ctrl_mem_to_reg_MEM_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+9,0,"ctrl_reg_write_MEM_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+10,0,"DMEM_data_MEM_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+11,0,"ALUresult_MEM_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+104,0,"addr_branch_MEM_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+63,0,"write_rd_MEM_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+105,0,"funct3_MEM_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+64,0,"data_WB_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+88,0,"hz_flush_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+89,0,"hz_write_PC_en_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+90,0,"hz_ctrl_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+65,0,"hz_ALU1_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+66,0,"hz_ALU2_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->pushPrefix("EXE_stage_inst", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+84,0,"clk_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+85,0,"rstn_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+44,0,"ctrl_branch_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+45,0,"ctrl_mem_read_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+46,0,"ctrl_mem_to_reg_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+47,0,"ctrl_mem_write_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+49,0,"ctrl_reg_write_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+48,0,"ctrl_ALUOp_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+52,0,"addr_current_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+50,0,"rd1_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+51,0,"rd2_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+53,0,"imm_gen_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+54,0,"funct7_30_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+55,0,"funct3_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+11,0,"ALUresult_MEM_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+64,0,"data_wb_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+65,0,"hz_sel_ALU1_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+66,0,"hz_sel_ALU2_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+87,0,"write_rd_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBit(c+1,0,"ctrl_mem_read_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+2,0,"ctrl_mem_to_reg_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+3,0,"ctrl_mem_write_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+4,0,"ctrl_reg_write_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+58,0,"addr_branch_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+59,0,"is_branch_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+6,0,"ALUresult_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+7,0,"ALU2_i_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+5,0,"funct3_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+62,0,"write_rd_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBit(c+106,0,"ctrl_mem_read_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+107,0,"ctrl_mem_to_reg_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+108,0,"ctrl_mem_write_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+109,0,"ctrl_reg_write_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+60,0,"branch_taken_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+67,0,"ALU1_i_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+68,0,"ALU2_i_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+61,0,"ALUctrl_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBus(c+91,0,"ALUresult_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+1,0,"ctrl_mem_read_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+2,0,"ctrl_mem_to_reg_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+3,0,"ctrl_mem_write_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+4,0,"ctrl_reg_write_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+7,0,"ALU2_i_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+6,0,"ALUresult_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+5,0,"funct3_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+62,0,"write_rd_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->pushPrefix("ALU_control_inst0", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+48,0,"ALUOp_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+55,0,"funct3_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBit(c+54,0,"funct7_30_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+61,0,"ALUctrl_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->popPrefix();
    tracep->pushPrefix("ALU_inst0", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+67,0,"A_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+68,0,"B_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+61,0,"op_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 3,0);
    tracep->declBus(c+91,0,"result_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+69,0,"sub_res_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+91,0,"result_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->popPrefix();
    tracep->pushPrefix("comparator_inst0", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+50,0,"A_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+50,0,"B_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+55,0,"funct3_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBit(c+60,0,"branch_taken_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+110,0,"equal_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+111,0,"slt_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+112,0,"ult_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+60,0,"branch_taken_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+113,0,"equal",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+114,0,"not_equal",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+115,0,"less_than",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+116,0,"greater_than_or_eq",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+117,0,"less_than_u",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+118,0,"greater_than_or_eq_u",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("ID_stage_inst", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+84,0,"clk_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+85,0,"rstn_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+70,0,"instruction_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+86,0,"addr_current_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+64,0,"write_back_data_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+63,0,"write_rd_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBit(c+90,0,"hz_ctrl_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+9,0,"reg_write_en_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+44,0,"ctrl_branch_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+45,0,"ctrl_mem_read_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+46,0,"ctrl_mem_to_reg_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+47,0,"ctrl_mem_write_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+49,0,"ctrl_reg_write_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+48,0,"ctrl_ALUOp_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+50,0,"rd1_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+51,0,"rd2_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+52,0,"addr_current_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+53,0,"imm_gen_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+54,0,"funct7_30_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+55,0,"funct3_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+56,0,"rs1_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+57,0,"rs2_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+87,0,"write_rd_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+70,0,"instruction_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+119,0,"addr_current_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+120,0,"w_addr_branch",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+121,0,"addr_next_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+92,0,"rd1_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+93,0,"rd2_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+71,0,"imm_gen_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+72,0,"ctrl_branch_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+73,0,"ctrl_mem_read_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+74,0,"ctrl_mem_to_reg_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+75,0,"ctrl_mem_write_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+76,0,"ctrl_reg_write_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+77,0,"ctrl_ALUOp_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+52,0,"addr_current_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+122,0,"instruction_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+44,0,"ctrl_branch_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+45,0,"ctrl_mem_read_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+46,0,"ctrl_mem_to_reg_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+47,0,"ctrl_mem_write_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+49,0,"ctrl_reg_write_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+48,0,"ctrl_ALUOp_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+53,0,"imm_gen_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+54,0,"funct7_30_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+55,0,"funct3_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+56,0,"rs1_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+57,0,"rs2_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+87,0,"write_rd_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+50,0,"rd1_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+51,0,"rd2_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->pushPrefix("RF_inst0", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+84,0,"clk_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+85,0,"rstn_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+78,0,"rs1_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+79,0,"rs2_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+63,0,"rd_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+64,0,"rd_value_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+9,0,"reg_write_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+92,0,"read_rs1_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+93,0,"read_rs2_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+13,0,"reg_r1_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+14,0,"reg_r2_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+15,0,"reg_r3_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+16,0,"reg_r4_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+17,0,"reg_r5_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+18,0,"reg_r6_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+19,0,"reg_r7_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+20,0,"reg_r8_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+21,0,"reg_r9_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+22,0,"reg_r10_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+23,0,"reg_r11_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+24,0,"reg_r12_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+25,0,"reg_r13_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+26,0,"reg_r14_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+27,0,"reg_r15_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+28,0,"reg_r16_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+29,0,"reg_r17_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+30,0,"reg_r18_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+31,0,"reg_r19_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+32,0,"reg_r20_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+33,0,"reg_r21_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+34,0,"reg_r22_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+35,0,"reg_r23_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+36,0,"reg_r24_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+37,0,"reg_r25_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+38,0,"reg_r26_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+39,0,"reg_r27_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+40,0,"reg_r28_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+41,0,"reg_r29_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+42,0,"reg_r30_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+43,0,"reg_r31_q",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+123,0,"x0_zero_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+13,0,"x1_ra_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+14,0,"x2_sp_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+15,0,"x3_gp_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+16,0,"x4_tp_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+17,0,"x5_t0_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+18,0,"x6_t1_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+19,0,"x7_t2_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+20,0,"x8_s0_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+21,0,"x9_s1_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+22,0,"x10_a0_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+23,0,"x11_a1_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+24,0,"x12_a2_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+25,0,"x13_a3_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+26,0,"x14_a4_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+27,0,"x15_a5_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+28,0,"x16_a6_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+29,0,"x17_a7_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+30,0,"x18_s2_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+31,0,"x19_s3_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+32,0,"x20_s4_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+33,0,"x21_s5_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+34,0,"x22_s6_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+35,0,"x23_s7_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+36,0,"x24_s8_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+37,0,"x25_s9_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+38,0,"x26_s10_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+39,0,"x27_s11_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+40,0,"x28_t3_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+41,0,"x29_t4_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+42,0,"x30_t5_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+43,0,"x31_t6_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+92,0,"rs1_value_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+93,0,"rs2_value_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->popPrefix();
    tracep->pushPrefix("controller_inst0", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+70,0,"instruction_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+72,0,"branch_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+73,0,"mem_read_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+74,0,"mem_to_reg_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+75,0,"mem_write_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+76,0,"reg_write_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+77,0,"ALUOp_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+124,0,"Load",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+125,0,"jalr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+126,0,"Imm_A_L",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+127,0,"R_type",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+128,0,"Store",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+129,0,"B_type",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+130,0,"Lui",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+131,0,"auipc",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+132,0,"jal",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBus(c+80,0,"opcode",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 6,0);
    tracep->declBit(c+72,0,"branch_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+73,0,"mem_read_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+74,0,"mem_to_reg_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+75,0,"mem_write_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+76,0,"reg_write_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+77,0,"ALUOp_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->popPrefix();
    tracep->pushPrefix("imm_gen_inst0", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+70,0,"instruction_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+71,0,"output_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+71,0,"output_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+133,0,"R_type",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+134,0,"I_type1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+135,0,"I_type2",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+136,0,"I_type3",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+137,0,"S_type",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+138,0,"B_type",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+139,0,"U_type",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+140,0,"J_type",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("IF_stage_inst", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+84,0,"clk_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+85,0,"rstn_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+59,0,"branch_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+88,0,"flush_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+89,0,"write_PC_en_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+58,0,"addr_branch_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+70,0,"instruction_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+86,0,"addr_current_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+94,0,"addr_next_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+95,0,"addr_current_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+96,0,"instruction_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+86,0,"addr_current_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+70,0,"instruction_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->pushPrefix("IMEM_inst0", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+95,0,"address_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+96,0,"instruction_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->popPrefix();
    tracep->pushPrefix("PC_inst0", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+84,0,"clk_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+85,0,"rstn_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+89,0,"write_en_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+94,0,"PC_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+95,0,"PC_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+95,0,"PC_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("MEM_stage_inst", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+84,0,"clk_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+85,0,"rstn_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+1,0,"ctrl_mem_read_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+3,0,"ctrl_mem_write_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+4,0,"ctrl_reg_write_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+2,0,"ctrl_mem_to_reg_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+6,0,"ALUresult_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+7,0,"ALU2i_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+62,0,"write_rd_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+5,0,"funct3_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBit(c+8,0,"ctrl_mem_to_reg_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+9,0,"ctrl_reg_write_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+10,0,"DMEM_data_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+11,0,"ALUresult_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+63,0,"write_rd_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBit(c+141,0,"ctrl_reg_write_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+142,0,"ctrl_mem_to_reg_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+97,0,"DMEM_data_w",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+11,0,"ALUresult_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+10,0,"DMEM_data_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+63,0,"write_rd_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBit(c+9,0,"ctrl_reg_write_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+8,0,"ctrl_mem_to_reg_r",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::VAR, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->pushPrefix("DMEM_inst0", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+84,0,"clk_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+6,0,"address_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+7,0,"data_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBit(c+3,0,"mem_write_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+1,0,"mem_read_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+5,0,"funct3_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+97,0,"data_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->declBus(c+113,0,"sb_lb",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+114,0,"sh_lh",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+143,0,"sw_lw",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+115,0,"lbu",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+116,0,"lhu",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::PARAMETER, VerilatedTraceSigType::LOGIC, false,-1, 2,0);
    tracep->declBus(c+98,0,"w_bank3",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+99,0,"w_bank2",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+100,0,"w_bank1",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+101,0,"w_bank0",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 7,0);
    tracep->declBus(c+12,0,"w_idx_addr",-1, VerilatedTraceSigDirection::NONE, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 31,0);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->pushPrefix("forwarding_inst", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBit(c+4,0,"reg_write_EXMEM_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+9,0,"reg_write_MEMWB_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBus(c+56,0,"rs1_IDEX_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+57,0,"rs2_IDEX_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+62,0,"rd_EXMEM_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+63,0,"rd_MEMWB_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+65,0,"mux_ALU1_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->declBus(c+66,0,"mux_ALU2_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 1,0);
    tracep->popPrefix();
    tracep->pushPrefix("hazard_detection_inst", VerilatedTracePrefixType::SCOPE_MODULE);
    tracep->declBus(c+78,0,"rs1_IFID_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+79,0,"rs2_IFID_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+87,0,"rd_IDEX_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBus(c+62,0,"rd_EXMEM_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1, 4,0);
    tracep->declBit(c+49,0,"write_reg_IDEX_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+45,0,"mem_read_IDEX_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+1,0,"mem_read_EXMEM_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+44,0,"branch_ID_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+81,0,"is_jalr_i",-1, VerilatedTraceSigDirection::INPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+88,0,"write_IDEX_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+89,0,"write_PC_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->declBit(c+90,0,"control_mux_o",-1, VerilatedTraceSigDirection::OUTPUT, VerilatedTraceSigKind::WIRE, VerilatedTraceSigType::LOGIC, false,-1);
    tracep->popPrefix();
    tracep->popPrefix();
    tracep->popPrefix();
}

VL_ATTR_COLD void Vtop___024root__trace_init_top(Vtop___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_init_top\n"); );
    // Body
    Vtop___024root__trace_init_sub__TOP__0(vlSelf, tracep);
}

VL_ATTR_COLD void Vtop___024root__trace_const_0(void* voidSelf, VerilatedFst::Buffer* bufp);
VL_ATTR_COLD void Vtop___024root__trace_full_0(void* voidSelf, VerilatedFst::Buffer* bufp);
void Vtop___024root__trace_chg_0(void* voidSelf, VerilatedFst::Buffer* bufp);
void Vtop___024root__trace_cleanup(void* voidSelf, VerilatedFst* /*unused*/);

VL_ATTR_COLD void Vtop___024root__trace_register(Vtop___024root* vlSelf, VerilatedFst* tracep) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_register\n"); );
    // Body
    tracep->addConstCb(&Vtop___024root__trace_const_0, 0U, vlSelf);
    tracep->addFullCb(&Vtop___024root__trace_full_0, 0U, vlSelf);
    tracep->addChgCb(&Vtop___024root__trace_chg_0, 0U, vlSelf);
    tracep->addCleanupCb(&Vtop___024root__trace_cleanup, vlSelf);
}

VL_ATTR_COLD void Vtop___024root__trace_const_0_sub_0(Vtop___024root* vlSelf, VerilatedFst::Buffer* bufp);

VL_ATTR_COLD void Vtop___024root__trace_const_0(void* voidSelf, VerilatedFst::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_const_0\n"); );
    // Init
    Vtop___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtop___024root*>(voidSelf);
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vtop___024root__trace_const_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vtop___024root__trace_const_0_sub_0(Vtop___024root* vlSelf, VerilatedFst::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_const_0_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullBit(oldp+102,(vlSelf->top__DOT__RISCV_inst__DOT__write_IDEX_w));
    bufp->fullBit(oldp+103,(vlSelf->top__DOT__RISCV_inst__DOT__write_PC_w));
    bufp->fullIData(oldp+104,(vlSelf->top__DOT__RISCV_inst__DOT__addr_branch_MEM_w),32);
    bufp->fullCData(oldp+105,(vlSelf->top__DOT__RISCV_inst__DOT__funct3_MEM_w),3);
    bufp->fullBit(oldp+106,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_read_w));
    bufp->fullBit(oldp+107,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_to_reg_w));
    bufp->fullBit(oldp+108,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_write_w));
    bufp->fullBit(oldp+109,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_reg_write_w));
    bufp->fullBit(oldp+110,(1U));
    bufp->fullBit(oldp+111,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__comparator_inst0__DOT__slt_w));
    bufp->fullBit(oldp+112,(0U));
    bufp->fullCData(oldp+113,(0U),3);
    bufp->fullCData(oldp+114,(1U),3);
    bufp->fullCData(oldp+115,(4U),3);
    bufp->fullCData(oldp+116,(5U),3);
    bufp->fullCData(oldp+117,(6U),3);
    bufp->fullCData(oldp+118,(7U),3);
    bufp->fullIData(oldp+119,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__addr_current_w),32);
    bufp->fullIData(oldp+120,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__w_addr_branch),32);
    bufp->fullIData(oldp+121,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__addr_next_w),32);
    bufp->fullIData(oldp+122,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__instruction_r),32);
    bufp->fullIData(oldp+123,(0U),32);
    bufp->fullCData(oldp+124,(3U),7);
    bufp->fullCData(oldp+125,(0x67U),7);
    bufp->fullCData(oldp+126,(0x13U),7);
    bufp->fullCData(oldp+127,(0x33U),7);
    bufp->fullCData(oldp+128,(0x23U),7);
    bufp->fullCData(oldp+129,(0x63U),7);
    bufp->fullCData(oldp+130,(0x37U),7);
    bufp->fullCData(oldp+131,(0x17U),7);
    bufp->fullCData(oldp+132,(0x6fU),7);
    bufp->fullCData(oldp+133,(0xcU),5);
    bufp->fullCData(oldp+134,(0U),5);
    bufp->fullCData(oldp+135,(4U),5);
    bufp->fullCData(oldp+136,(0x19U),5);
    bufp->fullCData(oldp+137,(8U),5);
    bufp->fullCData(oldp+138,(0x18U),5);
    bufp->fullCData(oldp+139,(0xdU),5);
    bufp->fullCData(oldp+140,(0x1bU),5);
    bufp->fullBit(oldp+141,(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ctrl_reg_write_w));
    bufp->fullBit(oldp+142,(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ctrl_mem_to_reg_w));
    bufp->fullCData(oldp+143,(2U),3);
}

VL_ATTR_COLD void Vtop___024root__trace_full_0_sub_0(Vtop___024root* vlSelf, VerilatedFst::Buffer* bufp);

VL_ATTR_COLD void Vtop___024root__trace_full_0(void* voidSelf, VerilatedFst::Buffer* bufp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_full_0\n"); );
    // Init
    Vtop___024root* const __restrict vlSelf VL_ATTR_UNUSED = static_cast<Vtop___024root*>(voidSelf);
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    // Body
    Vtop___024root__trace_full_0_sub_0((&vlSymsp->TOP), bufp);
}

VL_ATTR_COLD void Vtop___024root__trace_full_0_sub_0(Vtop___024root* vlSelf, VerilatedFst::Buffer* bufp) {
    if (false && vlSelf) {}  // Prevent unused
    Vtop__Syms* const __restrict vlSymsp VL_ATTR_UNUSED = vlSelf->vlSymsp;
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vtop___024root__trace_full_0_sub_0\n"); );
    // Init
    uint32_t* const oldp VL_ATTR_UNUSED = bufp->oldp(vlSymsp->__Vm_baseCode);
    // Body
    bufp->fullBit(oldp+1,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_read_r));
    bufp->fullBit(oldp+2,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_to_reg_r));
    bufp->fullBit(oldp+3,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_mem_write_r));
    bufp->fullBit(oldp+4,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ctrl_reg_write_r));
    bufp->fullCData(oldp+5,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__funct3_r),3);
    bufp->fullIData(oldp+6,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r),32);
    bufp->fullIData(oldp+7,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_r),32);
    bufp->fullBit(oldp+8,(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ctrl_mem_to_reg_r));
    bufp->fullBit(oldp+9,(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ctrl_reg_write_r));
    bufp->fullIData(oldp+10,(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_data_r),32);
    bufp->fullIData(oldp+11,(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__ALUresult_r),32);
    bufp->fullIData(oldp+12,(VL_SHIFTR_III(32,32,32, vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r, 2U)),32);
    bufp->fullIData(oldp+13,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r1_q),32);
    bufp->fullIData(oldp+14,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r2_q),32);
    bufp->fullIData(oldp+15,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r3_q),32);
    bufp->fullIData(oldp+16,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r4_q),32);
    bufp->fullIData(oldp+17,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r5_q),32);
    bufp->fullIData(oldp+18,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r6_q),32);
    bufp->fullIData(oldp+19,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r7_q),32);
    bufp->fullIData(oldp+20,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r8_q),32);
    bufp->fullIData(oldp+21,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r9_q),32);
    bufp->fullIData(oldp+22,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r10_q),32);
    bufp->fullIData(oldp+23,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r11_q),32);
    bufp->fullIData(oldp+24,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r12_q),32);
    bufp->fullIData(oldp+25,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r13_q),32);
    bufp->fullIData(oldp+26,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r14_q),32);
    bufp->fullIData(oldp+27,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r15_q),32);
    bufp->fullIData(oldp+28,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r16_q),32);
    bufp->fullIData(oldp+29,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r17_q),32);
    bufp->fullIData(oldp+30,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r18_q),32);
    bufp->fullIData(oldp+31,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r19_q),32);
    bufp->fullIData(oldp+32,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r20_q),32);
    bufp->fullIData(oldp+33,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r21_q),32);
    bufp->fullIData(oldp+34,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r22_q),32);
    bufp->fullIData(oldp+35,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r23_q),32);
    bufp->fullIData(oldp+36,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r24_q),32);
    bufp->fullIData(oldp+37,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r25_q),32);
    bufp->fullIData(oldp+38,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r26_q),32);
    bufp->fullIData(oldp+39,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r27_q),32);
    bufp->fullIData(oldp+40,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r28_q),32);
    bufp->fullIData(oldp+41,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r29_q),32);
    bufp->fullIData(oldp+42,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r30_q),32);
    bufp->fullIData(oldp+43,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__reg_r31_q),32);
    bufp->fullBit(oldp+44,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_branch_r));
    bufp->fullBit(oldp+45,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_read_r));
    bufp->fullBit(oldp+46,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_to_reg_r));
    bufp->fullBit(oldp+47,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_write_r));
    bufp->fullCData(oldp+48,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_ALUOp_r),2);
    bufp->fullBit(oldp+49,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_reg_write_r));
    bufp->fullIData(oldp+50,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd1_r),32);
    bufp->fullIData(oldp+51,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rd2_r),32);
    bufp->fullIData(oldp+52,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__addr_current_r),32);
    bufp->fullIData(oldp+53,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_r),32);
    bufp->fullBit(oldp+54,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct7_30_r));
    bufp->fullCData(oldp+55,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r),3);
    bufp->fullCData(oldp+56,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rs1_r),5);
    bufp->fullCData(oldp+57,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__rs2_r),5);
    bufp->fullIData(oldp+58,((vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__addr_current_r 
                              + vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_r)),32);
    bufp->fullBit(oldp+59,((((4U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))
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
    bufp->fullBit(oldp+60,((1U & ((4U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))
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
                                      && (1U & (~ (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))))))));
    bufp->fullCData(oldp+61,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w),4);
    bufp->fullCData(oldp+62,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__write_rd_r),5);
    bufp->fullCData(oldp+63,(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__write_rd_r),5);
    bufp->fullIData(oldp+64,(vlSelf->top__DOT__RISCV_inst__DOT__data_WB_w),32);
    bufp->fullCData(oldp+65,(vlSelf->top__DOT__RISCV_inst__DOT__hz_ALU1_w),2);
    bufp->fullCData(oldp+66,(vlSelf->top__DOT__RISCV_inst__DOT__hz_ALU2_w),2);
    bufp->fullIData(oldp+67,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w),32);
    bufp->fullIData(oldp+68,(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w),32);
    bufp->fullIData(oldp+69,((vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w 
                              - vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w)),32);
    bufp->fullIData(oldp+70,(vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r),32);
    bufp->fullIData(oldp+71,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__imm_gen_inst0__DOT__output_r),32);
    bufp->fullBit(oldp+72,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__branch_r));
    bufp->fullBit(oldp+73,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_read_r));
    bufp->fullBit(oldp+74,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_to_reg_r));
    bufp->fullBit(oldp+75,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__mem_write_r));
    bufp->fullBit(oldp+76,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__reg_write_r));
    bufp->fullCData(oldp+77,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__controller_inst0__DOT__ALUOp_r),2);
    bufp->fullCData(oldp+78,((0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                       >> 0xfU))),5);
    bufp->fullCData(oldp+79,((0x1fU & (vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r 
                                       >> 0x14U))),5);
    bufp->fullCData(oldp+80,((0x7fU & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r)),7);
    bufp->fullBit(oldp+81,((0x67U == (0x707fU & vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__instruction_r))));
    bufp->fullBit(oldp+82,(vlSelf->clk_i));
    bufp->fullBit(oldp+83,(vlSelf->rstn_i));
    bufp->fullBit(oldp+84,(vlSelf->top__DOT__clk_l));
    bufp->fullBit(oldp+85,(vlSelf->top__DOT__rstn_l));
    bufp->fullIData(oldp+86,(vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__addr_current_r),32);
    bufp->fullCData(oldp+87,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__write_rd_r),5);
    bufp->fullBit(oldp+88,(vlSelf->top__DOT__RISCV_inst__DOT__hz_flush_w));
    bufp->fullBit(oldp+89,((1U & (~ ((((IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__ctrl_mem_read_r) 
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
    bufp->fullBit(oldp+90,(vlSelf->top__DOT__RISCV_inst__DOT__hz_ctrl_w));
    bufp->fullIData(oldp+91,(((8U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                               ? ((4U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                                   ? ((2U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                                       ? 0xdeadU : 
                                      ((1U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                                        ? (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w 
                                           >> (0x1fU 
                                               & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w))
                                        : 0xdeadU))
                                   : ((2U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                                       ? 0xdeadU : 
                                      ((1U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                                        ? 0xdeadU : 
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
                                       ? 0xdeadU : 
                                      ((1U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUctrl_w))
                                        ? (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w 
                                           << (0x1fU 
                                               & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w))
                                        : (vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU1_i_w 
                                           + vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALU2_i_w)))))),32);
    bufp->fullIData(oldp+92,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__rs1_value_r),32);
    bufp->fullIData(oldp+93,(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__RF_inst0__DOT__rs2_value_r),32);
    bufp->fullIData(oldp+94,(((((4U & (IData)(vlSelf->top__DOT__RISCV_inst__DOT__ID_stage_inst__DOT__funct3_r))
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
    bufp->fullIData(oldp+95,(vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__PC_inst0__DOT__PC_r),32);
    bufp->fullIData(oldp+96,(((vlSelf->top__DOT__RISCV_inst__DOT__IF_stage_inst__DOT__IMEM_inst0__DOT__imem
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
    bufp->fullIData(oldp+97,((vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__data_o__out__strong__out0 
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
    bufp->fullCData(oldp+98,(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank3
                             [(0x3fU & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r)]),8);
    bufp->fullCData(oldp+99,(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank2
                             [(0x3fU & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r)]),8);
    bufp->fullCData(oldp+100,(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank1
                              [(0x3fU & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r)]),8);
    bufp->fullCData(oldp+101,(vlSelf->top__DOT__RISCV_inst__DOT__MEM_stage_inst__DOT__DMEM_inst0__DOT__bank0
                              [(0x3fU & vlSelf->top__DOT__RISCV_inst__DOT__EXE_stage_inst__DOT__ALUresult_r)]),8);
}
