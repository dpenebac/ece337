// $Id: $
// File name:   flex_pts_sr.sv
// Created:     2/14/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: Flexible and Scalable Parallel-to-Serial Shift Register

module flex_pts_sr
#(
    parameter NUM_BITS = 4,
    parameter SHIFT_MSB = 1 //1 == true == most signifigant bit, 0 == false == lsb
)
(
    input logic clk,
    input logic n_rst,
    input logic [NUM_BITS - 1 : 0] parallel_in,
    input logic shift_enable,
    input logic load_enable,
    output logic serial_out
); //2 erros for lsb

    logic [NUM_BITS - 1 : 0] parallel_out;

    always_ff @(posedge clk, negedge n_rst) begin
        if (n_rst == 1'b0)
            parallel_out <= {NUM_BITS{1'b1}};

        else if (load_enable) begin
            parallel_out <= parallel_in;
        end

        else if (shift_enable) begin
            case (SHIFT_MSB)
                0 : parallel_out <= {1'b1, parallel_out[NUM_BITS - 1 : 1]};
                1 : parallel_out <= {parallel_out[NUM_BITS - 2 : 0], 1'b1};
            endcase
        end

        else
            parallel_out <= parallel_out;
    end

    always_comb begin
        if (SHIFT_MSB)
            serial_out <= parallel_out[NUM_BITS - 1]; 
        else
            serial_out <= parallel_out[0];
    end

endmodule