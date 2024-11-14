`timescale 1ns / 1ps
module switch_tb;
    // Inputs
    reg mclk;
    reg d_clk;
    reg [4:0] sw;
    // Outputs
    wire [4:0] i_push1;
    wire [4:0] i_push2;
    wire [4:0] i_push3;
    switch dut (
        .mclk(mclk), 
        .d_clk(d_clk),
        .sw(sw), 
        .i_push1(i_push1), 
        .i_push2(i_push2), 
        .i_push3(i_push3)
    );

    initial begin
        // Initialize Inputs
        mclk = 0;
        d_clk = 0;
        sw = 5'b00000;
        // Test switch 0
        sw[0] = 1'b1;
        #1000000000 // wait for 10 clock cycles
        sw[0] = 1'b0;
        // Test switch 1
        sw[1] = 1'b1;
        #1000000000 // wait for 10 clock cycles
        sw[1] = 1'b0;
        // Test switch 2 (hold for 4 seconds)
        sw[2] = 1'b1;
        #4000000000 // wait for 4 seconds (assuming 1 MHz clock)
        sw[2] = 1'b0;
        // Test switch 3 (hold for 4 seconds)
        sw[3] = 1'b1;
        #4000000000 // wait for 4 seconds
        sw[3] = 1'b0;
        // Test switch 4
        sw[4] = 1'b1;
        #1000000000 // wait for 10 clock cycles
        sw[4] = 1'b0;
    end

    // Clock generation
    always #500 mclk = ~mclk; // Toggle clock every 1 ns
    always #50000000 d_clk = ~d_clk;
endmodule