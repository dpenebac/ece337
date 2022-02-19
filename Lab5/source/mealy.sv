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

    typedef enum logic [1:0] {s0, s1, s2, s3} currState;
    currState s;

    //always_ff
    //rst
    //s = next_s
    
    //comb
    //if (i == x && s == s1) next_s = s1

    //comb
    //if (next_s == s1 && i == 1) o = 1;

    currState next_s;

    always_ff @(posedge clk, negedge n_rst) begin
        if (n_rst == 1'b0) begin
            s <= s0;
        end
        else begin
            s <= next_s;
        end
    end

    always_comb begin
        case (s)
            s0: begin
                if (i == 0) begin
                    o = 0;
                end
                else if (i == 1) begin
                    o = 0;
                end
            end

            s1: begin
                if (i == 0) begin
                    o = 0;
                end
                else if (i == 1) begin
                    o = 0; 
                end
            end

            s2: begin
                if (i == 0) begin
                    o = 0;
                end
                else if (i == 1) begin
                    o = 0;
                end
            end

            s3: begin
                if (i == 0) begin
                    o = 0;
                end
                else if (i == 1) begin
                    o = 1; 
                end
            end

            default: begin
                o = 0;
            end
        endcase
    end

    always_comb begin
        case (s)
            s0: begin
                if (i == 0) begin
                    next_s = s0;
                end
                else if (i == 1) begin
                    next_s = s1; 
                end
            end

            s1: begin
                if (i == 0) begin
                    next_s = s0;
                end
                else if (i == 1) begin
                    next_s = s2; 
                end
            end

            s2: begin
                if (i == 0) begin
                    next_s = s3;
                end
                else if (i == 1) begin
                    next_s = s2; 
                end
            end

            s3: begin
                if (i == 0) begin
                    next_s = s0;
                end
                else if (i == 1) begin
                    next_s = s1; 
                end
            end

            default: begin
                next_s = s0;
            end
        endcase
    end


endmodule