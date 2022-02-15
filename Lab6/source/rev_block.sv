// $Id: $
// File name:   rev_block
// Created:     2/15/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: Receiver Block

module rev_block
(
    input logic clk,
    input logic n_rst,
    input logic serial_in,
    input logic data_read,
    output logic [7:0] rx_data,
    output logic data_read,
    output logic overrun_error,
    output logic framing_error
);




endmodule