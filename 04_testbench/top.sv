module top(
    input logic        clk_i   ,
    input logic        rstn_i  
);
    logic [31:0] count_cyc = 0;

    RISCV dut(
        .clk_i  (clk_i),
        .rstn_i (rstn_i)
    );

    always @(posedge clk_i) begin
        count_cyc <= count_cyc + 1;
        if ((count_cyc >= 2) && (count_cyc <= 10)) begin
            $display("------------------%d---------------------------", count_cyc);
            $display ( "x0_zero: %h", dut.ID_stage_inst.RF_inst0.x0_zero_w ); 
            $display ( "x1_ra  : %h", dut.ID_stage_inst.RF_inst0.x1_ra_w   );   
            $display ( "x2_sp  : %h", dut.ID_stage_inst.RF_inst0.x2_sp_w   );   
            $display ( "x3_gp  : %h", dut.ID_stage_inst.RF_inst0.x3_gp_w   );   
            $display ( "x4_tp  : %h", dut.ID_stage_inst.RF_inst0.x4_tp_w   );   
            $display ( "x5_t0  : %h", dut.ID_stage_inst.RF_inst0.x5_t0_w   );   
            $display ( "x6_t1  : %h", dut.ID_stage_inst.RF_inst0.x6_t1_w   );   
            $display ( "x7_t2  : %h", dut.ID_stage_inst.RF_inst0.x7_t2_w   );   
            $display ( "x8_s0  : %h", dut.ID_stage_inst.RF_inst0.x8_s0_w   );   
            $display ( "x9_s1  : %h", dut.ID_stage_inst.RF_inst0.x9_s1_w   );   
            $display ( "x10_a0 : %h", dut.ID_stage_inst.RF_inst0.x10_a0_w  );  
            $display ( "x11_a1 : %h", dut.ID_stage_inst.RF_inst0.x11_a1_w  );  
            $display ( "x12_a2 : %h", dut.ID_stage_inst.RF_inst0.x12_a2_w  );  
            $display ( "x13_a3 : %h", dut.ID_stage_inst.RF_inst0.x13_a3_w  );  
            $display ( "x14_a4 : %h", dut.ID_stage_inst.RF_inst0.x14_a4_w  );  
            $display ( "x15_a5 : %h", dut.ID_stage_inst.RF_inst0.x15_a5_w  );  
            $display ( "x16_a6 : %h", dut.ID_stage_inst.RF_inst0.x16_a6_w  );  
            $display ( "x17_a7 : %h", dut.ID_stage_inst.RF_inst0.x17_a7_w  );  
            $display ( "x18_s2 : %h", dut.ID_stage_inst.RF_inst0.x18_s2_w  );  
            $display ( "x19_s3 : %h", dut.ID_stage_inst.RF_inst0.x19_s3_w  );  
            $display ( "x20_s4 : %h", dut.ID_stage_inst.RF_inst0.x20_s4_w  );  
            $display ( "x21_s5 : %h", dut.ID_stage_inst.RF_inst0.x21_s5_w  );  
            $display ( "x22_s6 : %h", dut.ID_stage_inst.RF_inst0.x22_s6_w  );  
            $display ( "x23_s7 : %h", dut.ID_stage_inst.RF_inst0.x23_s7_w  );  
            $display ( "x24_s8 : %h", dut.ID_stage_inst.RF_inst0.x24_s8_w  );  
            $display ( "x25_s9 : %h", dut.ID_stage_inst.RF_inst0.x25_s9_w  );  
            $display ( "x26_s10: %h", dut.ID_stage_inst.RF_inst0.x26_s10_w ); 
            $display ( "x27_s11: %h", dut.ID_stage_inst.RF_inst0.x27_s11_w ); 
            $display ( "x28_t3 : %h", dut.ID_stage_inst.RF_inst0.x28_t3_w  );  
            $display ( "x29_t4 : %h", dut.ID_stage_inst.RF_inst0.x29_t4_w  );  
            $display ( "x30_t5 : %h", dut.ID_stage_inst.RF_inst0.x30_t5_w  );  
            $display ( "x31_t6 : %h", dut.ID_stage_inst.RF_inst0.x31_t6_w  );  
            $fflush();
        end
    end
endmodule
