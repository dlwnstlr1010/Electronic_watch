`timescale 100ms / 1ps
module segment_driver_tb;
    reg mclk, d_clk2, c_state, t_state, a_state;
    reg [2:0] t_blink, a_blink;
    reg [3:0] ts_hour1, ts_hour2, ts_min1, ts_min2, ts_sec1, ts_sec2;
    reg [3:0] as_hour1, as_hour2, as_min1, as_min2, as_sec1, as_sec2;
    
    wire [6:0] o_seg1, o_seg2, o_seg3, o_seg4, o_seg5, o_seg6;
    
    parameter     [2:0]
    HOUR_1  = 3'b001,
    HOUR_2  = 3'b010,
    MIN_1   = 3'b011,
    MIN_2   = 3'b100,
    SEC_1   = 3'b101,
    SEC_2   = 3'b110;
    
    segment_driver dut (
        .mclk(mclk),
        .d_clk2(d_clk2),
        .c_state(c_state),
        .t_state(t_state),
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
        .o_seg1(o_seg1),
        .o_seg2(o_seg2),
        .o_seg3(o_seg3),
        .o_seg4(o_seg4),
        .o_seg5(o_seg5),
        .o_seg6(o_seg6)
    );
    
   
    always #0.000005 mclk = ~mclk;
    always #5 d_clk2 = ~d_clk2;
    
    initial begin
        mclk = 0;
        d_clk2 = 0;
        c_state = 0;
        t_state = 1;
        a_state = 0;
        t_blink = HOUR_1;
        a_blink = HOUR_1;
        ts_hour1 = 0;
        ts_hour2 = 0;
        ts_min1 = 0;
        ts_min2 = 0;
        ts_sec1 = 0;
        ts_sec2 = 0;
        as_hour1 = 0;
        as_hour2 = 0;
        as_min1 = 0;
        as_min2 = 0;
        as_sec1 = 0;
        as_sec2 = 0;
        //To check if the time 12:34:56 displays properly in seven-segment format.
        #10 ts_hour1 = 4'h1;
        #5 t_blink = HOUR_2;
           ts_hour2 = 4'h2;
        #5 t_blink = MIN_1;
           ts_min1 = 4'h3;
        #5 t_blink = MIN_2;
           ts_min2 = 4'h4;
        #5 t_blink = SEC_1;
           ts_sec1 = 4'h5;
        #5 t_blink = SEC_2;
           ts_sec2 = 4'h6;
        #10 t_state = 0;
        #10 a_state = 1;
        #10 a_state = 0;
        #10 c_state = 1;
    end 
endmodule
