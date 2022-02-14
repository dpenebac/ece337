// $Id: $
// File name:   mealy.sv
// Created:     2/14/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: Mealy Machine 1101 Detector

module mealy
(
    input logic clk,
    input logic n_rst,
    input logic i,
    output logic o
);

    typedef enum logic [2:0] {s0, s1, s2, s3} currState;
    currState s;

    always_ff @(posedge clk, negedge n_rst) begin
        if (n_rst == 1'b0)
            s <= s0;
            o <= 0;
        else begin
            case (s)

                s0: begin
                    if (i == 0) begin
                        o <= 0;
                        s <= s0;
                    end
                    else if (i == 1) begin
                       o <= 0;
                       s <= s1; 
                    end
                end

                s1: begin
                    if (i == 0) begin
                        o <= 0;
                        s <= s0;
                    end
                    else if (i == 1) begin
                       o <= 0;
                       s <= s2; 
                    end
                end

                s2: begin
                    if (i == 0) begin
                        o <= 0;
                        s <= s3;
                    end
                    else if (i == 1) begin
                       o <= 0;
                       s <= s2; 
                    end
                end

                s3: begin
                    if (i == 0) begin
                        o <= 0;
                        s <= s0;
                    end
                    else if (i == 1) begin
                       o <= 1;
                       s <= s1; 
                    end
                end

            endcase
        end

    end


endmodule