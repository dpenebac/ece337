// $Id: $
// File name:   adder_4bit.sv
// Created:     1/18/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: 4-bit Full Adder Design

module adder_4bit(input logic a, b, carry_in, output logic sum, carry_out);
	//adder_1bit(input logic a, b, carry_in, output logic sum, carry_out);

	//adder_1bit ADDER1(.a(), .b(), .carry_in(), .sum(), .carry_out());
	adder_1bit ADDER1(.a(), .b(), .carry_in(), .sum(), .carry_out());
	adder_1bit ADDER2(.a(), .b(), .carry_in(), .sum(), .carry_out());
	adder_1bit ADDER3(.a(), .b(), .carry_in(), .sum(), .carry_out());
endmodule
