`timescale 100ms / 1ps
module led_driver_tb;
    reg mclk;
    reg d_clk2;
    reg [1:0]st_input;
    reg al_onoff;
    reg al_wake;
    
    wire [7:0] o_led;
    
    led_driver dut (
        .mclk(mclk),
        .d_clk2(d_clk2),
        .st_input(st_input),
        .al_onoff(al_onoff),
        .al_wake(al_wake),
        .o_led(o_led)
    );

    always #0.00005 mclk = ~mclk;
    always #5 d_clk2 = ~d_clk2;
    
    initial begin
        mclk = 0;
        d_clk2 = 0;
        st_input = 2'b11;
        al_onoff = 0;
        al_wake = 0;
        
        // led 1
        #10 st_input = 2'b01; 
        #10;
        
        // led 2
        st_input = 2'b10; 
        #10;
        // led 3
        al_onoff = 1; 
        #10;
        
        // led 4~8
        al_wake = 1; 
    end
endmodule
