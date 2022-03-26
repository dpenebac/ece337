//Coefficient Loader

module coefficient_loader
(
	input logic clk,
	input logic n_reset,
	input logic new_coefficient_set,
	input logic modwait,
	output logic load_coeff,
	output logic [1:0] coefficient_num
);
    typedef enum logic [4:0] {
        IDLE, LOAD_F0, WAIT1, LOAD_F1, WAIT2, LOAD_F2, WAIT3, LOAD_F3
    } state_t;

    state_t state;
    state_t next_state;

    always_ff @(posedge clk, negedge n_reset) begin
        if (n_reset == 1'b0)
            state <= IDLE;
        else
            state <= next_state;
    end

    always_comb begin
        next_state = state;

        case (state) 
            
            IDLE: begin
                if (modwait == 1'b0 & new_coefficient_set)
                    next_state = LOAD_F0;
                else
                    next_state = IDLE;
            end

            LOAD_F0: next_state = WAIT1;
            
            WAIT1: begin
                if (modwait == 1'b0)
                    next_state = LOAD_F1;
                else
                    next_state = WAIT1;
            end

            LOAD_F1: next_state = WAIT2;
            
            WAIT2: begin
                if (modwait == 1'b0)
                    next_state = LOAD_F2;
                else
                    next_state = WAIT2;
            end

            LOAD_F2: next_state = WAIT3;
            
            WAIT3: begin
                if (modwait == 1'b0)
                    next_state = LOAD_F3;
                else
                    next_state = WAIT3;
            end

            LOAD_F3: next_state = IDLE;
        endcase
    
    end

    always_comb begin
        load_coeff = 1;
        coefficient_num = 0;

        case (state) 
            IDLE : begin
                load_coeff = 0;
                coefficient_num = 0;
            end

            LOAD_F0: begin
                load_coeff = 1;
                coefficient_num = 2'd0;
            end

            WAIT1: begin
                load_coeff = 0;
                coefficient_num = 2'd0;
            end

            LOAD_F1: begin
                load_coeff = 1;
                coefficient_num = 2'd1;
            end

            WAIT2: begin
                load_coeff = 0;
                coefficient_num = 2'd1;
            end

            LOAD_F2: begin
                load_coeff = 1;
                coefficient_num = 2'd2;
            end

            WAIT3: begin
                load_coeff = 0;
                coefficient_num = 2'd2;
            end

            LOAD_F3: begin
                load_coeff = 1;
                coefficient_num = 2'd3;
            end
        endcase
    end



endmodule