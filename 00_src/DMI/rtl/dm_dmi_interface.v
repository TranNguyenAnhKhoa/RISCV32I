//--------------------------------------------------------------------
// File: dm_dmi_interface.v
// Module: dm_dmi_interface
// Description: DTM to Debug Module Interface (DMI) protocol handler
//              and bus adapter conforming to RISC-V Debug Spec 0.13.2.
//--------------------------------------------------------------------

`include "dm_defines.v"

module dm_dmi_interface (
    input             clk_i,
    input             rstn_i,
    input             dmactive_i,
    // DMI Bus from DTM (Debug Transport Module)
    input             dmi_req_valid_i,
    output            dmi_req_ready_o,
    input      [6:0]  dmi_req_address_i,
    input      [31:0] dmi_req_data_i,
    input      [1:0]  dmi_req_op_i,
    output            dmi_resp_valid_o,
    input             dmi_resp_ready_i,
    output reg [31:0] dmi_resp_data_o,
    output reg [1:0]  dmi_resp_op_o,
    // Internal Register Interface to DM CSRs
    output reg        reg_req_o,
    output reg        reg_write_o,
    output reg [6:0]  reg_addr_o,
    output reg [31:0] reg_wdata_o,
    input      [31:0] reg_rdata_i,
    input             reg_err_i,
    input             reg_busy_i
);

    localparam [1:0] STATE_IDLE = 2'b00;
    localparam [1:0] STATE_EXEC = 2'b01;
    localparam [1:0] STATE_RESP = 2'b10;

    reg [1:0] state_q;
    reg [1:0] state_d;

    reg [6:0]  req_addr_q;
    reg [31:0] req_wdata_q;
    reg [1:0]  req_op_q;

    // Ready to accept new DMI request when in IDLE
    assign dmi_req_ready_o = (state_q == STATE_IDLE);
    assign dmi_resp_valid_o = (state_q == STATE_RESP);

    // Next-state logic & internal register request generation
    always @(*) begin
        state_d     = state_q;
        reg_req_o   = 1'b0;
        reg_write_o = 1'b0;
        reg_addr_o  = req_addr_q;
        reg_wdata_o = req_wdata_q;

        case (state_q)
            STATE_IDLE: begin
                if (dmi_req_valid_i) begin
                    state_d = STATE_EXEC;
                end
            end

            STATE_EXEC: begin
                if (req_op_q == `DMI_OP_READ || req_op_q == `DMI_OP_WRITE) begin
                    // When dmactive is 0, only dmcontrol (0x10) access is forwarded
                    if (dmactive_i || (req_addr_q == `DM_ADDR_DMCONTROL)) begin
                        reg_req_o   = 1'b1;
                        reg_write_o = (req_op_q == `DMI_OP_WRITE);
                        reg_addr_o  = req_addr_q;
                        reg_wdata_o = req_wdata_q;
                    end
                end
                state_d = STATE_RESP;
            end

            STATE_RESP: begin
                if (dmi_resp_ready_i) begin
                    state_d = STATE_IDLE;
                end
            end

            default: begin
                state_d = STATE_IDLE;
            end
        endcase
    end

    // Sequential state and response generation
    always @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            state_q         <= STATE_IDLE;
            req_addr_q      <= 7'h00;
            req_wdata_q     <= 32'h0000_0000;
            req_op_q        <= `DMI_OP_NOP;
            dmi_resp_data_o <= 32'h0000_0000;
            dmi_resp_op_o   <= `DMI_RESP_SUCCESS;
        end else begin
            state_q <= state_d;

            if (state_q == STATE_IDLE && dmi_req_valid_i) begin
                req_addr_q  <= dmi_req_address_i;
                req_wdata_q <= dmi_req_data_i;
                req_op_q    <= dmi_req_op_i;
            end

            if (state_q == STATE_EXEC) begin
                if (req_op_q == `DMI_OP_NOP) begin
                    dmi_resp_data_o <= 32'h0000_0000;
                    dmi_resp_op_o   <= `DMI_RESP_SUCCESS;
                end else if (!dmactive_i && (req_addr_q != `DM_ADDR_DMCONTROL)) begin
                    // Inactive DM returns 0 and success
                    dmi_resp_data_o <= 32'h0000_0000;
                    dmi_resp_op_o   <= `DMI_RESP_SUCCESS;
                end else if (reg_busy_i) begin
                    dmi_resp_data_o <= 32'h0000_0000;
                    dmi_resp_op_o   <= `DMI_RESP_BUSY;
                end else if (reg_err_i) begin
                    dmi_resp_data_o <= 32'h0000_0000;
                    dmi_resp_op_o   <= `DMI_RESP_FAILED;
                end else begin
                    dmi_resp_data_o <= (req_op_q == `DMI_OP_READ) ? reg_rdata_i : 32'h0000_0000;
                    dmi_resp_op_o   <= `DMI_RESP_SUCCESS;
                end
            end
        end
    end

endmodule
