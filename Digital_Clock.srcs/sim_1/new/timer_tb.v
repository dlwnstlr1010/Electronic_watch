`timescale 100ms / 1ps
module timer_tb;
    reg mclk;
    reg d_clk2;
    reg d_clk;
    reg [4:0] i_push2;
    reg c_state;
    reg t_state;
    reg a_state;
    wire [3:0] ta_hour1;
    wire [3:0] ta_hour2; 
    wire [3:0] ta_min1;
    wire [3:0] ta_min2; 
    wire [3:0] ta_sec1;
    wire [3:0] ta_sec2;
    wire [3:0] ts_hour1; 
    wire [3:0] ts_hour2;
    wire [3:0] ts_min1; 
    wire [3:0] ts_min2; 
    wire [3:0] ts_sec1; 
    wire [3:0] ts_sec2; 
    wire [2:0] t_blink;
   
    timer timer_inst (
        .mclk(mclk),
        .d_clk2(d_clk2),
        .d_clk(d_clk),
        .i_push2(i_push2),
        .c_state(c_state),
        .t_state(t_state),
        .a_state(a_state),
        .ta_hour1(ta_hour1),
        .ta_hour2(ta_hour2),
        .ta_min1(ta_min1),
        .ta_min2(ta_min2),
        .ta_sec1(ta_sec1),
        .ta_sec2(ta_sec2),
        .ts_hour1(ts_hour1),
        .ts_hour2(ts_hour2),
        .ts_min1(ts_min1),
        .ts_min2(ts_min2),
        .ts_sec1(ts_sec1),
        .ts_sec2(ts_sec2),
        .t_blink(t_blink)
    );

    always #0.000005 mclk = ~mclk;
    always #5 d_clk2 = ~d_clk2;
    always #0.5 d_clk = ~d_clk;

    initial begin
        mclk = 0;
        d_clk2 = 0;
        d_clk = 0;
        i_push2 = 0;
        c_state = 0;
        t_state = 0;
        a_state = 0;
        //current time set
        #10 t_state = 1;
        #10 i_push2[1] = 1; //cursor change
        #10 i_push2[1] = 0;
        #10 i_push2[2] = 1;
        #10 i_push2[2] = 0;
        #10 i_push2[2] = 1;
        #10 i_push2[2] = 0;
        #10 i_push2[1] = 1;
        #10 i_push2[1] = 0;
        #10 i_push2[2] = 1;
        #50 i_push2[2] = 0; //5sec
        #10 i_push2[3] = 1;
        #10 i_push2[3] = 0;
        //time flow
        t_state = 0;
        #10 a_state = 1;
        #300 a_state = 0;
        #10 c_state = 1;
    end
endmodule