// $Id: $
// File name:   flex_stp_sr.sv
// Created:     2/14/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: Flexible and Scalable Serial-to-Parallel Shift Register Design Lab6

module flex_stp_sr
#(
    parameter NUM_BITS = 4, 
    parameter SHIFT_MSB = 1 //1 == true == most signifigant bit, 0 == false == lsb
)
(
    input logic clk,
    input logic n_rst,
    input logic shift_enable,
    input logic serial_in,
    output logic [NUM_BITS - 1 : 0] parallel_out
);

    logic [NUM_BITS - 1 : 0] next_out;

    always_ff @(posedge clk, negedge n_rst) begin
        if (n_rst == 1'b0)
            parallel_out <= '1;
        else
            parallel_out <= next_out;
    end

    always_comb begin
        if (shift_enable) begin
            case (SHIFT_MSB)
                0: next_out = {serial_in, parallel_out[(NUM_BITS - 1) : 1]};
                1: next_out = {parallel_out[(NUM_BITS - 2) : 0], serial_in};
            endcase 
        end
        else
            next_out = parallel_out;
    end

endmodule