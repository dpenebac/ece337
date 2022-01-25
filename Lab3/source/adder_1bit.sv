// $Id: $
// File name:   adder_1bit
// Created:     1/18/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: 1-bit Full Adder

module adder_1bit(input logic a, b, carry_in, output logic sum, carry_out);
	assign sum = carry_in ^ (a ^ b);
	assign carry_out = ((~carry_in) & b & a) | (carry_in & (b | a));
endmodule
