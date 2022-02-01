/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Tue Feb  1 14:56:34 2022
/////////////////////////////////////////////////////////////


module sync_high ( clk, n_rst, async_in, sync_out );
  input clk, n_rst, async_in;
  output sync_out;
  wire   delay;

  DFFSR delay_reg ( .D(async_in), .CLK(clk), .R(1'b1), .S(n_rst), .Q(delay) );
  DFFSR sync_out_reg ( .D(delay), .CLK(clk), .R(1'b1), .S(n_rst), .Q(sync_out)
         );
endmodule

