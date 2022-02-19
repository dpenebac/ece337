// $Id: $
// File name:   tb_moore.sv
// Created:     2/14/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: TestBench for Moore Machine 1101 Detector

`timescale 100ns / 1ns

module tb_moore();

    localparam CLK_PERIOD        = 2.5;
    localparam PROPAGATION_DELAY = 0.8;

    logic tb_clk;
    logic tb_n_rst;
    logic tb_i;
    logic tb_o;

    logic expected_o;
    string tb_test_case;
    logic tb_mismatch;
    logic [7:0] inputStream, outputStream;
    logic tb_check;

    logic [3:0] peek;

    integer i;

    task reset_dut;
    begin
        tb_n_rst = 1'b0;

        @(posedge tb_clk);
        @(posedge tb_clk);

        @(negedge tb_clk);

        tb_n_rst = 1'b1;

        @(negedge tb_clk);
        @(negedge tb_clk);
    end
    endtask

    // Task to cleanly and consistently check DUT output values
    task check_output;
        input string check_tag;
    begin
        tb_check = 1'b1;
        tb_mismatch = 1'b0;
        if(expected_o == tb_o) begin // Check passed
        $info("Correct output %s during %s test case", check_tag, tb_test_case);
        end
        else begin // Check failed
        tb_mismatch = 1'b1;
        $error("Incorrect output %s during %s test case", check_tag, tb_test_case);
        end

        // Wait some small amount of time so check pulse timing is visible on waves
        #(0.1);
        tb_check = 1'b0;
    end
    endtask

    // Task to contiguosly send a stream of bits through the shift register
    task send_stream;
        input logic [7:0] bit_stream, expected_o_stream;
    begin
        @(negedge tb_clk);
        // Coniguously stream out all of the bits in the provided input vector
        for(i = 7; i >= 0; i--) begin
            // Send the current bit
            tb_i = bit_stream[i];
            @(posedge tb_clk);
            expected_o = expected_o_stream[i];
            #(PROPAGATION_DELAY);
            check_output("While Sending Stream");
        end
    end
    endtask

    // Clock generation block
    always begin
        // Start with clock low to avoid false rising edge events at t=0
        tb_clk = 1'b0;
        // Wait half of the clock period before toggling clock value (maintain 50% duty cycle)
        #(CLK_PERIOD/2.0);
        tb_clk = 1'b1;
        // Wait half of the clock period before toggling clock value via rerunning the block (maintain 50% duty cycle)
        #(CLK_PERIOD/2.0);
    end

    moore DUT (.clk(tb_clk), .n_rst(tb_n_rst), .i(tb_i), .o(tb_o));

    initial begin

        inputStream =  8'b0;
        outputStream = 8'b0;
        tb_check = 0;

        // ************************************************************************
        // Test Case 1: Power-on Reset of the DUT
        // ************************************************************************
        tb_test_case = "Power On Reset";

        #(0.1);

        tb_n_rst = 1'b0;
        expected_o = 1'b0;

        #(CLK_PERIOD * 0.5);

        check_output("After reset");

        #(CLK_PERIOD);
        check_output("After clock cycle while reset");

        @(negedge tb_clk);
        tb_n_rst = 1'b1;

        #(PROPAGATION_DELAY);
        check_output("After reset was released");

        // ************************************************************************
        // Test Case 2: Test Input String
        // ************************************************************************
        tb_test_case = "Test Input String";
        reset_dut();
        inputStream =  8'b11011010;
        outputStream = 8'b00010010;
        send_stream(inputStream, outputStream);

        // ************************************************************************
        // Test Case 3: Test Input String
        // ************************************************************************
        tb_test_case = "Test Input String";
        reset_dut();
        inputStream =  8'b01011100;
        outputStream = 8'b00000000;
        send_stream(inputStream, outputStream);

        // ************************************************************************
        // Test Case 4: Test Input String
        // ************************************************************************
        tb_test_case = "Test Input String";
        reset_dut();
        inputStream =  8'b11011010;
        outputStream = 8'b00010010;
        send_stream(inputStream, outputStream);

        // ************************************************************************
        // Test Case 5: Test Input String
        // ************************************************************************
        tb_test_case = "Test Input String";
        reset_dut();
        inputStream =  8'b01100000;
        outputStream = 8'b00000000;
        send_stream(inputStream, outputStream);

    end


endmodule