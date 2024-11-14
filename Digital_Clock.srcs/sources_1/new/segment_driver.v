//This module displays time information received from the timer and alarm modules on a 7-segment display.
module segment_driver(
    input   wire             mclk,   // 1MHz clock
    input   wire             d_clk2, // 1Hz clock
    input   wire             c_state, // current time (streaming) mode
    input   wire             t_state, // current time setting mode
    input   wire             a_state, // alarm setting mode
    input   wire     [2:0]   t_blink, // time setting mode
    input   wire     [2:0]   a_blink, //alarm setting mode
    
    //from timer to 7segment
    input   wire     [3:0]   ts_hour1,
    input   wire     [3:0]   ts_hour2,
    input   wire     [3:0]   ts_min1,
    input   wire     [3:0]   ts_min2,
    input   wire     [3:0]   ts_sec1,
    input   wire     [3:0]   ts_sec2,
    
    //from alarm to 7segment
    input   wire     [3:0]   as_hour1,
    input   wire     [3:0]   as_hour2,
    input   wire     [3:0]   as_min1,
    input   wire     [3:0]   as_min2,
    input   wire     [3:0]   as_sec1,
    input   wire     [3:0]   as_sec2,
    output  wire      [6:0]   o_seg1, 
    output  wire      [6:0]   o_seg2, 
    output  wire      [6:0]   o_seg3, 
    output  wire      [6:0]   o_seg4, 
    output  wire      [6:0]   o_seg5, 
    output  wire      [6:0]   o_seg6);

    parameter [6:0] seg_0 = 7'b111_1110;
    parameter [6:0] seg_1 = 7'b011_0000;
    parameter [6:0] seg_2 = 7'b110_1101;
    parameter [6:0] seg_3 = 7'b111_1001;
    parameter [6:0] seg_4 = 7'b011_0011;
    parameter [6:0] seg_5 = 7'b101_1011;
    parameter [6:0] seg_6 = 7'b101_1111;
    parameter [6:0] seg_7 = 7'b111_0010;
    parameter [6:0] seg_8 = 7'b111_1111;
    parameter [6:0] seg_9 = 7'b111_1011;

    parameter [2:0]
    HOUR_1  = 3'b001,
    HOUR_2  = 3'b010,
    MIN_1   = 3'b011,
    MIN_2   = 3'b100,
    SEC_1   = 3'b101,
    SEC_2   = 3'b110;

    reg [6:0] r_seg1=0;
    reg [6:0] r_seg2=0;
    reg [6:0] r_seg3=0;
    reg [6:0] r_seg4=0;
    reg [6:0] r_seg5=0;
    reg [6:0] r_seg6=0;

    task segment(output reg [6:0] seg, input [3:0] num);
        case (num)
            4'h0    : seg = seg_0;
            4'h1    : seg = seg_1;
            4'h2    : seg = seg_2;
            4'h3    : seg = seg_3;
            4'h4    : seg = seg_4;
            4'h5    : seg = seg_5;
            4'h6    : seg = seg_6;
            4'h7    : seg = seg_7;
            4'h8    : seg = seg_8;
            4'h9    : seg = seg_9;
            default : seg = 7'h0;
        endcase
    endtask
    
    always @(posedge mclk) begin
        if(c_state) begin 
            segment(r_seg1, ts_hour1);
            segment(r_seg2, ts_hour2);
            segment(r_seg3, ts_min1);
            segment(r_seg4, ts_min2);
            segment(r_seg5, ts_sec1);
            segment(r_seg6, ts_sec2);
        end
        else if (t_state) begin
            segment(r_seg1, ts_hour1);
            segment(r_seg2, ts_hour2);
            segment(r_seg3, ts_min1);
            segment(r_seg4, ts_min2);
            segment(r_seg5, ts_sec1);
            segment(r_seg6, ts_sec2);
            if(!d_clk2 && t_blink == HOUR_1) begin
                r_seg1 <= 0;
            end
            else if(!d_clk2 && t_blink == HOUR_2) begin
                r_seg2 <= 0;
            end
            else if(!d_clk2 && t_blink == MIN_1) begin
                r_seg3 <= 0;
            end
            else if(!d_clk2 && t_blink == MIN_2) begin
                r_seg4 <= 0;
            end
            else if(!d_clk2 && t_blink == SEC_1) begin
                r_seg5 <= 0;
            end
            else if(!d_clk2 && t_blink == SEC_2) begin
                r_seg6 <= 0;
            end
        end
        else if (a_state) begin
            segment(r_seg1, as_hour1);
            segment(r_seg2, as_hour2);
            segment(r_seg3, as_min1);
            segment(r_seg4, as_min2);
            segment(r_seg5, as_sec1);
            segment(r_seg6, as_sec2);
            if(!d_clk2 && a_blink == HOUR_1) begin
                r_seg1 <= 0;
            end
            else if(!d_clk2 && a_blink == HOUR_2) begin
                r_seg2 <= 0;
            end
            else if(!d_clk2 && a_blink == MIN_1) begin
                r_seg3 <= 0;
            end
            else if(!d_clk2 && a_blink == MIN_2) begin
                r_seg4 <= 0;
            end
            else if(!d_clk2 && a_blink == SEC_1) begin
                r_seg5 <= 0;
            end
            else if(!d_clk2 && a_blink == SEC_2) begin
                r_seg6 <= 0;
            end
        end  
    end

    assign o_seg1 = r_seg1;
    assign o_seg2 = r_seg2;
    assign o_seg3 = r_seg3;
    assign o_seg4 = r_seg4;
    assign o_seg5 = r_seg5;
    assign o_seg6 = r_seg6;

endmodule
