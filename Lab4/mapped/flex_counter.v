/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Sun Feb  6 11:48:06 2022
/////////////////////////////////////////////////////////////


module flex_counter ( clk, n_rst, clear, count_enable, rollover_val, count_out, 
        rollover_flag );
  input [2:0] rollover_val;
  output [2:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   n9, n28, n29, n43, n44, n45, n46, n48, n49, n50, n51, n52, n53, n54,
         n55, n56, n57, n58, n59;

  DFFSR \count_out_reg[0]  ( .D(n29), .CLK(clk), .R(n9), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[2]  ( .D(n28), .CLK(clk), .R(n9), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[1]  ( .D(n45), .CLK(clk), .R(n9), .S(1'b1), .Q(
        count_out[1]) );
  INVX2 U27 ( .A(n_rst), .Y(n43) );
  INVX2 U28 ( .A(count_enable), .Y(n44) );
  INVX2 U29 ( .A(n55), .Y(n45) );
  INVX2 U30 ( .A(n56), .Y(n46) );
  INVX2 U31 ( .A(n53), .Y(rollover_flag) );
  INVX2 U32 ( .A(count_out[2]), .Y(n48) );
  INVX2 U33 ( .A(count_out[1]), .Y(n49) );
  NOR2X1 U34 ( .A(clear), .B(n43), .Y(n9) );
  OAI21X1 U35 ( .A(count_out[0]), .B(n44), .C(n50), .Y(n29) );
  OAI21X1 U36 ( .A(rollover_flag), .B(n44), .C(count_out[0]), .Y(n50) );
  OAI21X1 U37 ( .A(n51), .B(n48), .C(n52), .Y(n28) );
  NAND3X1 U38 ( .A(count_out[1]), .B(n48), .C(n46), .Y(n52) );
  AOI21X1 U39 ( .A(n53), .B(n49), .C(n54), .Y(n51) );
  AOI22X1 U40 ( .A(n54), .B(count_out[1]), .C(n49), .D(n46), .Y(n55) );
  NAND3X1 U41 ( .A(count_out[0]), .B(n53), .C(count_enable), .Y(n56) );
  OAI21X1 U42 ( .A(count_out[0]), .B(rollover_flag), .C(count_enable), .Y(n54)
         );
  NAND3X1 U43 ( .A(n57), .B(n58), .C(n59), .Y(n53) );
  XNOR2X1 U44 ( .A(count_out[2]), .B(rollover_val[2]), .Y(n59) );
  XNOR2X1 U45 ( .A(count_out[0]), .B(rollover_val[0]), .Y(n58) );
  XNOR2X1 U46 ( .A(count_out[1]), .B(rollover_val[1]), .Y(n57) );
endmodule

