// $Id: $
// File name:   sensor_s.sv
// Created:     1/18/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: Entry

module sensor_s(input logic [3:0] sensors, output logic error);
	//F = AC + BC + D
	//ABCD 3210
	logic A, B, C, D;
	assign A = sensors[3];
	assign B = sensors[2];
	assign C = sensors[1];
	assign D = sensors[0];
	
	logic AC, BC;
	AND2X1 ANDAC(.A(A), .B(C), .Y(AC));
	AND2X1 ANDBC(.A(B), .B(C), .Y(BC));

	logic tmp;
	OR2X1 ORTMP(.A(AC), .B(BC), .Y(tmp));
	OR2X1 ORF(.A(tmp), .B(D), .Y(error));
endmodule
