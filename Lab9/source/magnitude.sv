//Magnitude

module magnitude (
    input logic [16:0] in,
    output logic [15:0] out
);

    always_comb begin
        if (in[16] == 1'b1)
            out = ~in[15:0] + 1;
        else    
            out = in[15:0];
    end

endmodule