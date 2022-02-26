// $Id: $
// File name:   rcu.sv
// Created:     2/25/2022
// Author:      Dorien Penebacker
// Lab Section: 337-09
// Version:     1.0  Initial Design Entry
// Description: Receiver Control Unit

`timescale 1ns / 10ps

module rcu
(
    input logic clk,
    input logic n_rst,
    input logic new_packet_detected,
    input logic packet_done,
    input logic framing_error,
    output logic sbc_clear,
    output logic sbc_enable,
    output logic load_buffer,
    output logic enable_timer
);
    typedef enum logic [2:0] {IDLE, READ, STOP, LOAD, ERROR} state;
    state s;

    logic next_s;

    always_ff @(posedge clk, negedge n_rst) begin
        if (n_rst == 1'b0)
            s <= IDLE;
        else begin
            case (s)
                IDLE: begin
                    if (new_packet_detected)
                        next_s <= READ;
                    else
                        next_s <= s;
                end

                READ: begin
                    if (packet_done)
                        next_s <= STOP;
                    else
                        next_s <= s;
                end

                STOP: begin
                    if (framing_error)
                        next_s <= ERROR;
                    else
                        next_s <= LOAD;
                end

                LOAD: begin
                    next_s <= IDLE;
                end

                ERROR: begin
                    next_s <= IDLE;
                end

                default: next_s <= s;
            endcase
        end
    end

    always_comb begin
        
        case (s)

            IDLE: begin
                sbc_clear = 1'b0;
                sbc_enable = 1'b0;
                load_buffer = 1'b0;
                enable_timer = 1'b0;
            end

            READ: begin
                sbc_clear = 1'b0;
                sbc_enable = 1'b0;
                load_buffer = 1'b0;
                enable_timer = 1'b1;
            end

            STOP: begin
                sbc_clear = 1'b0;
                sbc_enable = 1'b1;
                load_buffer = 1'b0;
                enable_timer = 1'b0;
            end

            LOAD: begin
                sbc_clear = 1'b0;
                sbc_enable = 1'b0;
                load_buffer = 1'b1;
                enable_timer = 1'b0;
            end

            ERROR: begin
                sbc_clear = 1'b1;
                sbc_enable = 1'b0;
                load_buffer = 1'b0;
                enable_timer = 1'b0;
            end

            default: begin
                sbc_clear = 1'b0;
                sbc_enable = 1'b0;
                load_buffer = 1'b0;
                enable_timer = 1'b0;
            end

        endcase
    end

endmodule