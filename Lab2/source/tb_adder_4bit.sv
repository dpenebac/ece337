// $Id: $
// File name:   tb_adder_4bit.sv
// Created:     1/19/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: TestBench for adder_4bit

`timescale 1ns / 100ps

module tb_adder_4bit
();
	// Declare Design Under Test (DUT) portmap signals
	wire [3:0] tb_a;
	wire [3:0] tb_b;
	wire tb_carry_in;
	wire [3:0] tb_sum;
	wire tb_overflow;
	
	// Declare test bench signals
	integer tb_test_case;
	integer allg;
	reg [8:0] tb_test_inputs;
	reg [4:0] tb_expected_outputs;
	
	// DUT port map
	adder_4bit DUT(.a(tb_a), .b(tb_b), .carry_in(tb_carry_in), .sum(tb_sum), .overflow(tb_overflow));

	// Connect individual test input bits to a vector for easier testing
	//testInputs = {a, b, cin}
	assign tb_a = tb_test_inputs[8:5];
	assign tb_b	= tb_test_inputs[4:1];
	assign tb_carry_in = tb_test_inputs[0];

	initial
	begin
		tb_test_inputs = 0;
		allg = 1;
		
		for(tb_test_case = 0; tb_test_case < 512; tb_test_case = tb_test_case + 1)
		begin
			tb_test_inputs = tb_test_case[8:0];

			#1; //delay

			tb_expected_outputs = tb_a + tb_b + tb_carry_in;
			
			#(10 - 1); //delay

			// Check the DUT's Sum output value
			if(tb_expected_outputs[3:0] == tb_sum)
			begin
				$info("Correct Sum value for test case %d!", tb_test_case);
			end
			else
			begin
				$error("Incorrect Sum value for test case %d!", tb_test_case);
			end
			
			// Check the DUT's Carry Out output value
			if(tb_expected_outputs[4] == tb_overflow)
			begin
				$info("Correct Carry Out value for test case %d!", tb_test_case);
			end
			else
			begin
				$error("Incorrect Carry Out value for test case %d!", tb_test_case);
			end
		end
	end
	
	// Wrap-up process
	final
	begin
		if(512 != tb_test_case)
		begin
			// Didn't run the test bench through all test cases
			$display("This test bench was not run long enough to execute all test cases. Please run this test bench for at least a total of %d ns", (512 * 10));
		end
		else
		begin
			// Test bench was run to completion
			$display("This test bench has run to completion");
		end
	end
endmodule
