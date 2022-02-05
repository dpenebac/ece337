/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Sat Feb  5 18:06:27 2022
/////////////////////////////////////////////////////////////


module flex_counter ( clk, n_rst, clear, count_enable, rollover_val, count_out, 
        rollover_flag );
  input [2:0] rollover_val;
  output [2:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   n12, n17, n19, n20, n21, n23, n27, n28, n29, n30, n31, n32, n33;
  wire   [2:0] next_count;

  DFFSR \count_out_reg[0]  ( .D(next_count[0]), .CLK(clk), .R(n12), .S(1'b1), 
        .Q(count_out[0]) );
  DFFSR \count_out_reg[1]  ( .D(next_count[1]), .CLK(clk), .R(n12), .S(1'b1), 
        .Q(count_out[1]) );
  DFFSR \count_out_reg[2]  ( .D(next_count[2]), .CLK(clk), .R(n12), .S(1'b1), 
        .Q(count_out[2]) );
  XNOR2X1 U13 ( .A(next_count[1]), .B(next_count[0]), .Y(n19) );
  OAI22X1 U14 ( .A(count_enable), .B(n17), .C(next_count[0]), .D(n20), .Y(
        next_count[0]) );
  XOR2X1 U17 ( .A(n23), .B(next_count[2]), .Y(n21) );
  NAND2X1 U18 ( .A(next_count[0]), .B(next_count[1]), .Y(n23) );
  INVX1 U24 ( .A(n27), .Y(rollover_flag) );
  OAI22X1 U25 ( .A(count_enable), .B(n28), .C(n21), .D(n20), .Y(next_count[2])
         );
  OAI22X1 U26 ( .A(count_enable), .B(n29), .C(n19), .D(n20), .Y(next_count[1])
         );
  NAND2X1 U27 ( .A(count_enable), .B(n27), .Y(n20) );
  NAND3X1 U28 ( .A(n30), .B(n31), .C(n32), .Y(n27) );
  XOR2X1 U29 ( .A(n29), .B(rollover_val[1]), .Y(n32) );
  INVX1 U30 ( .A(count_out[1]), .Y(n29) );
  XOR2X1 U31 ( .A(n28), .B(rollover_val[2]), .Y(n31) );
  INVX1 U32 ( .A(count_out[2]), .Y(n28) );
  XOR2X1 U33 ( .A(n17), .B(rollover_val[0]), .Y(n30) );
  INVX1 U34 ( .A(count_out[0]), .Y(n17) );
  NOR2X1 U35 ( .A(clear), .B(n33), .Y(n12) );
  INVX1 U36 ( .A(n_rst), .Y(n33) );
endmodule

