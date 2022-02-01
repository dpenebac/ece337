// $Id: $
// File name:   tb_flex_counter.sv
// Created:     2/1/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: Flex Counter Test Bench

`timescale 1ns/10ps

module tb_flex_counter
();

    localparam NUM_CNT_BITS = 5;

    localparam  CLK_PERIOD    = 1;
    localparam  FF_SETUP_TIME = 0.190;
    localparam  FF_HOLD_TIME  = 0.100;

    integer test_num;
    string test_case;

    logic tb_clk, tb_n_rst, tb_clear, tb_count_enable;
    logic [NUM_CNT_BITS:0] tb_rollover_val, tb_count_out;
    logic tb_rollover_flag;

    //TASKS
    //Reset DUT
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

    //Normal Operation Check
    task checkOutput;
        input logic out, flag;
        input string check;
    begin
        if (out == tb_count_out) begin
            $display("Count out is good for: %s", check);
        end
        else begin
            $display("Count out is not good for: %s", check);
        end

        if (flag == tb_rollover_flag) begin
            $display("Rollover Flag is good for: %s", check);
        end
        else begin
            $display("Rollover Flag is not good for: %s", check);
        end
    end
    endtask

    //Generate clock
    always begin
        tb_clk = 1'b0;
        #(CLK_PERIOD/2.0); //wait .5 ns
        tb_clk = 1'b1;
        #(CLK_PERIOD/2.0);
    end

    //DUT port map
    flex_counter #(NUM_CNT_BITS) DUT(.clk(tb_clk), .n_rst(tb_n_rst), .clear(tb_clear), 
                .count_enable(tb_count_enable), .rollover_val(tb_rollover_val),
                .count_out(tb_count_out), .rollover_flag(tb_rollover_flag));


    initial begin
        //initialize test inputs
        tb_n_rst = 1'b1;
        tb_count_enable = 1'b0;
        tb_clear = 1'b0;

        test_case = "Initialization";
        test_num = 0;

        #(0.1);

        //Test 1: Power-on-Reset
        test_case = "Power on Reset";
        test_num = 1;
        
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

        //Test 2
        test_case = "Continous Counting";
        test_num = 2;

    end


    final begin
        $display("Fin");
    end

endmodule