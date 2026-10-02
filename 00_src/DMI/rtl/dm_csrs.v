//--------------------------------------------------------------------
// File: dm_csrs.v
// Module: dm_csrs
// Description: Debug Module Control & Status Registers conforming to
//              RISC-V Debug Specification 0.13.2.
//--------------------------------------------------------------------

`include "dm_defines.v"

module dm_csrs (
    input             clk_i,
    input             rstn_i,
    // Register Bus from dm_dmi_interface
    input             reg_req_i,
    input             reg_write_i,
    input      [6:0]  reg_addr_i,
    input      [31:0] reg_wdata_i,
    output reg [31:0] reg_rdata_o,
    output reg        reg_err_o,
    // Status from Hart Controller
    input             hart_halted_i,
    input             hart_running_i,
    input             hart_havereset_i,
    input             hart_resumeack_i,
    // Control outputs to Hart Controller / System
    output            dmactive_o,
    output            ndmreset_o,
    output            haltreq_o,
    output reg        resumereq_pulse_o,
    output reg        setresethaltreq_pulse_o,
    output reg        clrresethaltreq_pulse_o,
    // Interface with Abstract Command Engine
    input             abstract_busy_i,
    input      [2:0]  abstract_cmderr_i,
    input             abstract_cmderr_set_i,
    output     [2:0]  cmderr_o,
    output reg        cmd_valid_o,
    output reg [31:0] cmd_wdata_o,
    input             abstract_data_valid_i,
    input      [31:0] abstract_data_i,
    output     [31:0] data0_o
);

    // dmcontrol registers
    reg        dmactive_q;
    reg        ndmreset_q;
    reg        haltreq_q;
    reg [9:0]  hartsel_q;

    // data0 register
    reg [31:0] data0_q;

    // abstractcs: cmderr register
    reg [2:0]  cmderr_q;

    // abstractauto: autoexecdata register
    reg        autoexecdata0_q;

    assign dmactive_o = dmactive_q;
    assign ndmreset_o = ndmreset_q;
    assign haltreq_o  = haltreq_q;
    assign cmderr_o   = cmderr_q;
    assign data0_o    = data0_q;

    // dmstatus composition wire
    wire [31:0] dmstatus_w;
    wire        selected_hart_nonexistent_w;
    wire        selected_hart_halted_w;
    wire        selected_hart_running_w;

    assign selected_hart_nonexistent_w = (hartsel_q != 10'd0);
    assign selected_hart_halted_w      = hart_halted_i && !selected_hart_nonexistent_w;
    assign selected_hart_running_w     = hart_running_i && !selected_hart_nonexistent_w;

    assign dmstatus_w = {
        7'b0000000,                                 // 31:25 reserved
        1'b0,                                       // 24    ndmresetpending
        1'b0,                                       // 23    stickyunavail
        1'b0,                                       // 22    impebreak
        2'b00,                                      // 21:20 reserved
        hart_havereset_i,                           // 19    allhavereset
        hart_havereset_i,                           // 18    anyhavereset
        hart_resumeack_i,                           // 17    allresumeack
        hart_resumeack_i,                           // 16    anyresumeack
        selected_hart_nonexistent_w,                // 15    allnonexistent
        selected_hart_nonexistent_w,                // 14    anynonexistent
        1'b0,                                       // 13    allunavail
        1'b0,                                       // 12    anyunavail
        selected_hart_running_w,                    // 11    allrunning
        selected_hart_running_w,                    // 10    anyrunning
        selected_hart_halted_w,                     // 9     allhalted
        selected_hart_halted_w,                     // 8     anyhalted
        1'b1,                                       // 7     authenticated
        1'b0,                                       // 6     authbusy
        1'b1,                                       // 5     hasresethaltreq
        1'b0,                                       // 4     confstrptrvalid
        `DMSTATUS_VERSION_0_13                      // 3:0   version (0.13.2)
    };

    // hartinfo composition wire
    wire [31:0] hartinfo_w;
    assign hartinfo_w = {
        8'h00,                                      // 31:24 reserved
        4'd1,                                       // 23:20 nscratch (1 dscratch register)
        3'b000,                                     // 19:17 reserved
        1'b0,                                       // 16    dataaccess (not memory mapped)
        4'd1,                                       // 15:12 datasize (1 data register: data0)
        12'h000                                     // 11:0  dataaddr
    };

    // abstractcs composition wire
    wire [31:0] abstractcs_w;
    assign abstractcs_w = {
        3'b000,                                     // 31:29 reserved
        5'd0,                                       // 28:24 progbufsize (0 words)
        11'h000,                                    // 23:13 reserved
        abstract_busy_i,                            // 12    busy
        1'b0,                                       // 11    reserved
        cmderr_q,                                   // 10:8  cmderr
        4'b0000,                                    // 7:4   reserved
        4'd1                                        // 3:0   datacount (1 data register)
    };

    // Register Read Multiplexer
    always @(*) begin
        reg_rdata_o = 32'h0000_0000;
        reg_err_o   = 1'b0;

        if (reg_req_i && !reg_write_i) begin
            case (reg_addr_i)
                `DM_ADDR_DATA0:          reg_rdata_o = data0_q;
                `DM_ADDR_DMCONTROL: begin
                    reg_rdata_o = {
                        haltreq_q,                  // 31    haltreq
                        1'b0,                       // 30    resumereq (write-only)
                        4'b0000,                    // 29:26 reserved/clrresethaltreq/setresethaltreq
                        hartsel_q,                  // 25:16 hartsel
                        14'b0,                      // 15:2  reserved
                        ndmreset_q,                 // 1     ndmreset
                        dmactive_q                  // 0     dmactive
                    };
                end
                `DM_ADDR_DMSTATUS:       reg_rdata_o = dmstatus_w;
                `DM_ADDR_HARTINFO:       reg_rdata_o = hartinfo_w;
                `DM_ADDR_HALTSUM0,
                `DM_ADDR_HALTSUM0_ALIAS: reg_rdata_o = {31'b0, selected_hart_halted_w};
                `DM_ADDR_ABSTRACTCS:     reg_rdata_o = abstractcs_w;
                `DM_ADDR_COMMAND:        reg_rdata_o = 32'h0000_0000;
                `DM_ADDR_ABSTRACTAUTO:   reg_rdata_o = {31'b0, autoexecdata0_q};
                default:                 reg_err_o   = 1'b1;
            endcase
        end
    end

    // Register Write Logic & Command Triggering
    always @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            dmactive_q              <= 1'b0;
            ndmreset_q              <= 1'b0;
            haltreq_q               <= 1'b0;
            hartsel_q               <= 10'd0;
            data0_q                 <= 32'h0000_0000;
            cmderr_q                <= `CMDERR_NONE;
            autoexecdata0_q         <= 1'b0;
            resumereq_pulse_o       <= 1'b0;
            setresethaltreq_pulse_o <= 1'b0;
            clrresethaltreq_pulse_o <= 1'b0;
            cmd_valid_o             <= 1'b0;
            cmd_wdata_o             <= 32'h0000_0000;
        end else begin
            // Default single-cycle pulses
            resumereq_pulse_o       <= 1'b0;
            setresethaltreq_pulse_o <= 1'b0;
            clrresethaltreq_pulse_o <= 1'b0;
            cmd_valid_o             <= 1'b0;

            // When abstract command completes a read, latch data into data0
            if (abstract_data_valid_i) begin
                data0_q <= abstract_data_i;
            end

            // Abstract error reporting from abstract engine
            if (abstract_cmderr_set_i && (cmderr_q == `CMDERR_NONE)) begin
                cmderr_q <= abstract_cmderr_i;
            end

            // Register write processing
            if (reg_req_i && reg_write_i) begin
                case (reg_addr_i)
                    `DM_ADDR_DMCONTROL: begin
                        dmactive_q <= reg_wdata_i[`DMCONTROL_DMACTIVE];

                        if (reg_wdata_i[`DMCONTROL_DMACTIVE]) begin
                            ndmreset_q <= reg_wdata_i[`DMCONTROL_NDMRESET];
                            haltreq_q  <= reg_wdata_i[`DMCONTROL_HALTREQ];
                            hartsel_q  <= reg_wdata_i[25:16];

                            if (reg_wdata_i[`DMCONTROL_RESUMEREQ]) begin
                                resumereq_pulse_o <= 1'b1;
                            end
                            if (reg_wdata_i[`DMCONTROL_SETRESETHALTREQ]) begin
                                setresethaltreq_pulse_o <= 1'b1;
                            end
                            if (reg_wdata_i[`DMCONTROL_CLRRESETHALTREQ]) begin
                                clrresethaltreq_pulse_o <= 1'b1;
                            end
                        end else begin
                            // Inactivating DM clears active control state
                            ndmreset_q      <= 1'b0;
                            haltreq_q       <= 1'b0;
                            hartsel_q       <= 10'd0;
                            cmderr_q        <= `CMDERR_NONE;
                            autoexecdata0_q <= 1'b0;
                        end
                    end

                    `DM_ADDR_DATA0: begin
                        if (dmactive_q) begin
                            data0_q <= reg_wdata_i;
                            // Autoexec trigger if enabled and not busy and no error
                            if (autoexecdata0_q && !abstract_busy_i && (cmderr_q == `CMDERR_NONE)) begin
                                cmd_valid_o <= 1'b1;
                            end
                        end
                    end

                    `DM_ADDR_ABSTRACTCS: begin
                        if (dmactive_q) begin
                            // W1C for cmderr: writing 1 to cmderr bits clears them
                            cmderr_q <= cmderr_q & ~reg_wdata_i[10:8];
                        end
                    end

                    `DM_ADDR_COMMAND: begin
                        if (dmactive_q) begin
                            cmd_wdata_o <= reg_wdata_i;
                            if (abstract_busy_i) begin
                                if (cmderr_q == `CMDERR_NONE) begin
                                    cmderr_q <= `CMDERR_BUSY;
                                end
                            end else if (cmderr_q != `CMDERR_NONE) begin
                                // Commands ignored when cmderr is non-zero
                            end else begin
                                cmd_valid_o <= 1'b1;
                            end
                        end
                    end

                    `DM_ADDR_ABSTRACTAUTO: begin
                        if (dmactive_q) begin
                            autoexecdata0_q <= reg_wdata_i[0];
                        end
                    end

                    default: begin
                        // Other registers are read-only or not implemented
                    end
                endcase
            end
        end
    end

endmodule
