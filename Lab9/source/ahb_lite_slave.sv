//AHB-Lite-Slave Interface

module ahb_lite_slave
(
    input logic clk,
    input logic n_rst,
    input logic [1:0] coefficient_num,
    input logic modwait,
    input logic [15:0] fir_out,
    input logic err,
    input logic hsel,
    input logic [3:0] haddr,
    input logic hsize,
    input logic [1:0] htrans,
    input logic hwrite,
    input logic [15:0] hwdata,
    output logic [15:0] sample_data,
    output logic data_ready,
    output logic new_coefficient_set,
    output logic [15:0] fir_coefficient,
    output logic [15:0] hrdata,
    output logic hresp
);

    typedef enum logic [1:0] {
        IDLE, READ, WRITE, ERROR
    } state_t;

    state_t state;
    state_t next_state;

    always_ff @(posedge clk, negedge n_rst) begin
        if (n_rst == 1'b0)
            state <= IDLE;
        else
            state <= next_state;
    end

    always_comb begin
        next_state = state;

        if (htrans != 0) begin
            if (hsel & hwrite) begin
                if ((haddr == 4'd0) | (haddr == 4'd1) | (haddr == 4'd2) | (haddr == 4'd3) | (haddr == 4'd15))
                    next_state = ERROR;
                else
                    next_state = WRITE;
            end

            else if (hsel & !hwrite) begin
                if (haddr == 4'd15)
                    next_state = ERROR;
                else
                    next_state = READ;
            end
        end
        else
            next_state = IDLE;
    end

    logic [15:0] status_reg;
    logic [15:0] result_reg;
    logic [15:0] new_sample_reg;
    logic [15:0] f0_reg;
    logic [15:0] f1_reg;
    logic [15:0] f2_reg;
    logic [15:0] f3_reg;
    logic [7:0] new_coeff_reg;

    logic [15:0] next_status_reg;
    logic [15:0] next_result_reg;
    logic [15:0] next_new_sample_reg;
    logic [15:0] next_f0_reg;
    logic [15:0] next_f1_reg;
    logic [15:0] next_f2_reg;
    logic [15:0] next_f3_reg;
    logic [7:0] next_new_coeff_reg;

    logic next_data_ready;
    logic [3:0] prev_haddr;
    logic prev_hsize;

    always_ff @(posedge clk, negedge n_rst) begin
        if (n_rst == 1'b0) begin
            status_reg <= 0;
            result_reg <= 0;
            new_sample_reg <= 0;
            f0_reg <= 0;
            f1_reg <= 0;
            f2_reg <= 0;
            f3_reg <= 0;
            new_coeff_reg <= 0;

            data_ready <= 0;
            prev_haddr <= 0;
            prev_hsize <= 0;
        end
        else begin
            status_reg <= next_status_reg;
            result_reg <= next_result_reg;
            new_sample_reg <= next_new_sample_reg;
            f0_reg <= next_f0_reg;
            f1_reg <= next_f1_reg;
            f2_reg <= next_f2_reg;
            f3_reg <= next_f3_reg;
            new_coeff_reg <= next_new_coeff_reg;

            data_ready <= next_data_ready;
            prev_haddr <= haddr;
            prev_hsize <= hsize;
        end
    end

    always_comb begin
        next_status_reg = status_reg;
        next_result_reg = result_reg;
        next_new_sample_reg = new_sample_reg;
        next_f0_reg = f0_reg;
        next_f1_reg = f1_reg;
        next_f2_reg = f2_reg;
        next_f3_reg = f3_reg;
        next_new_coeff_reg = new_coeff_reg;

        if (err)
            next_status_reg = {8'd1, 8'd0};
        else if (new_coefficient_set | modwait)
            next_status_reg = {8'd0, 8'd1};
        else
            next_status_reg = 16'd0;
        
        next_result_reg = fir_out;

        if (coefficient_num == 3)
            next_new_coeff_reg = 8'b0;

        sample_data = new_sample_reg;
        
        case(coefficient_num)
            0: fir_coefficient = f0_reg;
            1: fir_coefficient = f1_reg;
            2: fir_coefficient = f2_reg;
            3: fir_coefficient = f3_reg;
        endcase

        new_coefficient_set = new_coeff_reg;

        //
        hrdata = 0;

        if (hsel && ((hwrite && ((haddr == 0) | (haddr == 1) | (haddr == 2) | (haddr == 3) | (haddr == 15))) | ((!hwrite) && (haddr == 15))))
            hresp = 1;
        else
            hresp = 0;

        next_data_ready = data_ready;

        //hrdata
        if (state == READ) begin
            if (prev_haddr == 0) begin
                if (prev_hsize == 1)
                    hrdata = status_reg;
                else
                    hrdata = {8'd0, status_reg[7:0]};
            end

            if (prev_haddr == 1) begin
                if (prev_hsize == 1)
                    hrdata = status_reg;
                else
                    hrdata = {status_reg[15:8], 8'd0};
            end

            if (prev_haddr == 2) begin
                if (prev_hsize == 1) 
                    hrdata = result_reg;
                else
                    hrdata = {8'd0, result_reg[7:0]};
            end

            if (prev_haddr == 3) begin
                if (prev_hsize == 1)
                    hrdata = result_reg;
                else
                    hrdata = {result_reg[15:8], 8'd0};
            end
            
            if (prev_haddr == 4) begin
                if (prev_hsize == 1)
                    hrdata = new_sample_reg;
                else
                    hrdata = {8'd0, new_sample_reg[7:0]};
            end

            if (prev_haddr == 5) begin
                if (prev_hsize == 1)
                    hrdata = new_sample_reg;
                else
                    hrdata = {new_sample_reg[15:8], 8'd0};
            end

            if (prev_haddr == 6) begin
                if (prev_hsize == 1)
                    hrdata = f0_reg;
                else
                    hrdata = {8'd0, f0_reg[7:0]};
            end

            if (prev_haddr == 7) begin
                if (prev_hsize == 1)
                    hrdata = f0_reg;
                else
                    hrdata = {f0_reg[15:8], 8'd0};
            end

            if (prev_haddr == 8) begin
                if (prev_hsize == 1)
                    hrdata = f1_reg;
                else
                    hrdata = {8'd0, f1_reg[7:0]};
            end

            if (prev_haddr == 9) begin
                if (prev_hsize == 1)
                    hrdata = f1_reg;
                else
                    hrdata = {f1_reg[15:8], 8'd0};
            end

            if (prev_haddr == 10) begin
                if (prev_hsize == 1)
                    hrdata = f2_reg;
                else
                    hrdata = {8'd0, f2_reg[7:0]};
            end

            if (prev_haddr == 11) begin
                if (prev_hsize == 1)
                    hrdata = f2_reg;
                else
                    hrdata = {f2_reg[15:8], 8'd0};
            end

            if (prev_haddr == 12) begin
                if (prev_hsize == 1)
                    hrdata = f3_reg;
                else
                    hrdata = {8'd0, f3_reg[7:0]};
            end

            if (prev_haddr == 13) begin
                if (prev_hsize == 1)
                    hrdata = f3_reg;
                else
                    hrdata = {f3_reg[15:8], 8'd0};
            end

            if (prev_haddr == 14) begin
                hrdata = {8'd0, new_coeff_reg};
            end

        end

        //hwdata
        if (state == WRITE) begin

            if (prev_hsize == 1) begin
                case (prev_haddr)
                    4: next_new_sample_reg = hwdata;
                    5: next_new_sample_reg = hwdata;
                    6: next_f0_reg = hwdata;
                    7: next_f0_reg = hwdata;
                    8: next_f1_reg = hwdata;
                    9: next_f1_reg = hwdata;
                    10: next_f2_reg = hwdata;
                    11: next_f2_reg = hwdata;
                    12: next_f3_reg = hwdata;
                    13: next_f3_reg = hwdata;
                    14: next_new_coeff_reg = hwdata[7:0];
                endcase
            end

            if (prev_hsize == 0) begin
                case (prev_haddr)
                    4: next_new_sample_reg = {new_sample_reg[15:8], hwdata};
                    5: next_new_sample_reg = {hwdata, new_sample_reg[7:0]};
                    6: next_f0_reg = {f0_reg[15:8], hwdata};
                    7: next_f0_reg = {hwdata, f0_reg[7:0]};
                    8: next_f1_reg = {f1_reg[15:8], hwdata};
                    9: next_f1_reg = {hwdata, f1_reg[7:0]};
                    10: next_f2_reg = {f2_reg[15:8], hwdata};
                    11: next_f2_reg = {hwdata, f2_reg[7:0]};
                    12: next_f3_reg = {f3_reg[15:8], hwdata};
                    13: next_f3_reg = {hwdata, f3_reg[7:0]};
                    14: next_new_coeff_reg = hwdata[7:0];
                endcase
            end

        end

        //data_ready
        if (state == WRITE & prev_haddr == 4 | prev_haddr == 5)
            next_data_ready = 1;
        else if (modwait)
            next_data_ready = 0;
        else
            next_data_ready = data_ready;
    end



endmodule