/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Tue Feb  1 15:05:12 2022
/////////////////////////////////////////////////////////////


module sync_low ( clk, n_rst, async_in, sync_out );
  input clk, n_rst, async_in;
  output sync_out;
  wire   delay;

  DFFSR delay_reg ( .D(async_in), .CLK(clk), .R(n_rst), .S(1'b1), .Q(delay) );
  DFFSR sync_out_reg ( .D(delay), .CLK(clk), .R(n_rst), .S(1'b1), .Q(sync_out)
         );
endmodule

