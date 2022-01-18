// $Id: $
// File name:   sensor_d.sv
// Created:     1/18/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: Sensor Error Detector Design


module sensor_d(input logic [3:0] sensors, output logic error);
	//F = AC + BC + D
	//ABCD 3210

	assign error = (sensors[3] & sensors[1]) | (sensors[2] & sensors[1]) | sensors[0];
endmodule
