//--------------------------------------------------------------------
// File: dm_hart_ctrl.v
// Module: dm_hart_ctrl
// Description: Hart Debug Control and Status Tracking Logic
//              conforming to RISC-V Debug Specification 0.13.2.
//--------------------------------------------------------------------

`include "dm_defines.v"

module dm_hart_ctrl (
    input             clk_i,
    input             rstn_i,
    input             dmactive_i,
    // Control inputs from dm_csrs
    input             haltreq_i,
    input             resumereq_pulse_i,
    input             setresethaltreq_pulse_i,
    input             clrresethaltreq_pulse_i,
    // Status outputs to dm_csrs
    output            hart_halted_o,
    output            hart_running_o,
    output            hart_havereset_o,
    output            hart_resumeack_o,
    // Interface to RISC-V Core (Hart)
    output            core_debug_req_o,
    output reg        core_debug_resume_req_o,
    output            core_debug_resethalt_req_o,
    input             core_debug_halted_i,
    input             core_debug_resume_ack_i,
    input      [2:0]  core_debug_cause_i,
    output reg [2:0]  saved_halt_cause_o
);

    reg resethaltreq_q;
    reg havereset_q;
    reg resumeack_q;

    assign hart_halted_o              = core_debug_halted_i;
    assign hart_running_o             = !core_debug_halted_i;
    assign hart_havereset_o           = havereset_q;
    assign hart_resumeack_o           = resumeack_q;
    assign core_debug_req_o           = haltreq_i | resethaltreq_q;
    assign core_debug_resethalt_req_o = resethaltreq_q;

    always @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            resethaltreq_q          <= 1'b0;
            havereset_q             <= 1'b1;
            resumeack_q             <= 1'b0;
            core_debug_resume_req_o <= 1'b0;
            saved_halt_cause_o      <= 3'd0;
        end else if (!dmactive_i) begin
            resethaltreq_q          <= 1'b0;
            havereset_q             <= 1'b1;
            resumeack_q             <= 1'b0;
            core_debug_resume_req_o <= 1'b0;
            saved_halt_cause_o      <= 3'd0;
        end else begin
            // Default pulse
            core_debug_resume_req_o <= 1'b0;

            // Reset-halt request control
            if (setresethaltreq_pulse_i) begin
                resethaltreq_q <= 1'b1;
            end else if (clrresethaltreq_pulse_i) begin
                resethaltreq_q <= 1'b0;
            end

            // Capture halt cause when core halts
            if (core_debug_halted_i) begin
                saved_halt_cause_o <= core_debug_cause_i;
            end

            // Resume handshake
            if (resumereq_pulse_i && core_debug_halted_i) begin
                core_debug_resume_req_o <= 1'b1;
                resumeack_q             <= 1'b0;
            end

            if (core_debug_resume_ack_i) begin
                resumeack_q <= 1'b1;
            end
        end
    end

endmodule
