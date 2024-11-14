module top (
    input wire mclk,
    input wire [4:0] SW,
    output wire [6:0] O_SEG1,   
    output wire [6:0] O_SEG2,
    output wire [6:0] O_SEG3,
    output wire [6:0] O_SEG4,
    output wire [6:0] O_SEG5,
    output wire [6:0] O_SEG6,
    output wire [7:0] O_LED);

    wire d_clk;   
    wire d_clk2;  
    wire [4:0] i_push1; 
    wire [4:0] i_push2; 
    wire [4:0] i_push3; 
    wire t_state; 
    wire c_state;
    wire a_state;       
    wire al_wake;       
    wire al_onoff;      
    wire [1:0] st_input; 
    wire [3:0] ts_hour1, ts_hour2, ts_min1, ts_min2, ts_sec1, ts_sec2;
    wire [3:0] ta_hour1, ta_hour2, ta_min1, ta_min2, ta_sec1, ta_sec2;
    wire [3:0] as_hour1, as_hour2, as_min1, as_min2, as_sec1, as_sec2;
    wire [2:0] t_blink; 
    wire [2:0] a_blink;

    divider clk_div (
        .mclk(mclk),
        .d_clk(d_clk),
        .d_clk2(d_clk2)
    );
    switch sw (
        .mclk(mclk),
        .sw(SW),
        .d_clk(d_clk),
        .i_push1(i_push1),
        .i_push2(i_push2),
        .i_push3(i_push3)
    );
    timer tmr (
        .mclk(mclk),
        .d_clk(d_clk),
        .d_clk2(d_clk2),
        .i_push2(i_push2),
        .t_state(t_state),
        .a_state(a_state),
        .c_state(c_state),
        .ts_hour1(ts_hour1),
        .ts_hour2(ts_hour2),
        .ts_min1(ts_min1),
        .ts_min2(ts_min2),
        .ts_sec1(ts_sec1),
        .ts_sec2(ts_sec2),
        .ta_hour1(ta_hour1),
        .ta_hour2(ta_hour2),
        .ta_min1(ta_min1),
        .ta_min2(ta_min2),
        .ta_sec1(ta_sec1),
        .ta_sec2(ta_sec2),
        .t_blink(t_blink)
    );
    alarm alm (
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
    state stm (
        .mclk(mclk),
        .reset(sw[4]), 
        .i_push3(i_push3),
        .t_state(t_state),
        .c_state(c_state),
        .a_state(a_state),
        .st_input(st_input)
    );
    segment_driver sgd (
        .mclk(mclk),
        .d_clk2(d_clk2),
        .t_state(t_state),
        .c_state(c_state),
        .a_state(a_state),
        .t_blink(t_blink),
        .a_blink(a_blink),
        .ts_hour1(ts_hour1),
        .ts_hour2(ts_hour2),
        .ts_min1(ts_min1),
        .ts_min2(ts_min2),
        .ts_sec1(ts_sec1),
        .ts_sec2(ts_sec2),
        .as_hour1(as_hour1),
        .as_hour2(as_hour2),
        .as_min1(as_min1),
        .as_min2(as_min2),
        .as_sec1(as_sec1),
        .as_sec2(as_sec2),
        .o_seg1(O_SEG1),
        .o_seg2(O_SEG2),
        .o_seg3(O_SEG3),
        .o_seg4(O_SEG4),
        .o_seg5(O_SEG5),
        .o_seg6(O_SEG6)
    );
    led_driver ldd (
        .mclk(mclk),
        .d_clk2(d_clk2),
        .st_input(st_input),
        .al_onoff(al_onoff),
        .al_wake(al_wake),
        .o_led(O_LED)
    );
 endmodule

