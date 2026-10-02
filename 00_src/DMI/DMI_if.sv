//--------------------------------------------------------------------
// File: DMI_if.sv
// Module: DMI_if
// Description: SystemVerilog wrapper module for Debug Module (DM).
//--------------------------------------------------------------------

module DMI_if (
    input  logic        clk_i,
    input  logic        rstn_i,
    // DMI Bus
    input  logic        dmi_req_valid_i,
    output logic        dmi_req_ready_o,
    input  logic [6:0]  dmi_req_address_i,
    input  logic [31:0] dmi_req_data_i,
    input  logic [1:0]  dmi_req_op_i,
    output logic        dmi_resp_valid_o,
    input  logic        dmi_resp_ready_i,
    output logic [31:0] dmi_resp_data_o,
    output logic [1:0]  dmi_resp_op_o,
    // Core Control & Status
    output logic        core_debug_req_o,
    output logic        core_debug_resume_req_o,
    output logic        core_debug_resethalt_req_o,
    input  logic        core_debug_halted_i,
    input  logic        core_debug_resume_ack_i,
    input  logic [2:0]  core_debug_cause_i,
    output logic        ndmreset_o,
    output logic        dmactive_o,
    // Core Register Access
    output logic        core_reg_req_o,
    output logic        core_reg_write_o,
    output logic [15:0] core_reg_addr_o,
    output logic [31:0] core_reg_wdata_o,
    input  logic [31:0] core_reg_rdata_i,
    input  logic        core_reg_ready_i
);

    debug_module debug_module_inst0 (
        .clk_i                      (clk_i),
        .rstn_i                     (rstn_i),
        .dmi_req_valid_i            (dmi_req_valid_i),
        .dmi_req_ready_o            (dmi_req_ready_o),
        .dmi_req_address_i          (dmi_req_address_i),
        .dmi_req_data_i             (dmi_req_data_i),
        .dmi_req_op_i               (dmi_req_op_i),
        .dmi_resp_valid_o           (dmi_resp_valid_o),
        .dmi_resp_ready_i           (dmi_resp_ready_i),
        .dmi_resp_data_o            (dmi_resp_data_o),
        .dmi_resp_op_o              (dmi_resp_op_o),
        .core_debug_req_o           (core_debug_req_o),
        .core_debug_resume_req_o    (core_debug_resume_req_o),
        .core_debug_resethalt_req_o (core_debug_resethalt_req_o),
        .core_debug_halted_i        (core_debug_halted_i),
        .core_debug_resume_ack_i    (core_debug_resume_ack_i),
        .core_debug_cause_i         (core_debug_cause_i),
        .ndmreset_o                 (ndmreset_o),
        .dmactive_o                 (dmactive_o),
        .core_reg_req_o             (core_reg_req_o),
        .core_reg_write_o           (core_reg_write_o),
        .core_reg_addr_o            (core_reg_addr_o),
        .core_reg_wdata_o           (core_reg_wdata_o),
        .core_reg_rdata_i           (core_reg_rdata_i),
        .core_reg_ready_i           (core_reg_ready_i)
    );

endmodule
