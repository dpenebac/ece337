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

    localparam CLK_PERIOD = 1;

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
        input logic val;
        input string check;
    begin
        if (val == tb_count_out) begin
            $display("Count out is good for: %s", check);
        end
        else begin
            $display("Count out is not good for: %s", check);
        end

        if (val == tb_rollover_flag) begin
            $display("Rollover is good for: %s", check);
        end
        else begin
            $display("Rollover is not good for: %s", check);
        end
    end

    //Generate clock
    always begin
        clk = 1'b0;
        #(CLK_PERIOD/2.0); //wait .5 ns
        clk = 1'b1;
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
        test_case = "Initialization";
        test_num = 0;

        #(0.1);

        //Test 1: Power-on-Reset
        test_case = "Power on Reset";
        test_num = 1;
        
        #(0.1);



        //Test 2

    end


    final begin
        $display("Fin");
    end

endmodule