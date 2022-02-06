// $Id: $
// File name:   tb_flex_counter.sv
// Created:     2/1/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: Flex Counter Test Bench

`timescale 10ns/100ps
//10ns/100ps works for somereason
//1ns/10ps doesn't work at all

module tb_flex_counter
();

    localparam NUM_CNT_BITS = 3;

    localparam  CLK_PERIOD    = 1;
    localparam  FF_SETUP_TIME = 0.190;
    localparam  FF_HOLD_TIME  = 0.100;
    localparam  CHECK_DELAY   = (CLK_PERIOD - FF_SETUP_TIME);
    localparam resetLogic = 0;

    integer test_num;
    string test_case;

    logic tb_clk, tb_n_rst, tb_clear, tb_count_enable;
    logic [NUM_CNT_BITS - 1 : 0] tb_rollover_val;
    logic [NUM_CNT_BITS - 1 : 0] tb_count_out;
    logic tb_rollover_flag;

    logic [NUM_CNT_BITS - 1 : 0] expected_out;
    logic expected_flag;
    assign expected_flag = (expected_out == tb_rollover_val) ? 1 : 0;
    logic countError, flagError;

    integer i;

    // ************************************************************************
    // Tasks
    // ************************************************************************

    // ************************************************************************
    // Reset DUT
    // ************************************************************************
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

    // ************************************************************************
    // Normal Operation DUT Output Check Task
    // check output and rollover flag
    // ************************************************************************
    task checkOutput;
        input logic [NUM_CNT_BITS - 1 : 0] expectedOut;
        input logic expectedFlag;
        input string check;
    begin
        if (expectedOut == tb_count_out) begin
            countError = 1'b0;
        end
        else begin
            $display("Count out is not good for: %s\nExpected: %d, got %d", check, expectedOut, tb_count_out);
            countError = 1'b1;
        end

        if (expectedFlag == tb_rollover_flag) begin
            flagError = 1'b0;
        end
        else begin
            $display("Rollover Flag is not good for: %s\nExpected: %d, got %d", check, expectedFlag, tb_rollover_flag);
            flagError = 1'b1;
        end
    end
    endtask

    // ************************************************************************
    // Normal Clear
    // Pulse clear for 1 cycle
    // ************************************************************************
    task normalClear;
    begin
        expected_out = 0;
        tb_clear = 1'b1;
        @(posedge tb_clk);
        @(negedge tb_clk);
        tb_clear = 1'b0;
    end
    endtask

    // ************************************************************************
    // End Tasks
    // ************************************************************************

    //Generate clock
    always begin
        tb_clk = 1'b0;
        #(CLK_PERIOD/2.0); //wait .5 ns
        tb_clk = 1'b1;
        #(CLK_PERIOD/2.0);
    end

    //DUT port map
    //NUM_BITS not working
    flex_counter #(.NUM_CNT_BITS(NUM_CNT_BITS)) DUT (.clk(tb_clk), .n_rst(tb_n_rst), .clear(tb_clear), .count_enable(tb_count_enable),
                          .rollover_val(tb_rollover_val), .count_out(tb_count_out), .rollover_flag(tb_rollover_flag));

    initial begin
        //initialize test inputs
        tb_n_rst = 1'b1;
        tb_count_enable = 1'b0;
        tb_clear = 1'b0;
        expected_out = 0;

        test_case = "Initialization";
        test_num = 0;

        #(0.1);

        // ************************************************************************
        // Test 1: Power-on-Reset
        // Active low reset, out & flag should == 0
        // ************************************************************************
        $display("\nTEST: 1\n");
        test_case = "Power on Reset";
        test_num = 1;

        assign tb_rollover_val = {NUM_CNT_BITS{1'b1}};
        
        #(0.1);

        tb_count_enable = 1'b0;
        tb_n_rst = 1'b0; //turn on reset

        #(CLK_PERIOD * 0.5); //wait

        checkOutput(0, 0, "(Checking after turning on reset)"); //output and flag should be 0

        #(CLK_PERIOD); //wait

        checkOutput(0, 0, "(Checking after 1 clock cycle after turning on reset)");

        @(posedge tb_clk)
        #(2 * FF_HOLD_TIME); //wait

        tb_n_rst = 1'b1; //turn off reset
        #0.1; //wait

        checkOutput(0, 0, "(Checking after reset was turned off)");

        // ************************************************************************
        // Test 2: Rollover for a rollover value
        // Rollover value that is not a power of 2
        // ************************************************************************
        $display("\nTEST: 2\n");
        test_case = "Rollover Value not a power of 2";
        test_num = 2;
        reset_dut();
        normalClear();
        countError = 0;
        flagError = 0;

        assign tb_rollover_val = {NUM_CNT_BITS{1'b1}} - 4; //sets all bits of rollover val == 1 - 1
        
        tb_count_enable = 1'b1;
        for (i = 0; i < (2 ** NUM_CNT_BITS) + 2; i++)
        begin
            @(posedge tb_clk);
            checkOutput(expected_out, expected_flag, "Rollover Value not a power of 2");
            if (tb_rollover_val == tb_count_out)
                expected_out = 1'b1;
            else
                expected_out = expected_out + 1;
        end
        tb_count_enable = 1'b0;

        // ************************************************************************
        // Test 3: Continous Counting
        // ************************************************************************
        $display("\nTEST: 3\n");
        test_case = "Continous Counting";
        test_num = 3;
        reset_dut();
        normalClear();
        expected_out = 0;
        countError = 0;
        flagError = 0;
        assign tb_rollover_val = {NUM_CNT_BITS{1'b1}}; //sets all bits of rollover val == 1

        tb_count_enable = 1'b1;
        for (i = 0; i < (2 ** NUM_CNT_BITS) + 2; i++)
        begin
            @(posedge tb_clk);
            checkOutput(expected_out, expected_flag, "Continuous");
            if (tb_rollover_val == tb_count_out)
                expected_out = 1'b1;
            else
                expected_out = expected_out + 1;
        end
        tb_count_enable = 1'b0;

        // ************************************************************************
        // Test 4: Discountinous Counting
        // ************************************************************************
        $display("\nTEST: 4\n");
        test_case = "Discountinous Counting";
        test_num = 4;
        reset_dut();
        normalClear();
        expected_out = 0;
        countError = 0;
        flagError = 0;
        assign tb_rollover_val = {NUM_CNT_BITS{1'b1}}; //sets all bits of rollover val == 1

        tb_count_enable = 1'b1;
        for (i = 0; i < (2 ** NUM_CNT_BITS) + 2; i++)
        begin
            @(posedge tb_clk);
            checkOutput(expected_out, expected_flag, "Discountinous Counting");
            if (tb_rollover_val == tb_count_out)
                expected_out = 1'b1;
            else
                expected_out = expected_out + 1;
            tb_count_enable = 1'b0;
            @(posedge tb_clk)
            @(posedge tb_clk)
            tb_count_enable = 1'b1;
        end
        tb_count_enable = 1'b0;

        // ************************************************************************
        // Test 5: Clearing While Counting
        // Used to check clear vs count enable priority
        // ************************************************************************
        $display("\nTEST: 5\n");
        test_case = "Clearing While Counting";
        test_num = 5;
        reset_dut();
        normalClear();
        expected_out = 0;
        countError = 0;
        flagError = 0;
        assign tb_rollover_val = {NUM_CNT_BITS{1'b1}}; //sets all bits of rollover val == 1

        tb_count_enable = 1'b1;
        for (i = 0; i < 3; i++)
        begin
            @(posedge tb_clk);
            checkOutput(expected_out, expected_flag, "Clearing While Counting");
            if (tb_rollover_val == tb_count_out)
                expected_out = 1'b1;
            else
                expected_out = expected_out + 1;
            tb_count_enable = 1'b0;
            @(posedge tb_clk)
            normalClear();
            @(posedge tb_clk)
            tb_count_enable = 1'b1;

            @(posedge tb_clk);
            checkOutput(expected_out, expected_flag, "Clearing While Counting");
            if (tb_rollover_val == tb_count_out)
                expected_out = 1'b1;
            else
                expected_out = expected_out + 1;
            tb_count_enable = 1'b0;
            @(posedge tb_clk)
            normalClear();
            @(posedge tb_clk)
            tb_count_enable = 1'b1;
        end
        tb_count_enable = 1'b0;
    end

    final begin
        $display("Fin");
    end

endmodule