// $Id: $
// File name:   adder_1bit
// Created:     1/18/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: 1-bit Full Adder

`timescale 1ns / 100ps

module adder_1bit(input logic a, b, carry_in, output logic sum, carry_out);
	assign sum = carry_in ^ (a ^ b);
	assign carry_out = ((~carry_in) & b & a) | (carry_in & (b | a));
	
	always @(a, b, carry_in)
	begin
		#(10) assert((a == 1'b1) || (a == 1'b0))
		else $error("Input a is not a 0 or 1");

		#(10) assert((b == 1'b1) || (b == 1'b0))
		else $error("Input b is not a 0 or 1");

		#(10) assert((carry_in == 1'b1) || (carry_in == 1'b0))
		else $error("Input b is not a 0 or 1");
	end
endmodule
