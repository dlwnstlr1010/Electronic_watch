//This module converts the inputs of push switches 0, 1, 2, 3, 4 into digital signals and transmits them to each module.
module switch (
    input mclk,
    input d_clk,
    input [4:0] sw,
    //The signal i_push1 is sent to the alarm module, i_push2 to the timer module, and i_push3 to the state machine.
    output reg [4:0] i_push1 = 5'b00000,
    output reg [4:0] i_push2 = 5'b00000,
    output reg [4:0] i_push3 = 5'b00000
 );
    reg [4:0] prev_sw = 5'b00000;
    reg [21:0] counter2 = 0, counter3 = 0;
    reg r_d_clk1 =0;
    reg r_d_clk2 = 0;
    
    always @(posedge mclk) begin
        //i_push3 is a signal that is transmitted to the state machine module.
        //Therefore, it is only necessary to implement a function that detects a momentary rising edge.
        i_push3 <= (sw & ~prev_sw);
        // sw[0] - mode translate
        if (sw[0] && !prev_sw[0]) 
        begin
            i_push1[0] <= 1;
            i_push2[0] <= 1;
        end 
        else begin
            i_push1[0] <= 0;
            i_push2[0] <= 0;
        end


        // sw[1] - cursor
        if (sw[1] && !prev_sw[1]) 
        begin
            i_push1[1] <= 1;
            i_push2[1] <= 1;
        end 
        else begin
            i_push1[1] <= 0;
            i_push2[1] <= 0;
        end


        // sw[4] - alarm ON/OFF
        if (sw[4] && !prev_sw[4]) 
        begin
            i_push1[4] <= 1;
            i_push2[4] <= 1;
        end 
        else begin
            i_push1[4] <= 0;
            i_push2[4] <= 0;
        end

        //The signals sw[2] and sw[3] must be implemented not only for situations where they are pressed once, 
        //but also for moments when they are held down for a long time.
        // sw[2] - increment
        if (sw[2] && !prev_sw[2]) 
        begin
            i_push1[2] <= 1;
            i_push2[2] <= 1;
            counter2 <= 0;
        end 
         else if (!sw[2] && prev_sw[2]) 
        begin
            counter2 <= 0;
        end 
        else if (sw[2]&& prev_sw[2]) 
        begin
            if (counter2 < 2000000) 
            begin
                counter2 <= counter2 + 1;
                i_push1[2] <= 0;
                i_push2[2] <= 0;
            end 
            else if (counter2 == 2000000) begin
                r_d_clk1 <= d_clk;
                
                if(d_clk&&!r_d_clk1) begin
                  i_push1[2] <= 1;
                  i_push2[2] <= 1;
                end
                else begin
                  i_push1[2] <= 0;
                  i_push2[2] <= 0;  
                end               
            end
        end
        else begin
            i_push1[2] <= 0;
            i_push2[2] <= 0;
        end


        // sw[3] - decrement
         if (sw[3] && !prev_sw[3]) 
        begin
            i_push1[3] <= 1;
            i_push2[3] <= 1;
            counter3 <= 0;
        end 
        else if (!sw[3] && prev_sw[3]) 
        begin
            counter3 <= 0;
        end
         else if (sw[3]&& prev_sw[3]) 
        begin
            if (counter3 < 2000000) 
            begin
                counter3 <= counter3 + 1;
                i_push1[3] <= 0;
                i_push2[3] <= 0;
            end 
            else if (counter3 == 2000000) begin
                r_d_clk2 <= d_clk;
                
                if(d_clk&&!r_d_clk2) begin
                  i_push1[3] <= 1;
                  i_push2[3] <= 1;
                end
                else begin
                  i_push1[3] <= 0;
                  i_push2[3] <= 0;  
                end               
            end
        end
        else begin
            i_push1[3] <= 0;
            i_push2[3] <= 0;
        end
        prev_sw <= sw;
    end
endmodule
