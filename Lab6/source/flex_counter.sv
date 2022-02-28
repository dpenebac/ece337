// $Id: $
// File name:   flex_counter.sv
// Created:     2/1/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: Flex Counter Lab 4

`timescale 10ns/100ps

module flex_counter
#(
    parameter NUM_CNT_BITS = 4
)
(
    input logic clk, n_rst, clear, count_enable,
    input logic [NUM_CNT_BITS - 1:0] rollover_val,
    output logic [NUM_CNT_BITS - 1:0] count_out,
    output logic rollover_flag
);

    logic [NUM_CNT_BITS - 1 : 0] next_count;
    logic next_flag;

    always_ff @(posedge clk, negedge n_rst) begin
        if (n_rst == 1'b0)
            count_out <= 0;
        else
            count_out <= next_count;
    end

    always_ff @(posedge clk, negedge n_rst) begin
        if (n_rst == 1'b0)
            rollover_flag <= 0;
        else
            rollover_flag <= next_flag;
    end

    always_comb begin
        next_count = count_out;
        next_flag = rollover_flag;

        if (clear) begin
            next_flag = 1'b0;
            next_count = 1'b0;
        end

        if (count_enable && (count_out == (rollover_val - 1))) begin
            next_flag = 1'b1;
            next_count = count_out + 1;
        end

        else if (count_enable && (count_out >= rollover_val)) begin
            next_count = 1;
            next_flag = 1'b0;
        end

        else if (count_enable) begin
            next_count = count_out + 1;
            next_flag = 1'b0;
        end
    end

endmodule