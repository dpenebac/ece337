/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Mon Feb  7 12:52:07 2022
/////////////////////////////////////////////////////////////


module flex_counter ( clk, n_rst, clear, count_enable, rollover_val, count_out, 
        rollover_flag );
  input [3:0] rollover_val;
  output [3:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   n82, n10, n35, n36, n37, n38, n58, n59, n60, n61, n62, n64, n65, n66,
         n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77, n78, n79, n80;

  DFFSR \count_out_reg[0]  ( .D(n38), .CLK(clk), .R(n10), .S(1'b1), .Q(n82) );
  DFFSR \count_out_reg[2]  ( .D(n36), .CLK(clk), .R(n10), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \count_out_reg[3]  ( .D(n35), .CLK(clk), .R(n10), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \count_out_reg[1]  ( .D(n37), .CLK(clk), .R(n10), .S(1'b1), .Q(
        count_out[1]) );
  INVX2 U36 ( .A(n_rst), .Y(n58) );
  INVX2 U37 ( .A(count_enable), .Y(n59) );
  INVX2 U38 ( .A(n68), .Y(n60) );
  INVX2 U39 ( .A(n70), .Y(n61) );
  INVX2 U40 ( .A(n75), .Y(n62) );
  INVX2 U41 ( .A(n74), .Y(rollover_flag) );
  INVX2 U42 ( .A(count_out[2]), .Y(n64) );
  INVX2 U43 ( .A(count_out[3]), .Y(n65) );
  INVX2 U44 ( .A(count_out[1]), .Y(n66) );
  OAI21X1 U45 ( .A(count_out[0]), .B(n59), .C(n67), .Y(n38) );
  OAI21X1 U46 ( .A(rollover_flag), .B(n59), .C(count_out[0]), .Y(n67) );
  OAI22X1 U47 ( .A(n62), .B(n66), .C(count_out[1]), .D(n68), .Y(n37) );
  OAI21X1 U48 ( .A(n61), .B(n64), .C(n69), .Y(n36) );
  NAND3X1 U49 ( .A(count_out[1]), .B(n64), .C(n60), .Y(n69) );
  OAI21X1 U50 ( .A(n71), .B(n65), .C(n72), .Y(n35) );
  NAND3X1 U51 ( .A(count_out[2]), .B(n65), .C(n73), .Y(n72) );
  NOR2X1 U52 ( .A(n66), .B(n68), .Y(n73) );
  NAND3X1 U53 ( .A(count_out[0]), .B(n74), .C(count_enable), .Y(n68) );
  AOI21X1 U54 ( .A(n74), .B(n64), .C(n70), .Y(n71) );
  OAI21X1 U55 ( .A(count_out[1]), .B(rollover_flag), .C(n62), .Y(n70) );
  OAI21X1 U56 ( .A(count_out[0]), .B(rollover_flag), .C(count_enable), .Y(n75)
         );
  NAND3X1 U57 ( .A(n76), .B(n77), .C(n78), .Y(n74) );
  NOR2X1 U58 ( .A(n79), .B(n80), .Y(n78) );
  XOR2X1 U59 ( .A(rollover_val[1]), .B(count_out[1]), .Y(n80) );
  XOR2X1 U60 ( .A(rollover_val[0]), .B(n82), .Y(n79) );
  XOR2X1 U61 ( .A(n65), .B(rollover_val[3]), .Y(n77) );
  XOR2X1 U62 ( .A(n64), .B(rollover_val[2]), .Y(n76) );
  NOR2X1 U63 ( .A(clear), .B(n58), .Y(n10) );
  BUFX2 U64 ( .A(n82), .Y(count_out[0]) );
endmodule

