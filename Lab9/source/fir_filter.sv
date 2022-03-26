//FIR Filter

module fir_filter (
    input logic clk,
    input logic n_reset,
    input logic [15:0] sample_data,
    input logic [15:0] fir_coefficient,
    input logic load_coeff,
    input logic data_ready,
    output logic one_k_samples,
    output logic modwait,
    output logic [15:0] fir_out,
    output logic err
);

    logic sync_lc;
    logic sync_dr;
    logic overflow;
    logic cnt_up;
    logic clear;
    logic [2:0] op;
    logic [3:0] src1;
    logic [3:0] src2;
    logic [3:0] dest;
    logic [16:0] data;


    //sync_low sync_load_coeff (.clk(clk), .n_rst(n_reset), .async_in(load_coeff), .sync_out(sync_lc));

    //sync_low sync_data_ready (.clk(clk), .n_rst(n_reset), .async_in(data_ready), .sync_out(sync_dr));

    controller controller (.clk(clk), 
                           .n_rst(n_reset),
                           .dr(data_ready),
                           .lc(load_coeff),
                           .overflow(overflow),
                           .cnt_up(cnt_up),
                           .clear(clear),
                           .modwait(modwait),
                           .op(op),
                           .src1(src1),
                           .src2(src2),
                           .dest(dest),
                           .err(err)
                           );
    
    datapath datapath (.clk(clk),
                       .n_reset(n_reset),
                       .op(op),
                       .src1(src1),
                       .src2(src2),
                       .dest(dest),
                       .ext_data1(sample_data),
                       .ext_data2(fir_coefficient),
                       .outreg_data(data),
                       .overflow(overflow)
                       );
    
    counter counter (.clk(clk),
                     .n_rst(n_reset),
                     .cnt_up(cnt_up),
                     .clear(clear),
                     .one_k_samples(one_k_samples)
                    );

    magnitude magnitude (.in(data), .out(fir_out));

endmodule