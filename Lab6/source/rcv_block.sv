// $Id: $
// File name:   rev_block
// Created:     2/15/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: Receiver Block

`timescale 1ns / 10ps

module rcv_block
(
    input logic clk,
    input logic n_rst,
    input logic serial_in,
    input logic data_read,
    output logic [7:0] rx_data,
    output logic data_ready,
    output logic overrun_error,
    output logic framing_error
);

    logic [7:0] packet_data;
    logic stop_bit;
    logic shift_strobe;
    logic enable_timer;
    logic packet_done;
    logic sbc_clear, sbc_enable;
    logic start_bit_detected, new_packet_detected;
    logic load_buffer;

    start_bit_det START_BD (
        .clk(clk),
        .n_rst(n_rst),
        .serial_in(serial_in),
        .start_bit_detected(start_bit_detected),
        .new_packet_detected(new_packet_detected)
    );

    sr_9bit SR9 (
        .clk(clk),
        .n_rst(n_rst),
        .shift_strobe(shift_strobe),
        .serial_in(serial_in),
        .packet_data(packet_data),
        .stop_bit(stop_bit)
    );

    stop_bit_chk STOP_BD (
        .clk(clk),
        .n_rst(n_rst),
        .sbc_clear(sbc_clear),
        .sbc_enable(sbc_enable),
        .stop_bit(stop_bit),
        .framing_error(framing_error)
    );

    timer TIMER (
        .clk(clk),
        .n_rst(n_rst),
        .enable_timer(enable_timer),
        .shift_strobe(shift_strobe),
        .packet_done(packet_done)      
    );

    rcu RCU (
        .clk(clk),
        .n_rst(n_rst),
        .new_packet_detected(new_packet_detected),
        .packet_done(packet_done),
        .framing_error(framing_error),
        .sbc_clear(sbc_clear),
        .sbc_enable(sbc_enable),
        .load_buffer(load_buffer),
        .enable_timer(enable_timer)
    );

    rx_data_buff RX_DATA_BUFFER (
        .clk(clk),
        .n_rst(n_rst),
        .load_buffer(load_buffer),
        .packet_data(packet_data),
        .data_read(data_read),
        .rx_data(rx_data),
        .data_ready(data_ready),
        .overrun_error(overrun_error)
    );


endmodule