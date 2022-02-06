/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Sat Feb  5 19:46:03 2022
/////////////////////////////////////////////////////////////


module flex_counter ( clk, n_rst, clear, count_enable, rollover_val, count_out, 
        rollover_flag );
  input [2:0] rollover_val;
  output [2:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   n9, n12, n29, n30, n31, n32, n33, n34, n35, n36, n37, n38, n39, n40,
         n41, n42, n43, n44;

  DFFSR \count_out_reg[0]  ( .D(n30), .CLK(clk), .R(n9), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[2]  ( .D(n29), .CLK(clk), .R(n9), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[1]  ( .D(n12), .CLK(clk), .R(n9), .S(1'b1), .Q(
        count_out[1]) );
  NOR2X1 U28 ( .A(clear), .B(n31), .Y(n9) );
  INVX1 U29 ( .A(n_rst), .Y(n31) );
  MUX2X1 U30 ( .B(n32), .A(n33), .S(count_out[0]), .Y(n30) );
  NOR2X1 U31 ( .A(n32), .B(rollover_flag), .Y(n33) );
  MUX2X1 U32 ( .B(n34), .A(n35), .S(count_out[2]), .Y(n29) );
  AOI21X1 U33 ( .A(n36), .B(n37), .C(n38), .Y(n35) );
  OR2X1 U34 ( .A(n39), .B(n37), .Y(n34) );
  MUX2X1 U35 ( .B(n40), .A(n39), .S(n37), .Y(n12) );
  INVX1 U36 ( .A(count_out[1]), .Y(n37) );
  NAND3X1 U37 ( .A(n36), .B(n41), .C(count_out[0]), .Y(n39) );
  INVX1 U38 ( .A(n38), .Y(n40) );
  OAI21X1 U39 ( .A(count_out[0]), .B(rollover_flag), .C(n41), .Y(n38) );
  INVX1 U40 ( .A(n32), .Y(n41) );
  NOR2X1 U41 ( .A(count_enable), .B(rollover_flag), .Y(n32) );
  INVX1 U42 ( .A(n36), .Y(rollover_flag) );
  NAND3X1 U43 ( .A(n42), .B(n43), .C(n44), .Y(n36) );
  XNOR2X1 U44 ( .A(count_out[1]), .B(rollover_val[1]), .Y(n44) );
  XNOR2X1 U45 ( .A(count_out[2]), .B(rollover_val[2]), .Y(n43) );
  XNOR2X1 U46 ( .A(count_out[0]), .B(rollover_val[0]), .Y(n42) );
endmodule

