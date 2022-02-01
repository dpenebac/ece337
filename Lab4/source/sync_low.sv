// $Id: $
// File name:   sync_low.sv
// Created:     2/1/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: Reset to Logic Low Synchronizer

module sync_low(input logic clk, n_rst, async_in, output logic sync_out);
    logic delay;

    always_ff @(posedge clk, negedge n_rst)
    begin
        if (n_rst == 1'b0)
            delay <= 1'b0;
        else
            delay <= async_in;
    end

    always_ff @(posedge clk, negedge n_rst)
    begin
        if (n_rst == 1'b0)
            sync_out <= 1'b0;
        else
            sync_out <= delay;
    end

endmodule
