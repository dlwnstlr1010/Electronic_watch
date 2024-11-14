`timescale 1ns / 1ps
module state_tb;
    // Inputs
    reg mclk;
    reg reset;
    reg [4:0] i_push3;
    // Outputs
    wire c_state;
    wire t_state;
    wire a_state;
    wire [1:0] st_input;
    state dut (
        .mclk(mclk), 
        .reset(reset), 
        .i_push3(i_push3), 
        .c_state(c_state), 
        .t_state(t_state), 
        .a_state(a_state), 
        .st_input(st_input)
    );
    initial begin
        // Initialize Inputs
        mclk = 0;
        reset = 1;
        i_push3 = 5'b00000;
        // Reset the system
        #10;
        reset = 0;
        // Wait 100 ns for global reset
        #100;
        // Press switch 0 four times to cycle through the modes
        repeat (4) begin
            #1000000000 i_push3[0] = 1'b1; // Press switch 0
            #1000000000 i_push3[0] = 1'b0; // Release switch 0
            #1000000000; // Wait some time to observe the mode change
        end
    end
    // Clock generation
    always #500 mclk = ~mclk; 
endmodule
