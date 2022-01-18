// $Id: $
// File name:   sensor_b.sv
// Created:     1/18/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: Behavioral Style Sensor Error

module sensor_b(input logic [3:0] sensors, output logic error);
	//F = AC + BC + D
	//ABCD 3210

	always_comb begin
		error = (sensors[3] & sensors[1]) | (sensors[2] & sensors[1]) | sensors[0];
	end
endmodule
