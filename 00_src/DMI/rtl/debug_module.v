//--------------------------------------------------------------------
// File: debug_module.v
// Module: debug_module
// Description: Top-Level RISC-V Debug Module (DM) conforming to
//              RISC-V Debug Specification 0.13.2.
//--------------------------------------------------------------------

`include "dm_defines.v"

module debug_module (
    input             clk_i,
    input             rstn_i,
    // DMI Slave Interface (from DTM / JTAG TAP)
    input             dmi_req_valid_i,
    output            dmi_req_ready_o,
    input      [6:0]  dmi_req_address_i,
    input      [31:0] dmi_req_data_i,
    input      [1:0]  dmi_req_op_i,
    output            dmi_resp_valid_o,
    input             dmi_resp_ready_i,
    output     [31:0] dmi_resp_data_o,
    output     [1:0]  dmi_resp_op_o,
    // Core Debug Control & Status Interface
    output            core_debug_req_o,
    output            core_debug_resume_req_o,
    output            core_debug_resethalt_req_o,
    input             core_debug_halted_i,
    input             core_debug_resume_ack_i,
    input      [2:0]  core_debug_cause_i,
    output            ndmreset_o,
    output            dmactive_o,
    // Core Direct Register / PC Access Interface
    output            core_reg_req_o,
    output            core_reg_write_o,
    output     [15:0] core_reg_addr_o,
    output     [31:0] core_reg_wdata_o,
    input      [31:0] core_reg_rdata_i,
    input             core_reg_ready_i
);

    // Internal wires: DMI interface <-> CSRs
    wire        reg_req_w;
    wire        reg_write_w;
    wire [6:0]  reg_addr_w;
    wire [31:0] reg_wdata_w;
    wire [31:0] reg_rdata_w;
    wire        reg_err_w;
    wire        reg_busy_w;

    // Internal wires: CSRs <-> Hart Control
    wire        dmactive_w;
    wire        haltreq_w;
    wire        resumereq_pulse_w;
    wire        setresethaltreq_pulse_w;
    wire        clrresethaltreq_pulse_w;
    wire        hart_halted_w;
    wire        hart_running_w;
    wire        hart_havereset_w;
    wire        hart_resumeack_w;
    wire [2:0]  saved_halt_cause_w;

    // Internal wires: CSRs <-> Abstract Command Engine
    wire        cmd_valid_w;
    wire [31:0] cmd_wdata_w;
    wire [31:0] data0_w;
    wire        abstract_busy_w;
    wire [2:0]  abstract_cmderr_w;
    wire        abstract_cmderr_set_w;
    wire        abstract_data_valid_w;
    wire [31:0] abstract_data_w;
    wire [2:0]  cmderr_w;

    assign dmactive_o = dmactive_w;
    assign reg_busy_w = abstract_busy_w;

    //----------------------------------------------------------------
    // Submodule: DMI Interface Adapter
    //----------------------------------------------------------------
    dm_dmi_interface dm_dmi_interface_inst (
        .clk_i             (clk_i),
        .rstn_i            (rstn_i),
        .dmactive_i        (dmactive_w),
        .dmi_req_valid_i   (dmi_req_valid_i),
        .dmi_req_ready_o   (dmi_req_ready_o),
        .dmi_req_address_i (dmi_req_address_i),
        .dmi_req_data_i    (dmi_req_data_i),
        .dmi_req_op_i      (dmi_req_op_i),
        .dmi_resp_valid_o  (dmi_resp_valid_o),
        .dmi_resp_ready_i  (dmi_resp_ready_i),
        .dmi_resp_data_o   (dmi_resp_data_o),
        .dmi_resp_op_o     (dmi_resp_op_o),
        .reg_req_o         (reg_req_w),
        .reg_write_o       (reg_write_w),
        .reg_addr_o        (reg_addr_w),
        .reg_wdata_o       (reg_wdata_w),
        .reg_rdata_i       (reg_rdata_w),
        .reg_err_i         (reg_err_w),
        .reg_busy_i        (reg_busy_w)
    );

    //----------------------------------------------------------------
    // Submodule: Debug Module CSRs
    //----------------------------------------------------------------
    dm_csrs dm_csrs_inst (
        .clk_i                   (clk_i),
        .rstn_i                  (rstn_i),
        .reg_req_i               (reg_req_w),
        .reg_write_i             (reg_write_w),
        .reg_addr_i              (reg_addr_w),
        .reg_wdata_i             (reg_wdata_w),
        .reg_rdata_o             (reg_rdata_w),
        .reg_err_o               (reg_err_w),
        .hart_halted_i           (hart_halted_w),
        .hart_running_i          (hart_running_w),
        .hart_havereset_i        (hart_havereset_w),
        .hart_resumeack_i        (hart_resumeack_w),
        .dmactive_o              (dmactive_w),
        .ndmreset_o              (ndmreset_o),
        .haltreq_o               (haltreq_w),
        .resumereq_pulse_o       (resumereq_pulse_w),
        .setresethaltreq_pulse_o (setresethaltreq_pulse_w),
        .clrresethaltreq_pulse_o (clrresethaltreq_pulse_w),
        .abstract_busy_i         (abstract_busy_w),
        .abstract_cmderr_i       (abstract_cmderr_w),
        .abstract_cmderr_set_i   (abstract_cmderr_set_w),
        .cmderr_o                (cmderr_w),
        .cmd_valid_o             (cmd_valid_w),
        .cmd_wdata_o             (cmd_wdata_w),
        .abstract_data_valid_i   (abstract_data_valid_w),
        .abstract_data_i         (abstract_data_w),
        .data0_o                 (data0_w)
    );

    //----------------------------------------------------------------
    // Submodule: Hart Control and Status Tracking
    //----------------------------------------------------------------
    dm_hart_ctrl dm_hart_ctrl_inst (
        .clk_i                      (clk_i),
        .rstn_i                     (rstn_i),
        .dmactive_i                 (dmactive_w),
        .haltreq_i                  (haltreq_w),
        .resumereq_pulse_i          (resumereq_pulse_w),
        .setresethaltreq_pulse_i    (setresethaltreq_pulse_w),
        .clrresethaltreq_pulse_i    (clrresethaltreq_pulse_w),
        .hart_halted_o              (hart_halted_w),
        .hart_running_o             (hart_running_w),
        .hart_havereset_o           (hart_havereset_w),
        .hart_resumeack_o           (hart_resumeack_w),
        .core_debug_req_o           (core_debug_req_o),
        .core_debug_resume_req_o    (core_debug_resume_req_o),
        .core_debug_resethalt_req_o (core_debug_resethalt_req_o),
        .core_debug_halted_i        (core_debug_halted_i),
        .core_debug_resume_ack_i    (core_debug_resume_ack_i),
        .core_debug_cause_i         (core_debug_cause_i),
        .saved_halt_cause_o         (saved_halt_cause_w)
    );

    //----------------------------------------------------------------
    // Submodule: Abstract Command Engine
    //----------------------------------------------------------------
    dm_abstract_cmd dm_abstract_cmd_inst (
        .clk_i                 (clk_i),
        .rstn_i                (rstn_i),
        .dmactive_i            (dmactive_w),
        .cmd_valid_i           (cmd_valid_w),
        .cmd_wdata_i           (cmd_wdata_w),
        .data0_i               (data0_w),
        .busy_o                (abstract_busy_w),
        .abstract_cmderr_o     (abstract_cmderr_w),
        .abstract_cmderr_set_o (abstract_cmderr_set_w),
        .abstract_data_valid_o (abstract_data_valid_w),
        .abstract_data_o       (abstract_data_w),
        .hart_halted_i         (hart_halted_w),
        .core_reg_req_o        (core_reg_req_o),
        .core_reg_write_o      (core_reg_write_o),
        .core_reg_addr_o       (core_reg_addr_o),
        .core_reg_wdata_o      (core_reg_wdata_o),
        .core_reg_rdata_i      (core_reg_rdata_i),
        .core_reg_ready_i      (core_reg_ready_i)
    );

endmodule
