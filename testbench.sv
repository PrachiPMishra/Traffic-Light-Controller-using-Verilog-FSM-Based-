`timescale 1ns/1ps

module traffic_tb;

reg clk;
reg reset;

wire [2:0] roadA;
wire [2:0] roadB;

traffic_controller DUT(clk, reset, roadA, roadB);

always #5 clk = ~clk;

initial begin
    $dumpfile("traffic.vcd");
    $dumpvars(0,traffic_tb);

    clk = 0;
    reset = 1;

    #20 reset = 0;

    #300 $finish;
end

endmodule
