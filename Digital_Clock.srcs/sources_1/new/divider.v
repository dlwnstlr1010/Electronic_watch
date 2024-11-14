//A module that divides a 1MHz master clock into 1Hz and 10Hz clocks for application to each module.
module divider (
    input mclk,
    output reg d_clk = 1'b0, // 10Hz
    output reg d_clk2 = 1'b0 // 1Hz
    );
 //A counter introduced to divide a 1MHz master clock into 1Hz and 10Hz
    reg[22:0] cnt_1hz = 23'h0; 
    reg[15:0] cnt_10hz = 16'h0;

    always @(posedge mclk) begin
        // 10Hz Divider
        if (cnt_10hz >= 49999) 
        begin
            cnt_10hz <= 16'h0;
            d_clk <= ~d_clk;
        end 
        else begin
            cnt_10hz <= cnt_10hz + 1;
        end
    //1Hz Divider
        if (cnt_1hz >= 499999) 
        begin
            cnt_1hz <= 23'h0;
            d_clk2 <= ~d_clk2;
        end 
        else begin
            cnt_1hz <= cnt_1hz + 1;
        end
    end
endmodule