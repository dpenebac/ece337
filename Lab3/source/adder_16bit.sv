// $Id: $
// File name:   adder_16bit.sv
// Created:     1/25/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: Adder_16bit Wrapper File

`timescale 1ns / 100ps

module adder_16bit
(
	input wire [15:0] a,
	input wire [15:0] b,
	input wire carry_in,
	output wire [15:0] sum,
	output wire overflow
);

	// STUDENT: Fill in the correct port map with parameter override syntax for using your n-bit ripple carry adder design to be an 8-bit ripple carry adder design
	adder_nbit #(.BIT_WIDTH(16)) NBIT(.a(a), .b(b), .carry_in(carry_in), .sum(sum), .overflow(overflow));

    always @(a, b, carry_in)
	begin
		#(10);
		assert((a + b + carry_in) == sum)
		else $error("Output for a = %d, b = %d, carry = %d, is incorrect where sum = %d\n Sum should be %d", a, b, carry_in, sum, a + b + carry_in);
	end

endmodule

