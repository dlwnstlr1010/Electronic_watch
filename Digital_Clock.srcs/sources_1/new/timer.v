//This module performs three tasks as follows:
 //1)Setting the current time   2) Ongoing of current time   3) Sending the current time to the alarm module
 module timer(
    input wire       mclk,   // 1MHz clock
    input wire       d_clk2, // 1Hz clock
    input wire       d_clk,  // 10Hz clock
    input wire [4:0] i_push2, 
    input wire       c_state, // current time (streaming) mode
    input wire       t_state, // current time setting mode
    input wire       a_state, // alarm setting mode
    // from timer to alarm
    output reg [3:0] ta_hour1=0,
    output reg [3:0] ta_hour2=0, 
    output reg [3:0] ta_min1=0,
    output reg [3:0] ta_min2=0, 
    output reg [3:0] ta_sec1=0,
    output reg [3:0] ta_sec2=0,
    
    // from timer to 7segment
    output reg [3:0] ts_hour1=0,
     output reg [3:0] ts_hour2=0,
    output reg [3:0] ts_min1=0, 
    output reg [3:0] ts_min2=0, 
    output reg [3:0] ts_sec1=0, 
    output reg [3:0] ts_sec2=0, 
    
    output reg [2:0] t_blink
 );
 
    parameter     [2:0]
    HOUR_1  = 3'b001,
    HOUR_2  = 3'b010,
    MIN_1   = 3'b011,
    MIN_2   = 3'b100,
    SEC_1   = 3'b101,
    SEC_2   = 3'b110;
    
    initial begin
       t_blink = HOUR_1;
    end
    reg r_d_clk =0;
    reg [2:0] r_cursor = HOUR_1;

    task increment; 
       case (r_cursor)

                HOUR_1 : begin
                   if(ts_hour2 < 4) begin 
                       if(ts_hour1 < 2) begin
                           ts_hour1 <= ts_hour1 + 1;
                           ta_hour1 <= ta_hour1 + 1;
                       end
                       else if(ts_hour1 == 2) begin
                           ts_hour1 <= 0;
                           ta_hour1 <= 0;
                       end
                   end
                   else if(ts_hour2 >= 4) begin 
                       if(ts_hour1 < 1) begin
                           ts_hour1 <= ts_hour1 + 1;
                           ta_hour1 <= ta_hour1 + 1;
                       end
                    else if(ts_hour1 == 1) begin
                        ts_hour1 <= 0;
                        ta_hour1 <= 0;
                    end
                end
                end

                HOUR_2 : begin
                    if(ts_hour1 < 2) begin 
                        if(ts_hour2 < 9) begin
                            ts_hour2 <= ts_hour2 + 1;
                            ta_hour2 <= ta_hour2 + 1;
                        end
                        else if(ts_hour2 == 9) begin
                            ts_hour2 <= 0;
                            ta_hour2 <= 0;
                        end
                    end
                    else if(ts_hour1 == 2) begin 
                        if(ts_hour2 < 3) begin
                            ts_hour2 <= ts_hour2 + 1;
                            ta_hour2 <= ta_hour2 + 1;
                        end
                        else if(ts_hour2 == 3) begin
                            ts_hour2 <= 0;
                            ta_hour2 <= 0;
                        end
                    end
                end

                MIN_1 : begin
                    if(ts_min1 < 5) begin
                        ts_min1 <= ts_min1 + 1;
                        ta_min1 <= ta_min1 + 1;
                    end
                    else if (ts_min1 == 5) begin
                        ts_min1 <= 0;
                        ta_min1 <= 0;
                    end
                end

                MIN_2 : begin
                    if(ts_min2 < 9) begin
                        ts_min2 <= ts_min2 + 1;
                         ta_min2 <= ta_min2 + 1;
                    end
                    else if(ts_min2 == 9) begin
                        ts_min2 <= 0;
                        ta_min2 <= 0;
                    end
                end

                SEC_1 : begin
                    if(ts_sec1 < 5) begin
                        ts_sec1 <= ts_sec1 + 1;
                        ta_sec1 <= ta_sec1 + 1;
                    end
                    else if(ts_sec1 == 5) begin
                        ts_sec1 <= 0;
                        ta_sec1 <= 0;
                    end
                end

                SEC_2 : begin
                    if(ts_sec2 < 9) begin
                        ts_sec2 <= ts_sec2 + 1;
                        ta_sec2 <= ta_sec2 + 1;
                    end
                    else if(ts_sec2 == 9) begin
                        ts_sec2 <= 0;
                        ta_sec2 <= 0;
                    end
                end

                default : begin
                    ts_hour1 <= ts_hour1;
                    ts_hour2 <= ts_hour2;
                    ts_min1  <= ts_min1;
                    ts_min2  <= ts_min2;
                    ts_sec1  <= ts_sec1;
                    ts_sec2  <= ts_sec2;
                    ta_hour1 <= ta_hour1;
                    ta_hour2 <= ta_hour2;
                    ta_min1  <= ta_min1;
                    ta_min2  <= ta_min2;
                    ta_sec1  <= ta_sec1;
                    ta_sec2  <= ta_sec2;
                end
        endcase
    endtask

    task decrement; 
        case (r_cursor)

                    HOUR_1 : begin
                        if(ts_hour2 < 4) begin 
                            if(ts_hour1 > 0) begin
                                ts_hour1 <= ts_hour1 - 1;
                                ta_hour1 <= ta_hour1 - 1;
                            end
                            else if(ts_hour1 == 0) begin
                                ts_hour1 <= 2;
                                ta_hour1 <= 2;
                            end
                        end
                        else if(ts_hour2 >= 4) begin 
                            if(ts_hour1 > 0) begin
                                ts_hour1 <= ts_hour1 - 1;
                                ta_hour1 <= ta_hour1 - 1;
                            end
                            else if(ts_hour1 == 0) begin
                                ts_hour1 <= 1;
                                ta_hour1 <= 1;
                            end
                        end
                    end

                    HOUR_2 : begin
                        if(ts_hour1 < 2) begin 
                            if(ts_hour2 > 0) begin
                                ts_hour2 <= ts_hour2 - 1;
                                ta_hour2 <= ta_hour2 - 1;
                            end
                            else if(ts_hour2 == 0) begin
                                ts_hour2 <= 9;
                                ta_hour2 <= 9;
                            end
                        end
                        else if(ts_hour1 == 2) begin 
                            if(ts_hour2 > 0) begin
                                ts_hour2 <= ts_hour2 - 1;
                                ta_hour2 <= ta_hour2 - 1;
                            end
                             else if(ts_hour2 == 0) begin
                                ts_hour2 <= 3;
                                ta_hour2 <= 3;
                            end
                        end
                    end

                    MIN_1 : begin
                        if(ts_min1 > 0) begin
                            ts_min1 <= ts_min1 - 1;
                            ta_min1 <= ta_min1 - 1;
                        end
                        else if(ts_min1 == 0) begin
                            ts_min1 <= 5;
                            ta_min1 <= 5;
                        end
                        end
                        MIN_2 : begin
                        if(ts_min2 > 0) begin
                            ts_min2 <= ts_min2 - 1;
                            ta_min2 <= ta_min2 - 1;
                        end
                        else if(ts_min2 == 0) begin
                            ts_min2 <= 9;
                            ta_min2 <= 9;
                        end
                    end

                    SEC_1 : begin
                        if(ts_sec1 > 0) begin
                            ts_sec1 <= ts_sec1 - 1;
                            ta_sec1 <= ta_sec1 - 1;
                        end
                        else if(ts_sec1 == 0) begin
                            ts_sec1 <= 5;
                            ta_sec1 <= 5;
                        end
                    end

                    SEC_2 : begin
                    if(ts_sec2 > 0) begin
                        ts_sec2 <= ts_sec2 - 1;
                        ta_sec2 <= ta_sec2 - 1;
                        end
                    else if(ts_sec2 == 0) begin
                        ts_sec2 <= 9;
                        ta_sec2 <= 9;
                    end
                    end

                    default : begin
                        ts_hour1 <= ts_hour1;
                        ts_hour2 <= ts_hour2;
                        ts_min1  <= ts_min1;
                        ts_min2  <= ts_min2;
                        ts_sec1  <= ts_sec1;
                        ts_sec2  <= ts_sec2;
                        ta_hour1 <= ta_hour1;
                        ta_hour2 <= ta_hour2;
                        ta_min1  <= ta_min1;
                        ta_min2  <= ta_min2;
                        ta_sec1  <= ta_sec1;
                        ta_sec2  <= ta_sec2;
                    end
        endcase
    endtask

    always @(posedge mclk) begin
        // current time 
        if(c_state||a_state) begin 
            r_d_clk <= d_clk2;
                if(d_clk2&&!r_d_clk) begin
                    if (ts_sec1 * 10 + ts_sec2 < 59) begin
                        if( ts_sec2 <= 8) begin
                            ts_sec2 <= ts_sec2 + 1;
                            ta_sec2 <= ta_sec2 + 1;
                        end
                        else if (ts_sec2 == 9) begin 
                            ts_sec1 <= ts_sec1 + 1;
                            ts_sec2 <= 0;
                            ta_sec1 <= ta_sec1 + 1;
                            ta_sec2 <= 0;
                        end
                    end
                    else begin
                        ts_sec1 <= 0;
                        ts_sec2 <= 0;
                        ta_sec1 <= 0;
                        ta_sec2 <= 0;
                        if (ts_min1 * 10 + ts_min2 < 59) begin
                            if( ts_min2 <= 8) begin
                                ts_min2 <= ts_min2 + 1;
                                ta_min2 <= ta_min2 + 1;
                            end
                            else if (ts_min2 == 9) begin 
                                ts_min1 <= ts_min1 + 1;
                                ts_min2 <= 0;
                                ta_min1 <= ta_min1 + 1;
                                ta_min2 <= 0;
                            end
                        end
                    else begin
                        ts_min1 <= 0;
                        ts_min2 <= 0;
                        ta_min1 <= 0;
                        ta_min2 <= 0;
                        if (ts_hour1 * 10 + ts_hour2 < 23) begin
                            if( ts_hour2 <= 8) begin
                                ts_hour2 <= ts_hour2 + 1;
                                ta_hour2 <= ta_hour2 + 1;
                            end
                            else if (ts_hour2 == 9) begin 
                                ts_hour1 <= ts_hour1 + 1;
                                ts_hour2 <= 0;
                                ta_hour1 <= ta_hour1 + 1;
                                ta_hour2 <= 0;
                            end
                        end
                        else begin
                            ts_hour1 <= 0;
                            ts_hour2 <= 0;
                            ta_hour1 <= 0;
                            ta_hour2 <= 0;
                        end
                    end
                    end
                end
        end
    
        else if (t_state) begin 
        // push button 1
        if(i_push2[1]) begin
            case (t_blink)
                HOUR_1: begin
                    t_blink <= HOUR_2; r_cursor <= HOUR_2;
                end
                HOUR_2: begin
                    t_blink <= MIN_1; r_cursor <= MIN_1;
                end
                MIN_1 : begin
                    t_blink <= MIN_2; r_cursor <= MIN_2;
                end
                MIN_2 : begin
                    t_blink <= SEC_1; r_cursor <= SEC_1;
                end
                SEC_1 : begin
                    t_blink <= SEC_2; r_cursor <= SEC_2;
                end
                SEC_2 : begin
                    t_blink <= HOUR_1; r_cursor <= HOUR_1;
                end
                default : begin
                    t_blink <= HOUR_1; r_cursor <= HOUR_1;
                end
            endcase
        end

        // push button 2
        else if (i_push2[2]) begin 
           increment;
        end
      
        // push button 3
        else if (i_push2[3]) begin 
            decrement;
        end

        end

    end
 endmodule