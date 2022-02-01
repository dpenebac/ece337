// $Id: $
// File name:   flex_counter.sv
// Created:     2/1/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: Flex Counter Lab 4

module flex_counter
#(
    parameter NUM_CNT_BITS = 5
)
(
    input logic clk, n_rst, clear, count_enable,
    input logic [NUM_CNT_BITS : 0] rollover_val,
    output logic [NUM_CNT_BITS: 0] count_out,
    output logic rollover_flag
);
    logic [NUM_CNT_BITS:0] next_count;

    always_ff @(posedge clk, clear, negedge n_rst) begin
        if (n_rst == 1'b0)
            count_out <= 0;
        else if (clear == 1'b1)
            count_out <= 0;
        else
            count_out <= next_count;
    end

    always_comb begin
        if (rollover_val == count_out)
            rollover_flag = 1'b1;
        else
            rollover_flag = 1'b0;
    end

    always_comb begin
        if (count_enable == 1'b1)
            next_count = next_count + 1;
        else
            next_count = next_count;
    end


endmodule
