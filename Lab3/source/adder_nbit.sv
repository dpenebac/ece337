// $Id: $
// File name:   adder_nbit.sv
// Created:     1/22/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: Parameterized Ripple Carry Adder

`timescale 1ns / 100ps

module adder_nbit
#(
    parameter BIT_WIDTH = 4
)
(
    input logic [BIT_WIDTH - 1:0] a, b,
    input logic carry_in,
    output logic [BIT_WIDTH - 1:0] sum,
    output logic overflow
);
    logic [BIT_WIDTH:0] carrys;
	genvar i;
	
	assign carrys[0] = carry_in;

	generate
	for (i = 0; i <= BIT_WIDTH - 1; i = i + 1)
		begin
			adder_1bit IX(.a(a[i]), .b(b[i]), .carry_in(carrys[i]), .sum(sum[i]), .carry_out(carrys[i+1]));
		end
	endgenerate

	assign overflow = carrys[BIT_WIDTH];

	always @(a, b, carry_in)
	begin
		#(10);
		assert((a + b + carry_in) == sum)
		else $error("Output for a = %d, b = %d, carry = %d, is incorrect where sum = %d\n Sum should be %d", a, b, carry_in, sum, a + b + carry_in);
	end

endmodule
