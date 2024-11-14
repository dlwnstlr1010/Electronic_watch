`timescale 100ms / 1ps
module alarm_tb;
    reg mclk;
    reg d_clk;
    reg [3:0] ta_hour1;
    reg [3:0] ta_hour2;
    reg [3:0] ta_min1;
    reg [3:0] ta_min2;
    reg [3:0] ta_sec1;
    reg [3:0] ta_sec2;
    reg [4:0] i_push1;
    reg a_state;
    wire [3:0] as_hour1;
    wire [3:0] as_hour2;
    wire [3:0] as_min1;
    wire [3:0] as_min2;
    wire [3:0] as_sec1;
    wire [3:0] as_sec2;
    wire [2:0] a_blink;
    wire al_onoff;
    wire al_wake;

    alarm alarm_inst (
        .mclk(mclk),
        .d_clk(d_clk),
        .ta_hour1(ta_hour1),
        .ta_hour2(ta_hour2),
        .ta_min1(ta_min1),
        .ta_min2(ta_min2),
        .ta_sec1(ta_sec1),
        .ta_sec2(ta_sec2),
         .i_push1(i_push1),
        .a_state(a_state),
        .as_hour1(as_hour1),
        .as_hour2(as_hour2),
        .as_min1(as_min1),
        .as_min2(as_min2),
        .as_sec1(as_sec1),
        .as_sec2(as_sec2),
        .a_blink(a_blink),
        .al_onoff(al_onoff),
        .al_wake(al_wake)
    );

    always #0.000005 mclk = ~mclk;
    always #0.5 d_clk = ~d_clk;

    initial begin
        mclk = 0;
        d_clk = 0;
        ta_hour1 = 0;
        ta_hour2 = 0;
        ta_min1 = 0;
        ta_min2 = 0;
        ta_sec1 = 0;
        ta_sec2 = 0;
        i_push1 = 0;
        a_state = 0;
       // alarm time set
        #10 a_state = 1;
        #10 i_push1[2] = 1;
        #10 i_push1[2] = 0;
        #10 i_push1[2] = 1;
        #10 i_push1[2] = 0;
        #10 i_push1[1] = 1; //cursor change
        #10 i_push1[1] = 0;
        #10 i_push1[2] = 1;
        #10 i_push1[2] = 0;
        #10 i_push1[2] = 1;
        #10 i_push1[2] = 0;
        #10 i_push1[1] = 1;
        #10 i_push1[1] = 0;
        #10 i_push1[2] = 1;
         #50 i_push1[2] = 0; //5sec
        #10 i_push1[3] = 1;
        #10 i_push1[3] = 0;
        #10 i_push1[3] = 1;
        #10 i_push1[3] = 0;
        // al_on
        #10 i_push1[4] = 1;
        #10 i_push1[4] = 1;
        #10 ta_hour1 = 4'd2;
        ta_hour2 = 4'd3;
        ta_min1 = 0;
        ta_min2 = 0;
        ta_sec1 = 0;
        ta_sec2 = 0;
    end
endmodule
