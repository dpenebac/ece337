// $Id: $
// File name:   moore.sv
// Created:     2/14/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: Moore Machine 1101 Detector

module moore
(
    input logic clk,
    input logic n_rst,
    input logic i,
    output logic o
);

    logic next_o;

    typedef enum logic [2:0] {s0, s1, s2, s3, s4} currState;
    currState s;

    always_ff @(posedge clk, negedge n_rst) begin
        if (n_rst == 1'b0) begin
            s <= s0;
            o <= 0;
        end
        else begin
            case(s)

                s0: begin
                    if (i == 0) begin
                        s <= s0;
                        o <= 0;
                    end
                    else if (i == 1) begin
                        s <= s1;
                        o <= 0;
                    end
                end

                s1: begin
                    if (i == 0) begin
                        s <= s0;
                        o <= 0;
                    end
                    else if (i == 1) begin
                        s <= s2;
                        o <= 0;
                    end
                end

                s2: begin
                    if (i == 0) begin
                        s <= s3;
                        o <= 0;
                    end
                    else if (i == 1) begin
                        s <= s2;
                        o <= 0;
                    end
                end

                s3: begin
                    if (i == 0) begin
                        s <= s0;
                        o <= 0;
                    end
                    else if (i == 1) begin
                        s <= s4;
                        o <= 1;
                    end
                end

                s4: begin
                    if (i == 0) begin
                        s <= s0;
                        o <= 0;
                    end
                    else if (i == 1) begin
                        s <= s2;
                        o <= 0;
                    end
                end

                default: begin
                    s <= s0;
                    o <= 0;
                end
            endcase
        end
    end
endmodule