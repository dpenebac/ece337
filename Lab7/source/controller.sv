//Controller

module controller (
    input logic clk,
    input logic n_rst,
    input logic dr,
    input logic lc,
    input logic overflow,
    output logic cnt_up,
    output logic clear,
    output logic modwait,
    output logic [2:0] op,
    output logic [3:0] src1,
    output logic [3:0] src2,
    output logic [3:0] dest,
    output logic err
);
    typedef enum logic [4:0] {
        IDLE,
        STRF0, STRF1, STRF2, STRF3,
        MODWAIT1, MODWAIT2, MODWAIT3, MODWAIT4,
        STORE,
        ZERO,
        SORT1, SORT2, SORT3, SORT4,
        MUL1, MUL2, MUL3, MUL4,
        ADD1, ADD2, 
        SUB1, SUB2,
        EIDLE
    } state_t;

    state_t s;
    state_t next_s;

    always_ff @(posedge clk, negedge n_rst) begin
        if (n_rst == 1'b0) begin
            s <= IDLE;
        end
        else begin
            s <= next_s;
        end
    end

    always_comb begin
        next_s = s;
        case(s)
            IDLE: begin
                if (lc)
                    next_s = STRF0;
                else if (dr)
                    next_s = STORE;
                else
                    next_s = IDLE;
            end 

            STRF0: begin
                next_s = MODWAIT1;
            end

            MODWAIT1: begin
                if (lc)
                    next_s = STRF1;
                else 
                    next_s = MODWAIT1;
            end

            STRF1: begin
                next_s = MODWAIT2;
            end

            MODWAIT2: begin
                if (lc)
                    next_s = STRF2;
                else 
                    next_s = MODWAIT2;
            end

            STRF2: begin
                next_s = MODWAIT3;
            end

            MODWAIT3: begin
                if (lc)
                    next_s = STRF3;
                else 
                    next_s = MODWAIT3;
            end

            STRF3: begin
                next_s = MODWAIT4;
            end

            MODWAIT4: begin
                next_s = IDLE;
            end

            //
            STORE: begin
                if (dr)
                    next_s = ZERO;
                else
                    next_s = EIDLE;
            end

            ZERO: begin
                next_s = SORT1;
            end

            SORT1: begin
                next_s = SORT2;
            end

            SORT2: begin
                next_s = SORT3;
            end

            SORT3: begin
                next_s = SORT4;
            end

            SORT4: begin
                next_s = MUL1;
            end

            MUL1: begin
                next_s = ADD1;
            end

            ADD1: begin
                if (overflow)
                    next_s = EIDLE;
                else
                    next_s = MUL2;
            end

            MUL2: begin
                next_s = SUB1;
            end

            SUB1: begin
                if (overflow)
                    next_s = EIDLE;
                else
                    next_s = MUL3;
            end

            MUL3: begin
                next_s = ADD2;
            end

            ADD2: begin
                if (overflow)
                    next_s = EIDLE;
                else
                    next_s = MUL4;
            end

            MUL4: begin
                next_s = SUB2;
            end

            SUB2: begin
                if (overflow)
                    next_s = EIDLE;
                else
                    next_s = IDLE;
            end

            EIDLE: begin
                if (dr)
                    next_s = STORE;
                else
                    next_s = EIDLE;
            end
        endcase
    end

    //registering the output?
    logic next_modwait;
    always_ff @(posedge clk, negedge n_rst) begin
        if (n_rst == 1'b0) begin
            modwait <= 0;
        end
        else begin
            modwait <= next_modwait;
        end
    end

    always_comb begin
        cnt_up = 1'b0;
        clear = 1'b0;
        next_modwait = 1'b0;
        //next_modwait = modwait??
        op = 3'd0;
        src1 = 4'd0;
        src2 = 4'd0;
        dest = 4'd0;
        err = 1'b0;

        case (s)

            //r[6] = F0
            STRF0: begin
                clear = 1;
                next_modwait = 1;
                op = 3'b011;
                dest = 4'd6;
            end

            //r[7] = F1
            STRF1: begin
                clear = 1;
                next_modwait = 1;
                op = 3'b011;
                dest = 4'd7;
            end

            //r[8] = F2
            STRF2: begin
                clear = 1;
                next_modwait = 1;
                op = 3'b011;
                dest = 4'd8;
            end

            //r[9] = F3
            STRF3: begin
                clear = 1;
                next_modwait = 1;
                op = 3'b011;
                dest = 4'd9;
            end

            //r[5] = exti_data1
            STORE: begin
                cnt_up = 1;
                next_modwait = 1;
                op = 3'b010;
                dest = 4'd5;
                cnt_up = 1;
            end

            //r[0] = r[0] - r[0] = 0
            ZERO: begin
                next_modwait = 1;
                op = 3'b101;
                src1 = 4'd0;
                src2 = 4'd0;
                dest = 4'd0;
            end

            //r[1] = r[2]
            SORT1: begin
                next_modwait = 1;
                op = 3'b001;
                src1 = 4'd2;
                dest = 4'd1;
            end

            //r[2] = r[3]
            SORT2: begin
                next_modwait = 1;
                op = 3'b001;
                src1 = 4'd3;
                dest = 4'd2;
            end

            //r[3] = r[4]
            SORT3: begin
                next_modwait = 1;
                op = 3'b001;
                src1 = 4'd4;
                dest = 4'd3;
            end

            //r[4] = r[5]
            SORT4: begin
                next_modwait = 1;
                op = 3'b001;
                src1 = 4'd5;
                dest = 4'd4;
            end

            //r[15] = r[1] * r[9]
            MUL1: begin
                next_modwait = 1;
                op = 3'b110;
                src1 = 4'd1;
                src2 = 4'd9;
                dest = 4'd15;
            end

            //r[0] = r[0] + r[15]
            ADD1: begin
                next_modwait = 1;
                op = 3'b100;
                src1 = 4'd0;
                src2 = 4'd15;
                dest = 4'd0;
            end

            //r[15] = r[2] * r[8]
            MUL2: begin
                next_modwait = 1;
                op = 3'b110;
                src1 = 4'd2;
                src2 = 4'd8;
                dest = 4'd15;
            end

            //r[0] = r[0] - r[15]
            SUB1: begin
                next_modwait = 1;
                op = 3'b101;
                src1 = 4'd0;
                src2 = 4'd15;
                dest = 4'd0;
            end

            //r[15] = r[3] * r[7]
            MUL3: begin
                next_modwait = 1;
                op = 3'b110;
                src1 = 4'd3;
                src2 = 4'd7;
                dest = 4'd15;
            end

            //r[0] = r[0] + r[15]
            ADD2: begin
                next_modwait = 1;
                op = 3'b100;
                src1 = 4'd0;
                src2 = 4'd15;
                dest = 4'd0;
            end

            //r[15] = r[4]] * r[6]
            MUL4: begin
                next_modwait = 1;
                op = 3'b110;
                src1 = 4'd4;
                src2 = 4'd6;
                dest = 4'd15;
            end

            //r[0] = r[0] - r[15]
            SUB2: begin
                next_modwait = 1;
                op = 3'b101;
                src1 = 4'd0;
                src2 = 4'd15;
                dest = 4'd0;
            end

            //err
            EIDLE: begin
                err = 1;
            end

        endcase
    end
endmodule