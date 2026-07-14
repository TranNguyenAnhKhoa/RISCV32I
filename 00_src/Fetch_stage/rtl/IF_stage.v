module IF_stage #(
    parameter IMEM_FILE = ""
)(
    input         clk_i,
    input         rstn_i,
    input         branch_i,
    input         flush_i,
    input         write_PC_en_i,
    input  [31:0] addr_branch_i,
    output [31:0] instruction_o,
    output [31:0] addr_current_o
);

    localparam [31:0] NOP_INSTRUCTION = 32'h0000_0013;

    wire [31:0] addr_next_w;
    wire [31:0] addr_current_w;
    wire [31:0] instruction_w;
    wire        PC_write_enable_w;

    reg [31:0] addr_current_r;
    reg [31:0] instruction_r;

    assign addr_next_w       = branch_i ? addr_branch_i : (addr_current_w + 32'd4);
    assign PC_write_enable_w = branch_i || write_PC_en_i;
    assign instruction_o     = instruction_r;
    assign addr_current_o    = addr_current_r;

    always @(posedge clk_i or negedge rstn_i) begin
        if (!rstn_i) begin
            instruction_r  <= NOP_INSTRUCTION;
            addr_current_r <= 32'h0000_0000;
        end else if (flush_i) begin
            instruction_r  <= NOP_INSTRUCTION;
            addr_current_r <= 32'h0000_0000;
        end else if (write_PC_en_i) begin
            instruction_r  <= instruction_w;
            addr_current_r <= addr_current_w;
        end
    end

    program_counter PC_inst0(
        .clk_i      (clk_i),
        .rstn_i     (rstn_i),
        .write_en_i (PC_write_enable_w),
        .PC_i       (addr_next_w),
        .PC_o       (addr_current_w)
    );

    IMEM #(
        .IMEM_FILE (IMEM_FILE)
    ) IMEM_inst0(
        .address_i     (addr_current_w),
        .instruction_o (instruction_w)
    );

endmodule
