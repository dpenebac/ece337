// $Id: $
// File name:   sr_9bit.sv
// Created:     2/26/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: 9-bit Shift Register

`timescale 1ns / 10ps

module sr_9bit
(
  input logic clk,
  input logic n_rst,
  input logic shift_strobe,
  input logic serial_in,
  output logic [7:0] packet_data,
  output logic stop_bit
);

  flex_stp_sr 
  #(
    .NUM_BITS(9), 
    .SHIFT_MSB(0)
  )
  CORE(
  .clk(clk),
  .n_rst(n_rst),
  .serial_in(serial_in),
  .shift_enable(shift_strobe),
  .parallel_out({stop_bit, packet_data})
  );

  //assign stop_bit = (serial_in == 1) ? 1 : 0;


endmodule