/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Sun Feb 27 17:57:10 2022
/////////////////////////////////////////////////////////////


module flex_counter ( clk, n_rst, clear, count_enable, rollover_val, count_out, 
        rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   n10, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52, n53, n54, n55, n56, n57;

  DFFSR \count_out_reg[0]  ( .D(n38), .CLK(clk), .R(n10), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \count_out_reg[2]  ( .D(n36), .CLK(clk), .R(n10), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(n35), .CLK(clk), .R(n10), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[1]  ( .D(n37), .CLK(clk), .R(n10), .S(1'b1), .Q(
        count_out[1]) );
  MUX2X1 U36 ( .B(n39), .A(n40), .S(count_out[0]), .Y(n38) );
  NOR2X1 U37 ( .A(rollover_flag), .B(n39), .Y(n40) );
  INVX1 U38 ( .A(count_enable), .Y(n39) );
  MUX2X1 U39 ( .B(n41), .A(n42), .S(count_out[1]), .Y(n37) );
  MUX2X1 U40 ( .B(n43), .A(n44), .S(n45), .Y(n36) );
  NAND2X1 U41 ( .A(n46), .B(count_out[1]), .Y(n44) );
  INVX1 U42 ( .A(n47), .Y(n43) );
  MUX2X1 U43 ( .B(n48), .A(n49), .S(count_out[3]), .Y(n35) );
  AOI21X1 U44 ( .A(n50), .B(n45), .C(n47), .Y(n49) );
  OAI21X1 U45 ( .A(count_out[1]), .B(rollover_flag), .C(n42), .Y(n47) );
  INVX1 U46 ( .A(n51), .Y(n42) );
  OAI21X1 U47 ( .A(count_out[0]), .B(rollover_flag), .C(count_enable), .Y(n51)
         );
  INVX1 U48 ( .A(n50), .Y(rollover_flag) );
  INVX1 U49 ( .A(count_out[2]), .Y(n45) );
  NAND3X1 U50 ( .A(count_out[2]), .B(count_out[1]), .C(n46), .Y(n48) );
  INVX1 U51 ( .A(n41), .Y(n46) );
  NAND3X1 U52 ( .A(count_out[0]), .B(n50), .C(count_enable), .Y(n41) );
  NAND3X1 U53 ( .A(n52), .B(n53), .C(n54), .Y(n50) );
  NOR2X1 U54 ( .A(n55), .B(n56), .Y(n54) );
  XOR2X1 U55 ( .A(rollover_val[1]), .B(count_out[1]), .Y(n56) );
  XOR2X1 U56 ( .A(rollover_val[0]), .B(count_out[0]), .Y(n55) );
  XNOR2X1 U57 ( .A(count_out[2]), .B(rollover_val[2]), .Y(n53) );
  XNOR2X1 U58 ( .A(count_out[3]), .B(rollover_val[3]), .Y(n52) );
  NOR2X1 U59 ( .A(clear), .B(n57), .Y(n10) );
  INVX1 U60 ( .A(n_rst), .Y(n57) );
endmodule

