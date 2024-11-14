//This module changes the mode by pressing push switch 0.
 //The initial state is the current time setting mode, and by repeatedly pressing push switch 0, alarm setting mode -> current time mode -> current time setting mode
module state 
(
    input wire mclk, // 1 MHz clock
    input wire reset, // Asynchronous reset
    input wire [4:0] i_push3, // Switch inputs
    output reg       c_state, // current time (streaming) mode
    output reg       t_state, // current time setting mode
    output reg       a_state, // alarm setting mode
    output reg [1:0] st_input // Output to LED driver, controls 2 of 8 LEDs
 );
    parameter [2:0] 
    STATE_DISPLAY_TIME = 3'd0,
    STATE_SET_TIME = 3'd1,
    STATE_SET_ALARM = 3'd2;
 
    parameter [1:0]
    DISPLAY_TIME = 2'b11,
    SET_TIME     = 2'b01,
    SET_ALARM    = 2'b10;

    reg [2:0] state = STATE_DISPLAY_TIME;

    always @(posedge mclk or posedge reset) begin
        if (reset)
        begin
            state <= STATE_DISPLAY_TIME;
            c_state <= 0;
            t_state <= 0;
            a_state <= 0;
            st_input <= 0; // Only 2 bits to control part of the LEDs 
        end 
        else begin
            case (state)
                STATE_DISPLAY_TIME: begin
                    if (i_push3[0]) state <= STATE_SET_TIME;
                    c_state <= 0;
                    t_state <= 1; 
                    a_state <= 0; 
                    st_input <= SET_TIME;
                end
                STATE_SET_TIME: begin
                    if (i_push3[0]) state <= STATE_SET_ALARM;
                    c_state <= 0;
                    t_state <= 0; 
                    a_state <= 1;
                    st_input <= SET_ALARM; 
                end
                STATE_SET_ALARM: begin
                    if (i_push3[0]) state <= STATE_DISPLAY_TIME; 
                    c_state <= 1;
                    t_state <= 0;
                    a_state <= 0;
                    st_input <= DISPLAY_TIME;
                end
   
                default: begin
                    state <= STATE_DISPLAY_TIME;
                end
            endcase
        end
    end
 endmodule
