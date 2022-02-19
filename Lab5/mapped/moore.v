/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Mon Feb 14 17:27:27 2022
/////////////////////////////////////////////////////////////


module moore ( clk, n_rst, i, o, peek );
  input clk, n_rst, i;
  output o, peek;
  wire   N26, N27, N28, n13, n14, n15, n16, n17, n18, n19, n20;
  wire   [2:0] s;

  DFFSR \s_reg[0]  ( .D(N27), .CLK(clk), .R(n_rst), .S(1'b1), .Q(s[0]) );
  DFFSR \s_reg[1]  ( .D(N28), .CLK(clk), .R(n_rst), .S(1'b1), .Q(s[1]) );
  DFFSR o_reg ( .D(N26), .CLK(clk), .R(n_rst), .S(1'b1), .Q(o) );
  DFFSR \s_reg[2]  ( .D(N26), .CLK(clk), .R(n_rst), .S(1'b1), .Q(s[2]) );
  AOI21X1 U18 ( .A(s[2]), .B(s[0]), .C(n13), .Y(N28) );
  MUX2X1 U19 ( .B(s[1]), .A(n14), .S(n15), .Y(n13) );
  NOR2X1 U20 ( .A(s[1]), .B(n16), .Y(n14) );
  NOR2X1 U21 ( .A(n17), .B(n15), .Y(N27) );
  OR2X1 U22 ( .A(s[0]), .B(s[2]), .Y(n15) );
  XOR2X1 U23 ( .A(n16), .B(s[1]), .Y(n17) );
  INVX1 U24 ( .A(i), .Y(n16) );
  NOR2X1 U25 ( .A(n18), .B(n19), .Y(N26) );
  NAND2X1 U26 ( .A(s[1]), .B(i), .Y(n19) );
  NAND2X1 U27 ( .A(s[0]), .B(n20), .Y(n18) );
  INVX1 U28 ( .A(s[2]), .Y(n20) );
endmodule

