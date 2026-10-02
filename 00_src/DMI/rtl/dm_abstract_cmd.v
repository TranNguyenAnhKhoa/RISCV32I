//--------------------------------------------------------------------
// File: dm_abstract_cmd.v
// Module: dm_abstract_cmd
// Description: Abstract Command Engine conforming to RISC-V Debug
//              Specification 0.13.2 (Access Register command).
//--------------------------------------------------------------------

`include "dm_defines.v"

module dm_abstract_cmd (
    input             clk_i,
    input             rstn_i,
    input             dmactive_i,
    // Command trigger and data from dm_csrs
    input             cmd_valid_i,
    input      [31:0] cmd_wdata_i,
    input      [31:0] data0_i,
    output            busy_o,
    output reg [2:0]  abstract_cmderr_o,
    output reg        abstract_cmderr_set_o,
    output reg        abstract_data_valid_o,
    output reg [31:0] abstract_data_o,
    // Status from Hart Controller
    input             hart_halted_i,
    // Interface to Core Registers (GPR, DPC, DCSR)
    output reg        core_reg_req_o,
    output reg        core_reg_write_o,
    output reg [15:0] core_reg_addr_o,
    output reg [31:0] core_reg_wdata_o,
    input      [31:0] core_reg_rdata_i,
    input             core_reg_ready_i
);

    localparam [2:0] STATE_IDLE  = 3'b000;
    localparam [2:0] STATE_CHECK = 3'b001;
    localparam [2:0] STATE_EXEC  = 3'b010;
    localparam [2:0] STATE_WAIT  = 3'b011;
    localparam [2:0] STATE_DONE  = 3'b100;

    reg [2:0]  state_q;
    reg [2:0]  state_d;

    reg [31:0] cmd_q;

    // Command fields decoding
    wire [7:0]  cmdtype_w;
    wire [2:0]  aarsize_w;
    wire        aarpostincrement_w;
    wire        postexec_w;
    wire        transfer_w;
    wire        write_w;
    wire [15:0] regno_w;

    assign cmdtype_w          = cmd_q[31:24];
    assign aarsize_w          = cmd_q[22:20];
    assign aarpostincrement_w = cmd_q[19];
    assign postexec_w         = cmd_q[18];
    assign transfer_w         = cmd_q[17];
    assign write_w            = cmd_q[16];
    assign regno_w            = cmd_q[15:0];

    assign busy_o = (state_q != STATE_IDLE);

    // Next-state combinational logic
    always @(*) begin
        state_d               = state_q;
        core_reg_req_o        = 1'b0;
        core_reg_write_o      = write_w;
        core_reg_addr_o       = regno_w;
        core_reg_wdata_o      = data0_i;
        abstract_cmderr_o     = `CMDERR_NONE;
        abstract_cmderr_set_o = 1'b0;
        abstract_data_valid_o = 1'b0;
        abstract_data_o       = core_reg_rdata_i;

        case (state_q)
            STATE_IDLE: begin
                if (cmd_valid_i) begin
                    state_d = STATE_CHECK;
                end
            end

            STATE_CHECK: begin
                // Error: Hart must be halted to execute abstract commands
                if (!hart_halted_i) begin
                    abstract_cmderr_o     = `CMDERR_HALT_RESUME;
                    abstract_cmderr_set_o = 1'b1;
                    state_d               = STATE_IDLE;
                end
                // Error: Only Access Register command (cmdtype = 0) is supported
                else if (cmdtype_w != `CMDTYPE_ACCESS_REG) begin
                    abstract_cmderr_o     = `CMDERR_NOT_SUPPORTED;
                    abstract_cmderr_set_o = 1'b1;
                    state_d               = STATE_IDLE;
                end
                // Error: Only 32-bit register access is supported (aarsize = 2)
                else if (aarsize_w != `AARSIZE_32) begin
                    abstract_cmderr_o     = `CMDERR_NOT_SUPPORTED;
                    abstract_cmderr_set_o = 1'b1;
                    state_d               = STATE_IDLE;
                end
                // Error: postexec and aarpostincrement not supported
                else if (postexec_w || aarpostincrement_w) begin
                    abstract_cmderr_o     = `CMDERR_NOT_SUPPORTED;
                    abstract_cmderr_set_o = 1'b1;
                    state_d               = STATE_IDLE;
                end
                // Perform register transfer
                else if (transfer_w) begin
                    state_d = STATE_EXEC;
                end else begin
                    state_d = STATE_DONE;
                end
            end

            STATE_EXEC: begin
                core_reg_req_o   = 1'b1;
                core_reg_write_o = write_w;
                core_reg_addr_o  = regno_w;
                core_reg_wdata_o = data0_i;

                if (core_reg_ready_i) begin
                    if (!write_w) begin
                        abstract_data_valid_o = 1'b1;
                        abstract_data_o       = core_reg_rdata_i;
                    end
                    state_d = STATE_DONE;
                end else begin
                    state_d = STATE_WAIT;
                end
            end

            STATE_WAIT: begin
                core_reg_req_o   = 1'b1;
                core_reg_write_o = write_w;
                core_reg_addr_o  = regno_w;
                core_reg_wdata_o = data0_i;

                if (core_reg_ready_i) begin
                    if (!write_w) begin
                        abstract_data_valid_o = 1'b1;
                        abstract_data_o       = core_reg_rdata_i;
                    end
                    state_d = STATE_DONE;
                end
            end

            STATE_DONE: begin
                state_d = STATE_IDLE;
            end

            default: begin
                state_d = STATE_IDLE;
            end
        endcase
    end

    // Sequential state updates
    always @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            state_q <= STATE_IDLE;
            cmd_q   <= 32'h0000_0000;
        end else if (!dmactive_i) begin
            state_q <= STATE_IDLE;
            cmd_q   <= 32'h0000_0000;
        end else begin
            state_q <= state_d;

            if (state_q == STATE_IDLE && cmd_valid_i) begin
                cmd_q <= cmd_wdata_i;
            end
        end
    end

endmodule
