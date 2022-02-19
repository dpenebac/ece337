/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Mon Feb 14 18:52:40 2022
/////////////////////////////////////////////////////////////


module mealy ( clk, n_rst, i, o );
  input clk, n_rst, i;
  output o;
  wire   next_o, N6, N5, N4, n2, n3, n4, n5, n6, n8, n9, n10;

  DFFSR o_reg ( .D(next_o), .CLK(clk), .R(n_rst), .S(1'b1), .Q(o) );
  NOR2X1 U10 ( .A(n3), .B(n5), .Y(N6) );
  NOR2X1 U11 ( .A(n4), .B(n6), .Y(N5) );
  NOR2X1 U12 ( .A(n5), .B(n6), .Y(N4) );
  AOI21X1 U15 ( .A(N6), .B(n2), .C(next_o), .Y(n8) );
  NOR2X1 U16 ( .A(n4), .B(n9), .Y(next_o) );
  NAND2X1 U17 ( .A(i), .B(n6), .Y(n9) );
  INVX1 U18 ( .A(n3), .Y(n6) );
  INVX1 U19 ( .A(n5), .Y(n4) );
  OAI21X1 U20 ( .A(n2), .B(n10), .C(n8), .Y(n5) );
  INVX1 U21 ( .A(N4), .Y(n10) );
  AOI21X1 U22 ( .A(N5), .B(i), .C(N6), .Y(n3) );
  INVX1 U23 ( .A(i), .Y(n2) );
endmodule

