
module register_file(
    input          clk_i,
    input          rstn_i,
    input  [4:0]   rs1_i,
    input  [4:0]   rs2_i,
    input  [4:0]   rd_i,
    
    input  [31:0]  rd_value_i,
    input          reg_write_i,

    output [31:0]  read_rs1_o,
    output [31:0]  read_rs2_o
);

    // reg [31:0]  register [31:0];
    reg [31:0] reg_r1_q ;
    reg [31:0] reg_r2_q ;
    reg [31:0] reg_r3_q ;
    reg [31:0] reg_r4_q ;
    reg [31:0] reg_r5_q ;
    reg [31:0] reg_r6_q ;
    reg [31:0] reg_r7_q ;
    reg [31:0] reg_r8_q ;
    reg [31:0] reg_r9_q ;
    reg [31:0] reg_r10_q;
    reg [31:0] reg_r11_q;
    reg [31:0] reg_r12_q;
    reg [31:0] reg_r13_q;
    reg [31:0] reg_r14_q;
    reg [31:0] reg_r15_q;
    reg [31:0] reg_r16_q;
    reg [31:0] reg_r17_q;
    reg [31:0] reg_r18_q;
    reg [31:0] reg_r19_q;
    reg [31:0] reg_r20_q;
    reg [31:0] reg_r21_q;
    reg [31:0] reg_r22_q;
    reg [31:0] reg_r23_q;
    reg [31:0] reg_r24_q;
    reg [31:0] reg_r25_q;
    reg [31:0] reg_r26_q;
    reg [31:0] reg_r27_q;
    reg [31:0] reg_r28_q;
    reg [31:0] reg_r29_q;
    reg [31:0] reg_r30_q;
    reg [31:0] reg_r31_q;

    // simulation friendly names
    wire [31:0] x0_zero_w  = 32'h0000_0000;
    wire [31:0] x1_ra_w    =   reg_r1_q;
    wire [31:0] x2_sp_w    =   reg_r2_q;
    wire [31:0] x3_gp_w    =   reg_r3_q;
    wire [31:0] x4_tp_w    =   reg_r4_q;
    wire [31:0] x5_t0_w    =   reg_r5_q;
    wire [31:0] x6_t1_w    =   reg_r6_q;
    wire [31:0] x7_t2_w    =   reg_r7_q;
    wire [31:0] x8_s0_w    =   reg_r8_q;
    wire [31:0] x9_s1_w    =   reg_r9_q;
    wire [31:0] x10_a0_w   =   reg_r10_q;
    wire [31:0] x11_a1_w   =   reg_r11_q;
    wire [31:0] x12_a2_w   =   reg_r12_q;
    wire [31:0] x13_a3_w   =   reg_r13_q;
    wire [31:0] x14_a4_w   =   reg_r14_q;
    wire [31:0] x15_a5_w   =   reg_r15_q;
    wire [31:0] x16_a6_w   =   reg_r16_q;
    wire [31:0] x17_a7_w   =   reg_r17_q;
    wire [31:0] x18_s2_w   =   reg_r18_q;
    wire [31:0] x19_s3_w   =   reg_r19_q;
    wire [31:0] x20_s4_w   =   reg_r20_q;
    wire [31:0] x21_s5_w   =   reg_r21_q;
    wire [31:0] x22_s6_w   =   reg_r22_q;
    wire [31:0] x23_s7_w   =   reg_r23_q;
    wire [31:0] x24_s8_w   =   reg_r24_q;
    wire [31:0] x25_s9_w   =   reg_r25_q;
    wire [31:0] x26_s10_w  =   reg_r26_q;
    wire [31:0] x27_s11_w  =   reg_r27_q;
    wire [31:0] x28_t3_w   =   reg_r28_q;
    wire [31:0] x29_t4_w   =   reg_r29_q;
    wire [31:0] x30_t5_w   =   reg_r30_q;
    wire [31:0] x31_t6_w   =   reg_r31_q;

    always @(posedge clk_i or negedge rstn_i) begin
        if(!rstn_i) begin
            reg_r1_q  <= 32'h0000_0000;
            reg_r2_q  <= 32'h0000_0000;
            reg_r3_q  <= 32'h0000_0000;
            reg_r4_q  <= 32'h0000_0000;
            reg_r5_q  <= 32'h0000_0000;
            reg_r6_q  <= 32'h0000_0000;
            reg_r7_q  <= 32'h0000_0000;
            reg_r8_q  <= 32'h0000_0000;
            reg_r9_q  <= 32'h0000_0000;
            reg_r10_q <= 32'h0000_0000;
            reg_r11_q <= 32'h0000_0000;
            reg_r12_q <= 32'h0000_0000;
            reg_r13_q <= 32'h0000_0000;
            reg_r14_q <= 32'h0000_0000;
            reg_r15_q <= 32'h0000_0000;
            reg_r16_q <= 32'h0000_0000;
            reg_r17_q <= 32'h0000_0000;
            reg_r18_q <= 32'h0000_0000;
            reg_r19_q <= 32'h0000_0000;
            reg_r20_q <= 32'h0000_0000;
            reg_r21_q <= 32'h0000_0000;
            reg_r22_q <= 32'h0000_0000;
            reg_r23_q <= 32'h0000_0000;
            reg_r24_q <= 32'h0000_0000;
            reg_r25_q <= 32'h0000_0000; 
            reg_r26_q <= 32'h0000_0000;
            reg_r27_q <= 32'h0000_0000;
            reg_r28_q <= 32'h0000_0000;
            reg_r29_q <= 32'h0000_0000;
            reg_r30_q <= 32'h0000_0000;
            reg_r31_q <= 32'h0000_0000;
        end
        else begin
            if (rd_i == 5'd1 )  reg_r1_q  <= rd_value_i;
            if (rd_i == 5'd2 )  reg_r2_q  <= rd_value_i;
            if (rd_i == 5'd3 )  reg_r3_q  <= rd_value_i;
            if (rd_i == 5'd4 )  reg_r4_q  <= rd_value_i;
            if (rd_i == 5'd5 )  reg_r5_q  <= rd_value_i;
            if (rd_i == 5'd6 )  reg_r6_q  <= rd_value_i;
            if (rd_i == 5'd7 )  reg_r7_q  <= rd_value_i;
            if (rd_i == 5'd8 )  reg_r8_q  <= rd_value_i;
            if (rd_i == 5'd9 )  reg_r9_q  <= rd_value_i;
            if (rd_i == 5'd10)  reg_r10_q <= rd_value_i;
            if (rd_i == 5'd12)  reg_r12_q <= rd_value_i;
            if (rd_i == 5'd13)  reg_r13_q <= rd_value_i;
            if (rd_i == 5'd14)  reg_r14_q <= rd_value_i;
            if (rd_i == 5'd15)  reg_r15_q <= rd_value_i;
            if (rd_i == 5'd16)  reg_r16_q <= rd_value_i;
            if (rd_i == 5'd17)  reg_r17_q <= rd_value_i;
            if (rd_i == 5'd18)  reg_r18_q <= rd_value_i;
            if (rd_i == 5'd19)  reg_r19_q <= rd_value_i;
            if (rd_i == 5'd20)  reg_r20_q <= rd_value_i;
            if (rd_i == 5'd21)  reg_r21_q <= rd_value_i;
            if (rd_i == 5'd22)  reg_r22_q <= rd_value_i;
            if (rd_i == 5'd23)  reg_r23_q <= rd_value_i;
            if (rd_i == 5'd24)  reg_r24_q <= rd_value_i;
            if (rd_i == 5'd25)  reg_r25_q <= rd_value_i;
            if (rd_i == 5'd26)  reg_r26_q <= rd_value_i;
            if (rd_i == 5'd27)  reg_r27_q <= rd_value_i;
            if (rd_i == 5'd28)  reg_r28_q <= rd_value_i;
            if (rd_i == 5'd29)  reg_r29_q <= rd_value_i;
            if (rd_i == 5'd30)  reg_r30_q <= rd_value_i;
            if (rd_i == 5'd31)  reg_r31_q <= rd_value_i;
        end
    end

    //-------------------------------------------------------------------------
    // Asynchronous read
    //-------------------------------------------------------------------------
    reg [31:0] rs1_value_r;
    reg [31:0] rs2_value_r;
    always @(*) begin
        case(rs1_i)
            5'd1 :   rs1_value_r = reg_r1_q ;
            5'd2 :   rs1_value_r = reg_r2_q ;
            5'd3 :   rs1_value_r = reg_r3_q ;
            5'd4 :   rs1_value_r = reg_r4_q ;
            5'd5 :   rs1_value_r = reg_r5_q ;
            5'd6 :   rs1_value_r = reg_r6_q ;
            5'd7 :   rs1_value_r = reg_r7_q ;
            5'd8 :   rs1_value_r = reg_r8_q ;
            5'd9 :   rs1_value_r = reg_r9_q ;
            5'd10:   rs1_value_r = reg_r10_q;
            5'd12:   rs1_value_r = reg_r12_q;
            5'd13:   rs1_value_r = reg_r13_q;
            5'd14:   rs1_value_r = reg_r14_q;
            5'd15:   rs1_value_r = reg_r15_q;
            5'd16:   rs1_value_r = reg_r16_q;
            5'd17:   rs1_value_r = reg_r17_q;
            5'd18:   rs1_value_r = reg_r18_q;
            5'd19:   rs1_value_r = reg_r19_q;
            5'd20:   rs1_value_r = reg_r20_q;
            5'd21:   rs1_value_r = reg_r21_q;
            5'd22:   rs1_value_r = reg_r22_q;
            5'd23:   rs1_value_r = reg_r23_q;
            5'd24:   rs1_value_r = reg_r24_q;
            5'd25:   rs1_value_r = reg_r25_q;
            5'd26:   rs1_value_r = reg_r26_q;
            5'd27:   rs1_value_r = reg_r27_q;
            5'd28:   rs1_value_r = reg_r28_q;
            5'd29:   rs1_value_r = reg_r29_q;
            5'd30:   rs1_value_r = reg_r30_q;
            5'd31:   rs1_value_r = reg_r31_q;
            default: rs1_value_r = 32'h0000_0000;
        endcase

        case (rs2_i)
            5'd1 :   rs2_value_r = reg_r1_q ;
            5'd2 :   rs2_value_r = reg_r2_q ;
            5'd3 :   rs2_value_r = reg_r3_q ;
            5'd4 :   rs2_value_r = reg_r4_q ;
            5'd5 :   rs2_value_r = reg_r5_q ;
            5'd6 :   rs2_value_r = reg_r6_q ;
            5'd7 :   rs2_value_r = reg_r7_q ;
            5'd8 :   rs2_value_r = reg_r8_q ;
            5'd9 :   rs2_value_r = reg_r9_q ;
            5'd10:   rs2_value_r = reg_r10_q;
            5'd12:   rs2_value_r = reg_r12_q;
            5'd13:   rs2_value_r = reg_r13_q;
            5'd14:   rs2_value_r = reg_r14_q;
            5'd15:   rs2_value_r = reg_r15_q;
            5'd16:   rs2_value_r = reg_r16_q;
            5'd17:   rs2_value_r = reg_r17_q;
            5'd18:   rs2_value_r = reg_r18_q;
            5'd19:   rs2_value_r = reg_r19_q;
            5'd20:   rs2_value_r = reg_r20_q;
            5'd21:   rs2_value_r = reg_r21_q;
            5'd22:   rs2_value_r = reg_r22_q;
            5'd23:   rs2_value_r = reg_r23_q;
            5'd24:   rs2_value_r = reg_r24_q;
            5'd25:   rs2_value_r = reg_r25_q;
            5'd26:   rs2_value_r = reg_r26_q;
            5'd27:   rs2_value_r = reg_r27_q;
            5'd28:   rs2_value_r = reg_r28_q;
            5'd29:   rs2_value_r = reg_r29_q;
            5'd30:   rs2_value_r = reg_r30_q;
            5'd31:   rs2_value_r = reg_r31_q;
            default: rs2_value_r = 32'h0000_0000;
        endcase
    end
    assign read_rs1_o = rs1_value_r ; 
    assign read_rs2_o = rs2_value_r ;
endmodule
