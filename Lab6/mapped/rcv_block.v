/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Sun Feb 27 21:09:01 2022
/////////////////////////////////////////////////////////////


module start_bit_det ( clk, n_rst, serial_in, start_bit_detected, 
        new_packet_detected );
  input clk, n_rst, serial_in;
  output start_bit_detected, new_packet_detected;
  wire   start_bit_detected, old_sample, new_sample, sync_phase, n4;
  assign new_packet_detected = start_bit_detected;

  DFFSR sync_phase_reg ( .D(serial_in), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        sync_phase) );
  DFFSR new_sample_reg ( .D(sync_phase), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        new_sample) );
  DFFSR old_sample_reg ( .D(new_sample), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        old_sample) );
  NOR2X1 U6 ( .A(new_sample), .B(n4), .Y(start_bit_detected) );
  INVX1 U7 ( .A(old_sample), .Y(n4) );
endmodule


module flex_stp_sr_NUM_BITS9_SHIFT_MSB0 ( clk, n_rst, shift_enable, serial_in, 
        parallel_out );
  output [8:0] parallel_out;
  input clk, n_rst, shift_enable, serial_in;
  wire   n13, n15, n17, n19, n21, n23, n25, n27, n29, n1, n2, n3, n4, n5, n6,
         n7, n8, n9;

  DFFSR \parallel_out_reg[8]  ( .D(n29), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[8]) );
  DFFSR \parallel_out_reg[7]  ( .D(n27), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[7]) );
  DFFSR \parallel_out_reg[6]  ( .D(n25), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[6]) );
  DFFSR \parallel_out_reg[5]  ( .D(n23), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[5]) );
  DFFSR \parallel_out_reg[4]  ( .D(n21), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[4]) );
  DFFSR \parallel_out_reg[3]  ( .D(n19), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[3]) );
  DFFSR \parallel_out_reg[2]  ( .D(n17), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[2]) );
  DFFSR \parallel_out_reg[1]  ( .D(n15), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[1]) );
  DFFSR \parallel_out_reg[0]  ( .D(n13), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        parallel_out[0]) );
  INVX1 U2 ( .A(n1), .Y(n29) );
  MUX2X1 U3 ( .B(parallel_out[8]), .A(serial_in), .S(shift_enable), .Y(n1) );
  INVX1 U4 ( .A(n2), .Y(n27) );
  MUX2X1 U5 ( .B(parallel_out[7]), .A(parallel_out[8]), .S(shift_enable), .Y(
        n2) );
  INVX1 U6 ( .A(n3), .Y(n25) );
  MUX2X1 U7 ( .B(parallel_out[6]), .A(parallel_out[7]), .S(shift_enable), .Y(
        n3) );
  INVX1 U8 ( .A(n4), .Y(n23) );
  MUX2X1 U9 ( .B(parallel_out[5]), .A(parallel_out[6]), .S(shift_enable), .Y(
        n4) );
  INVX1 U10 ( .A(n5), .Y(n21) );
  MUX2X1 U11 ( .B(parallel_out[4]), .A(parallel_out[5]), .S(shift_enable), .Y(
        n5) );
  INVX1 U12 ( .A(n6), .Y(n19) );
  MUX2X1 U13 ( .B(parallel_out[3]), .A(parallel_out[4]), .S(shift_enable), .Y(
        n6) );
  INVX1 U14 ( .A(n7), .Y(n17) );
  MUX2X1 U15 ( .B(parallel_out[2]), .A(parallel_out[3]), .S(shift_enable), .Y(
        n7) );
  INVX1 U16 ( .A(n8), .Y(n15) );
  MUX2X1 U17 ( .B(parallel_out[1]), .A(parallel_out[2]), .S(shift_enable), .Y(
        n8) );
  INVX1 U18 ( .A(n9), .Y(n13) );
  MUX2X1 U19 ( .B(parallel_out[0]), .A(parallel_out[1]), .S(shift_enable), .Y(
        n9) );
