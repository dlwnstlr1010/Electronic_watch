`timescale 1ns / 1ps
module divider_tb;
    reg mclk;
    wire d_clk;
    wire d_clk2;
    divider dut (
        .mclk(mclk), 
        .d_clk(d_clk),
        .d_clk2(d_clk2)
     );
    // Clock Generation (Assuming 1 MHz)
    always begin
        mclk = 1; #500; // High for 500 ns
        mclk = 0; #500; // Low for 500 ns
    end
    
    // Initial Setup and Tests
    initial begin
        mclk = 0;
        #10000000; 
        $finish;
    end

    always @(posedge mclk) begin
        $display("Time = %t, d_clk = %b, d_clk2 = %b", 
        $time, d_clk, d_clk2);
    end
endmodule
