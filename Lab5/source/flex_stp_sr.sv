// $Id: $
// File name:   flex_stp_sr.sv
// Created:     2/14/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: Flexible and Scalable Serial-to-Parallel Shift Register Design

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

    localparam bits = NUM_BITS - 1;

    always_ff @(posedge clk, negedge n_rst) begin
        if (n_rst == 1'b0)
            parallel_out <= {(NUM_BITS - 1){1'b1}};
        else if (shift_enable)
            case (SHIFT_MSB)
                0 : parallel_out <= {parallel_out[NUM_BITS - 2 : 0], serial_in};
                1 : parallel_out <= {serial_in, parallel_out[NUM_BITS - 2 : 0]};
            endcase
        else
            parallel_out <= parallel_out;
    end

endmodule