endmodule


module sr_9bit ( clk, n_rst, shift_strobe, serial_in, packet_data, stop_bit );
  output [7:0] packet_data;
  input clk, n_rst, shift_strobe, serial_in;
  output stop_bit;


  flex_stp_sr_NUM_BITS9_SHIFT_MSB0 CORE ( .clk(clk), .n_rst(n_rst), 
        .shift_enable(shift_strobe), .serial_in(serial_in), .parallel_out({
        stop_bit, packet_data}) );
endmodule


module stop_bit_chk ( clk, n_rst, sbc_clear, sbc_enable, stop_bit, 
        framing_error );
  input clk, n_rst, sbc_clear, sbc_enable, stop_bit;
  output framing_error;
  wire   n5, n2, n3;

  DFFSR framing_error_reg ( .D(n5), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        framing_error) );
  NOR2X1 U3 ( .A(sbc_clear), .B(n2), .Y(n5) );
  MUX2X1 U4 ( .B(framing_error), .A(n3), .S(sbc_enable), .Y(n2) );
  INVX1 U5 ( .A(stop_bit), .Y(n3) );
endmodule


module flex_counter_NUM_CNT_BITS4_1 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42, n43, n44;
  wire   [3:0] next_count;

  DFFSR \count_out_reg[0]  ( .D(next_count[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(next_count[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(next_count[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(next_count[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[3]) );
  DFFSR rollover_flag_reg ( .D(n44), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  MUX2X1 U7 ( .B(n1), .A(n2), .S(count_out[3]), .Y(next_count[3]) );
  OAI21X1 U9 ( .A(n3), .B(n4), .C(n5), .Y(n2) );
  NAND3X1 U10 ( .A(count_out[2]), .B(n6), .C(count_out[1]), .Y(n1) );
  MUX2X1 U11 ( .B(n7), .A(n8), .S(count_out[2]), .Y(next_count[2]) );
  NAND2X1 U12 ( .A(n4), .B(n5), .Y(n8) );
  NAND2X1 U13 ( .A(count_out[0]), .B(count_out[1]), .Y(n4) );
  NAND2X1 U14 ( .A(count_out[1]), .B(n6), .Y(n7) );
  INVX1 U15 ( .A(next_count[0]), .Y(n6) );
  MUX2X1 U16 ( .B(next_count[0]), .A(n9), .S(count_out[1]), .Y(next_count[1])
         );
  NAND2X1 U17 ( .A(n5), .B(n10), .Y(n9) );
  NAND2X1 U18 ( .A(count_out[0]), .B(n5), .Y(next_count[0]) );
  NAND2X1 U19 ( .A(count_enable), .B(n16), .Y(n5) );
  AOI21X1 U20 ( .A(n17), .B(rollover_val[3]), .C(n18), .Y(n16) );
  INVX1 U21 ( .A(n19), .Y(n18) );
  OAI21X1 U22 ( .A(rollover_val[3]), .B(n17), .C(n20), .Y(n19) );
  NOR2X1 U23 ( .A(n21), .B(n22), .Y(n20) );
  AOI21X1 U24 ( .A(rollover_val[2]), .B(n3), .C(n23), .Y(n22) );
  OAI21X1 U25 ( .A(count_out[1]), .B(n24), .C(n25), .Y(n23) );
  NAND3X1 U26 ( .A(n26), .B(n10), .C(rollover_val[0]), .Y(n25) );
  INVX1 U27 ( .A(count_out[3]), .Y(n17) );
  NOR2X1 U28 ( .A(n27), .B(n28), .Y(n44) );
  NAND2X1 U29 ( .A(n29), .B(n30), .Y(n28) );
  MUX2X1 U30 ( .B(n31), .A(n32), .S(n33), .Y(n30) );
  NOR2X1 U31 ( .A(rollover_val[3]), .B(rollover_val[2]), .Y(n32) );
  NAND3X1 U32 ( .A(n26), .B(n34), .C(n35), .Y(n31) );
  AOI22X1 U33 ( .A(count_out[1]), .B(n36), .C(rollover_val[2]), .D(n3), .Y(n35) );
  INVX1 U34 ( .A(n21), .Y(n34) );
  NOR2X1 U35 ( .A(n3), .B(rollover_val[2]), .Y(n21) );
  NAND2X1 U36 ( .A(count_out[1]), .B(n24), .Y(n26) );
  MUX2X1 U37 ( .B(n10), .A(n37), .S(rollover_val[0]), .Y(n29) );
  OAI21X1 U38 ( .A(count_out[1]), .B(n24), .C(n10), .Y(n37) );
  INVX1 U39 ( .A(count_out[0]), .Y(n10) );
  NAND3X1 U40 ( .A(n38), .B(n39), .C(count_enable), .Y(n27) );
  OAI21X1 U41 ( .A(n40), .B(n41), .C(n33), .Y(n39) );
  INVX1 U42 ( .A(n42), .Y(n33) );
  INVX1 U43 ( .A(count_out[1]), .Y(n41) );
  XOR2X1 U44 ( .A(n3), .B(rollover_val[2]), .Y(n40) );
  INVX1 U45 ( .A(count_out[2]), .Y(n3) );
  XOR2X1 U46 ( .A(n43), .B(count_out[3]), .Y(n38) );
  OAI21X1 U47 ( .A(rollover_val[2]), .B(n42), .C(rollover_val[3]), .Y(n43) );
  NAND2X1 U48 ( .A(n36), .B(n24), .Y(n42) );
  INVX1 U49 ( .A(rollover_val[1]), .Y(n24) );
  INVX1 U50 ( .A(rollover_val[0]), .Y(n36) );
endmodule


module flex_counter_NUM_CNT_BITS4_0 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42, n43, n44;
  wire   [3:0] next_count;

  DFFSR \count_out_reg[0]  ( .D(next_count[0]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(next_count[1]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(next_count[2]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(next_count[3]), .CLK(clk), .R(n_rst), .S(1'b1), 
        .Q(count_out[3]) );
  DFFSR rollover_flag_reg ( .D(n44), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        rollover_flag) );
  MUX2X1 U7 ( .B(n1), .A(n2), .S(count_out[3]), .Y(next_count[3]) );
  OAI21X1 U9 ( .A(n3), .B(n4), .C(n5), .Y(n2) );
  NAND3X1 U10 ( .A(count_out[2]), .B(n6), .C(count_out[1]), .Y(n1) );
  MUX2X1 U11 ( .B(n7), .A(n8), .S(count_out[2]), .Y(next_count[2]) );
  NAND2X1 U12 ( .A(n4), .B(n5), .Y(n8) );
  NAND2X1 U13 ( .A(count_out[0]), .B(count_out[1]), .Y(n4) );
  NAND2X1 U14 ( .A(count_out[1]), .B(n6), .Y(n7) );
  INVX1 U15 ( .A(next_count[0]), .Y(n6) );
  MUX2X1 U16 ( .B(next_count[0]), .A(n9), .S(count_out[1]), .Y(next_count[1])
         );
  NAND2X1 U17 ( .A(n5), .B(n10), .Y(n9) );
  NAND2X1 U18 ( .A(count_out[0]), .B(n5), .Y(next_count[0]) );
  NAND2X1 U19 ( .A(count_enable), .B(n16), .Y(n5) );
  AOI21X1 U20 ( .A(n17), .B(rollover_val[3]), .C(n18), .Y(n16) );
  INVX1 U21 ( .A(n19), .Y(n18) );
  OAI21X1 U22 ( .A(rollover_val[3]), .B(n17), .C(n20), .Y(n19) );
  NOR2X1 U23 ( .A(n21), .B(n22), .Y(n20) );
  AOI21X1 U24 ( .A(rollover_val[2]), .B(n3), .C(n23), .Y(n22) );
  OAI21X1 U25 ( .A(count_out[1]), .B(n24), .C(n25), .Y(n23) );
  NAND3X1 U26 ( .A(n26), .B(n10), .C(rollover_val[0]), .Y(n25) );
  INVX1 U27 ( .A(count_out[3]), .Y(n17) );
  NOR2X1 U28 ( .A(n27), .B(n28), .Y(n44) );
  NAND2X1 U29 ( .A(n29), .B(n30), .Y(n28) );
  MUX2X1 U30 ( .B(n31), .A(n32), .S(n33), .Y(n30) );
  NOR2X1 U31 ( .A(rollover_val[3]), .B(rollover_val[2]), .Y(n32) );
  NAND3X1 U32 ( .A(n26), .B(n34), .C(n35), .Y(n31) );
  AOI22X1 U33 ( .A(count_out[1]), .B(n36), .C(rollover_val[2]), .D(n3), .Y(n35) );
  INVX1 U34 ( .A(n21), .Y(n34) );
  NOR2X1 U35 ( .A(n3), .B(rollover_val[2]), .Y(n21) );
  NAND2X1 U36 ( .A(count_out[1]), .B(n24), .Y(n26) );
  MUX2X1 U37 ( .B(n10), .A(n37), .S(rollover_val[0]), .Y(n29) );
  OAI21X1 U38 ( .A(count_out[1]), .B(n24), .C(n10), .Y(n37) );
  INVX1 U39 ( .A(count_out[0]), .Y(n10) );
  NAND3X1 U40 ( .A(n38), .B(n39), .C(count_enable), .Y(n27) );
  OAI21X1 U41 ( .A(n40), .B(n41), .C(n33), .Y(n39) );
  INVX1 U42 ( .A(n42), .Y(n33) );
  INVX1 U43 ( .A(count_out[1]), .Y(n41) );
  XOR2X1 U44 ( .A(n3), .B(rollover_val[2]), .Y(n40) );
  INVX1 U45 ( .A(count_out[2]), .Y(n3) );
  XOR2X1 U46 ( .A(n43), .B(count_out[3]), .Y(n38) );
  OAI21X1 U47 ( .A(rollover_val[2]), .B(n42), .C(rollover_val[3]), .Y(n43) );
  NAND2X1 U48 ( .A(n36), .B(n24), .Y(n42) );
  INVX1 U49 ( .A(rollover_val[1]), .Y(n24) );
  INVX1 U50 ( .A(rollover_val[0]), .Y(n36) );
endmodule


module timer ( clk, n_rst, enable_timer, shift_strobe, packet_done );
  input clk, n_rst, enable_timer;
  output shift_strobe, packet_done;
  wire   clear, N0, n2;

  DFFSR clear_reg ( .D(N0), .CLK(clk), .R(n_rst), .S(1'b1), .Q(clear) );
  flex_counter_NUM_CNT_BITS4_1 ClockCount ( .clk(clk), .n_rst(n_rst), .clear(
        clear), .count_enable(enable_timer), .rollover_val({1'b1, 1'b0, 1'b1, 
        1'b0}), .rollover_flag(shift_strobe) );
  flex_counter_NUM_CNT_BITS4_0 BitCount ( .clk(clk), .n_rst(n_rst), .clear(
        clear), .count_enable(shift_strobe), .rollover_val({1'b1, 1'b0, 1'b0, 
        1'b1}), .rollover_flag(packet_done) );
  NAND2X1 U4 ( .A(enable_timer), .B(n2), .Y(N0) );
  INVX1 U5 ( .A(packet_done), .Y(n2) );
endmodule


module rcu ( clk, n_rst, new_packet_detected, packet_done, framing_error, 
        sbc_clear, sbc_enable, load_buffer, enable_timer );
  input clk, n_rst, new_packet_detected, packet_done, framing_error;
  output sbc_clear, sbc_enable, load_buffer, enable_timer;
  wire   n26, n27, n28, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15,
         n16;
  wire   [2:0] s;

  DFFSR \s_reg[0]  ( .D(n28), .CLK(clk), .R(n_rst), .S(1'b1), .Q(s[0]) );
  DFFSR \s_reg[1]  ( .D(n27), .CLK(clk), .R(n_rst), .S(1'b1), .Q(s[1]) );
  DFFSR \s_reg[2]  ( .D(n26), .CLK(clk), .R(n_rst), .S(1'b1), .Q(s[2]) );
  NOR2X1 U6 ( .A(n4), .B(n5), .Y(load_buffer) );
  NOR2X1 U7 ( .A(n6), .B(n7), .Y(sbc_clear) );
  NAND2X1 U8 ( .A(s[2]), .B(n8), .Y(n7) );
  NOR2X1 U9 ( .A(n9), .B(n8), .Y(sbc_enable) );
  OAI21X1 U10 ( .A(n6), .B(n10), .C(n11), .Y(n28) );
  AOI21X1 U11 ( .A(n12), .B(n13), .C(enable_timer), .Y(n11) );
  INVX1 U12 ( .A(n14), .Y(n13) );
  AOI21X1 U13 ( .A(s[1]), .B(n15), .C(s[2]), .Y(n12) );
  NAND2X1 U14 ( .A(framing_error), .B(n6), .Y(n15) );
  OAI21X1 U15 ( .A(n9), .B(n14), .C(n10), .Y(n27) );
  OAI22X1 U16 ( .A(packet_done), .B(n16), .C(new_packet_detected), .D(n5), .Y(
        n14) );
  NAND2X1 U17 ( .A(n6), .B(n8), .Y(n5) );
  INVX1 U18 ( .A(s[0]), .Y(n6) );
  INVX1 U19 ( .A(enable_timer), .Y(n16) );
  NOR2X1 U20 ( .A(n9), .B(s[1]), .Y(enable_timer) );
  NAND2X1 U21 ( .A(s[0]), .B(n4), .Y(n9) );
  INVX1 U22 ( .A(s[2]), .Y(n4) );
  OAI21X1 U23 ( .A(s[0]), .B(n8), .C(n10), .Y(n26) );
  NAND2X1 U24 ( .A(s[1]), .B(s[2]), .Y(n10) );
  INVX1 U25 ( .A(s[1]), .Y(n8) );
endmodule


module rx_data_buff ( clk, n_rst, load_buffer, packet_data, data_read, rx_data, 
        data_ready, overrun_error );
  input [7:0] packet_data;
  output [7:0] rx_data;
  input clk, n_rst, load_buffer, data_read;
  output data_ready, overrun_error;
  wire   n30, n31, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n15, n17, n19,
         n21, n23, n25, n27, n29;

  DFFSR \rx_data_reg[7]  ( .D(n15), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[7]) );
  DFFSR \rx_data_reg[6]  ( .D(n17), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[6]) );
  DFFSR \rx_data_reg[5]  ( .D(n19), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[5]) );
  DFFSR \rx_data_reg[4]  ( .D(n21), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[4]) );
  DFFSR \rx_data_reg[3]  ( .D(n23), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[3]) );
  DFFSR \rx_data_reg[2]  ( .D(n25), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[2]) );
  DFFSR \rx_data_reg[1]  ( .D(n27), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[1]) );
  DFFSR \rx_data_reg[0]  ( .D(n29), .CLK(clk), .R(1'b1), .S(n_rst), .Q(
        rx_data[0]) );
  DFFSR data_ready_reg ( .D(n31), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        data_ready) );
  DFFSR overrun_error_reg ( .D(n30), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        overrun_error) );
  INVX1 U3 ( .A(n1), .Y(n15) );
  MUX2X1 U4 ( .B(rx_data[7]), .A(packet_data[7]), .S(load_buffer), .Y(n1) );
  INVX1 U5 ( .A(n2), .Y(n17) );
  MUX2X1 U6 ( .B(rx_data[6]), .A(packet_data[6]), .S(load_buffer), .Y(n2) );
  INVX1 U7 ( .A(n3), .Y(n19) );
  MUX2X1 U8 ( .B(rx_data[5]), .A(packet_data[5]), .S(load_buffer), .Y(n3) );
  INVX1 U9 ( .A(n4), .Y(n21) );
  MUX2X1 U10 ( .B(rx_data[4]), .A(packet_data[4]), .S(load_buffer), .Y(n4) );
  INVX1 U11 ( .A(n5), .Y(n23) );
  MUX2X1 U12 ( .B(rx_data[3]), .A(packet_data[3]), .S(load_buffer), .Y(n5) );
  INVX1 U13 ( .A(n6), .Y(n25) );
  MUX2X1 U14 ( .B(rx_data[2]), .A(packet_data[2]), .S(load_buffer), .Y(n6) );
  INVX1 U15 ( .A(n7), .Y(n27) );
  MUX2X1 U16 ( .B(rx_data[1]), .A(packet_data[1]), .S(load_buffer), .Y(n7) );
  INVX1 U17 ( .A(n8), .Y(n29) );
  MUX2X1 U18 ( .B(rx_data[0]), .A(packet_data[0]), .S(load_buffer), .Y(n8) );
  OAI21X1 U19 ( .A(data_read), .B(n9), .C(n10), .Y(n31) );
  INVX1 U20 ( .A(load_buffer), .Y(n10) );
  INVX1 U21 ( .A(data_ready), .Y(n9) );
  NOR2X1 U22 ( .A(data_read), .B(n11), .Y(n30) );
  AOI21X1 U23 ( .A(data_ready), .B(load_buffer), .C(overrun_error), .Y(n11) );
endmodule


module rcv_block ( clk, n_rst, serial_in, data_read, rx_data, data_ready, 
        overrun_error, framing_error );
  output [7:0] rx_data;
  input clk, n_rst, serial_in, data_read;
  output data_ready, overrun_error, framing_error;
  wire   new_packet_detected, shift_strobe, stop_bit, sbc_clear, sbc_enable,
         enable_timer, packet_done, load_buffer;
  wire   [7:0] packet_data;

  start_bit_det START_BD ( .clk(clk), .n_rst(n_rst), .serial_in(serial_in), 
        .new_packet_detected(new_packet_detected) );
  sr_9bit SR9 ( .clk(clk), .n_rst(n_rst), .shift_strobe(shift_strobe), 
        .serial_in(serial_in), .packet_data(packet_data), .stop_bit(stop_bit)
         );
  stop_bit_chk STOP_BD ( .clk(clk), .n_rst(n_rst), .sbc_clear(sbc_clear), 
        .sbc_enable(sbc_enable), .stop_bit(stop_bit), .framing_error(
        framing_error) );
  timer TIMER ( .clk(clk), .n_rst(n_rst), .enable_timer(enable_timer), 
        .shift_strobe(shift_strobe), .packet_done(packet_done) );
  rcu RCU ( .clk(clk), .n_rst(n_rst), .new_packet_detected(new_packet_detected), .packet_done(packet_done), .framing_error(framing_error), .sbc_clear(
        sbc_clear), .sbc_enable(sbc_enable), .load_buffer(load_buffer), 
        .enable_timer(enable_timer) );
  rx_data_buff RX_DATA_BUFFER ( .clk(clk), .n_rst(n_rst), .load_buffer(
        load_buffer), .packet_data(packet_data), .data_read(data_read), 
        .rx_data(rx_data), .data_ready(data_ready), .overrun_error(
        overrun_error) );
endmodule

