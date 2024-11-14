//This module performs three tasks as follows:
 //1)Setting the alarm time  2)Comparing the set alarm time with the current time  3)Turning the alarm on and off
 module alarm (
    input   wire            mclk,  // 1MHz clock
    input   wire            d_clk, // 10Hz clock
   
    // from timer to alarm
    input   wire    [3:0]   ta_hour1,
    input   wire    [3:0]   ta_hour2,
    input   wire    [3:0]   ta_min1,
    input   wire    [3:0]   ta_min2,
    input   wire    [3:0]   ta_sec1,
    input   wire    [3:0]   ta_sec2,
    
    input   wire    [4:0]   i_push1, 
    input   wire            a_state, //  alarm setting mode
    
    // from alarm to 7segment
    output  reg     [3:0]   as_hour1 =0,
    output  reg     [3:0]   as_hour2 =0,
    output  reg     [3:0]   as_min1  =0,
    output  reg     [3:0]   as_min2  =0,
    output  reg     [3:0]   as_sec1  =0,
    output  reg     [3:0]   as_sec2  =0,
    
    output  reg     [2:0]   a_blink  , // cursor blink
    output  reg             al_onoff =0,     // alarm on off
    output  reg             al_wake  =0       // comparing the set alarm time with the current time
 );
 //cursor
    parameter     [2:0]
    HOUR_1  = 3'b001,
    HOUR_2  = 3'b010,
    MIN_1   = 3'b011,
    MIN_2   = 3'b100,
    SEC_1   = 3'b101,
    SEC_2   = 3'b110;
    parameter    [22:0]   FIVE_SEC   = 23'd5000000;

    initial begin
      a_blink = HOUR_1;
    end

    reg [2:0] r_cursor = HOUR_1;
    reg counter = 0;

    task increment; 
        case (r_cursor) 
            HOUR_1 : begin 
                if(as_hour2 < 4) begin 
                    if(as_hour1 < 2) begin
                        as_hour1 <= as_hour1 + 1;
                    end
                    else if(as_hour1 == 2) begin
                        as_hour1 <= 0;
                    end
                end
                else if(as_hour2 >= 4) begin 
                    if(as_hour1 < 1) begin
                        as_hour1 <= as_hour1 + 1;
                    end
                    else if(as_hour1 == 1) begin
                        as_hour1 <= 0;
                    end
                end
            end

            HOUR_2 : begin 
                if(as_hour1 < 2) begin
                    if(as_hour2 < 9) begin
                        as_hour2 <= as_hour2 + 1;
                    end
                    else if(as_hour2 == 9) begin
                        as_hour2 <= 0;
                    end
                end
                else if(as_hour1 == 2) begin 
                    if(as_hour2 < 3) begin
                        as_hour2 <= as_hour2 + 1;
                    end
                    else if(as_hour2 == 3) begin
                        as_hour2 <= 0;
                    end
                end
            end

            MIN_1 : begin 
                if(as_min1 < 5) begin 
                    as_min1 <= as_min1 + 1;
                end
                else if(as_min1 == 5) begin
                    as_min1 <= 0;
                end
            end

            MIN_2 : begin 
                if(as_min2 < 9) begin 
                    as_min2 <= as_min2 + 1;
                end
                else if(as_min2 == 9) begin
                    as_min2 <= 0;
                end
            end

            SEC_1 : begin 
                if(as_sec1 < 5) begin 
                    as_sec1 <= as_sec1 + 1;
                end
                else if(as_sec1 == 5) begin
                    as_sec1 <= 0;
                end
            end

            SEC_2 : begin 
                if(as_sec2 < 9) begin 
                    as_sec2 <= as_sec2 + 1;
                end
                else if(as_sec2 == 9) begin
                    as_sec2 <= 0;
                end
            end

            default : begin
                as_hour1 <= as_hour1;
                as_hour2 <= as_hour2;
                as_min1  <= as_min1;
                as_min2  <= as_min2;
                as_sec1  <= as_sec1;
                as_sec2  <= as_sec2;      
            end
        endcase
    endtask

    task decrement; 
        case (r_cursor) 
            HOUR_1 : begin 
                if(as_hour2 < 4) begin 
                    if(as_hour1 > 0) begin
                        as_hour1 <= as_hour1 - 1;
                    end
                    else if(as_hour1 == 0) begin
                        as_hour1 <= 2;
                    end
                end
                else if(as_hour2 >= 4) begin 
                    if(as_hour1 > 0) begin
                        as_hour1 <= as_hour1 - 1;
                    end
                    else if(as_hour1 == 0) begin
                        as_hour1 <= 1;
                    end
                end
            end

            HOUR_2 : begin
                 if(as_hour1 < 2) begin 
                    if(as_hour2 > 0) begin
                        as_hour2 <= as_hour2 - 1;
                    end
                    else if(as_hour2 == 0) begin
                        as_hour2 <= 9;
                    end
                    end
                else if(as_hour1 == 2) begin 
                    if(as_hour2 > 0) begin
                        as_hour2 <= as_hour2 - 1;
                    end
                    else if(as_hour2 == 0) begin
                        as_hour2 <= 3;
                    end
                end
            end
            MIN_1 : begin 
                if(as_min1 > 0) begin 
                    as_min1 <= as_min1 - 1;
                end
                else if(as_min1 == 0) begin
                    as_min1 <= 5;
                end
            end

            MIN_2 : begin 
                if(as_min2 > 0) begin 
                    as_min2 <= as_min2 - 1;
                end
                else if(as_min2 == 0) begin
                    as_min2 <= 9;
                end
            end

            SEC_1 : begin 
                if(as_sec1 > 0) begin 
                    as_sec1 <= as_sec1 - 1;
                end
                else if(as_sec1 == 0) begin
                    as_sec1 <= 5;
                end
            end

            SEC_2 : begin 
                if(as_sec2 > 0) begin 
                    as_sec2 <= as_sec2 - 1;
                end
                else if(as_sec2 == 0) begin
                    as_sec2 <= 9;
                end
            end
                
            default : begin
                as_hour1 <= as_hour1;
                as_hour2 <= as_hour2;
                as_min1  <= as_min1;
                as_min2  <= as_min2;
                as_sec1  <= as_sec1;
                as_sec2  <= as_sec2;
            end
        endcase
    endtask

    always @(posedge mclk) begin
        if (a_state) begin
            // push button 1
            if(i_push1[1]) begin
                case (a_blink)
                    HOUR_1: begin 
                        a_blink <= HOUR_2; r_cursor <= HOUR_2;
                    end
                    HOUR_2: begin 
                        a_blink <= MIN_1; r_cursor <= MIN_1;
                    end
                    MIN_1 : begin
                        a_blink <= MIN_2; r_cursor <= MIN_2;
                    end
                    MIN_2 : begin
                        a_blink <= SEC_1; r_cursor <= SEC_1;
                    end
                    SEC_1 : begin
                        a_blink <= SEC_2; r_cursor <= SEC_2;
                    end
                    SEC_2 : begin
                        a_blink <= HOUR_1; r_cursor <= HOUR_1;
                    end
                    default : begin
                        a_blink <= HOUR_1; r_cursor <= HOUR_1;
                    end
                endcase
            end
        
        // push button 2
        else if (i_push1[2]) begin 
           increment;
        end
      
        // push button 3
        else if (i_push1[3]) begin 
            decrement;
        end  
    end
     // push button 4
    if (i_push1[4]) begin 
            al_onoff <= ~al_onoff;             
    end 
        
    if(al_onoff) begin
        if((ta_hour1 == as_hour1)&&(ta_hour2==as_hour2)&&(ta_min1==as_min1)&&(ta_min2==as_min2)&&(ta_sec1==as_sec1)&&(ta_sec2==as_sec2)) begin
            al_wake <= 1; 
            if(al_wake) begin
                counter <= counter + 1;
                if (counter > FIVE_SEC) begin
                    al_wake <= 0;
                    counter <= 0;
                end
            end
        end
    end

    else if(!al_onoff) begin
        al_wake <= 0;
    end   
    end
endmodule
