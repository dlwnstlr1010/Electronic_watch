//This module controls the LED's on/off state according to mode changes and the alarm.
module led_driver (
    input    wire         mclk,     //1MHz clock
    input    wire         d_clk2,   //1Hz clock
    input    wire  [1:0]  st_input, //mode changes
    input    wire         al_onoff, 
    input    wire         al_wake,  
    output   reg   [7:0]  o_led = 8'b00000000);

    reg [2:0] count = 3'b000; 
    reg d_clk_z = 0;

    parameter [4:0] 
    LED_BLINK_ON = 5'b11111,
    LED_BLINK_OFF = 5'b00000;

    parameter [1:0]
    DISPLAY_TIME = 2'b11,
    SET_TIME     = 2'b01,
    SET_ALARM    = 2'b10;

    always @(posedge mclk) begin
        if(st_input == DISPLAY_TIME) begin
            o_led[0] <= 0;
            o_led[1] <= 0;
        end
       
        if(st_input == SET_TIME) begin
            o_led[0] <= 1;
            o_led[1] <= 0;
        end

        if(st_input == SET_ALARM) begin
            o_led[0] <= 0;
            o_led[1] <= 1;
        end
        if(al_onoff) begin
            o_led[2] <= 1;
        end
        else if(!al_onoff) begin
            o_led[2] <= 0;
            o_led[7:3] <= LED_BLINK_OFF;
        end
    
        if(al_wake) begin
            d_clk_z <= d_clk2;

            if(d_clk2 && !d_clk_z) begin 

                if(count < 3'd5) begin
                    o_led[7:3] <= LED_BLINK_ON;
                    count <= count + 1;
                end

                else if(count >= 3'd5) begin
                    o_led[7:3] <= LED_BLINK_OFF;
                end
            end

            else if(!d_clk2 && d_clk_z) begin 
                if(count < 3'd5) begin
                    o_led[7:3] <= LED_BLINK_OFF;
                end

                else if(count >= 3'd5) begin
                    o_led[7:3] <= LED_BLINK_OFF;
                end
            end
        end
    
        else if(!al_wake) begin
            o_led[7:3] <= LED_BLINK_OFF;
            count <= 0;
        end
    end
endmodule
