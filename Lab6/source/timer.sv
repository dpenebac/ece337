// $Id: $
// File name:   timer.sv
// Created:     2/25/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: Timer Block 5.2

`timescale 1ns / 10ps

module timer
(
    input logic clk,
    input logic n_rst,
    input logic enable_timer,
    output logic shift_strobe,
    output logic packet_done
);

    logic clear;
    logic [3:0] clock_count, bit_count;
    assign clear = !enable_timer || packet_done;

    flex_counter #(4) ClockCount(
        .clk(clk), 
        .n_rst(n_rst), 
        .clear(clear),
        .count_enable(enable_timer),
        .count_out(clock_count),
        .rollover_val(4'd10),
        .rollover_flag(shift_strobe)
    );

    flex_counter #(4) BitCount(
        .clk(clk), 
        .n_rst(n_rst), 
        .clear(clear),
        .count_enable(shift_strobe),
        .count_out(bit_count),
        .rollover_val(4'd9),
        .rollover_flag(packet_done)
    );

endmodule