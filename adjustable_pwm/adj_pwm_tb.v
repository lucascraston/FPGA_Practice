`timescale 1ns / 10ps
`include "adjustable_pwm.v"
`include "debounce_switch.v"

module adj_pwm_tb;

wire out;
reg clk = 0;
reg rst = 1;
reg cycle_up = 0;
reg cycle_down = 0;


//reg compare = 0;

localparam DURATION = 1000000;

adjustable_pwm #(.CNTR_LEN(4)) DUT
(
 .clk(clk),
 .rst(rst),
 .i_cycle_up(cycle_up),
 .i_cycle_down(cycle_down),
 .PWM_pin(out)   
);


always begin
    #41.667
    clk = ~clk;
end

always begin
    #10000
    cycle_down = ~cycle_down;
end


initial begin
    #100
    rst = 1'b0;
   
end


initial begin
    

    $dumpfile("adj_pwm_driver.vcd");
    $dumpvars(0,adj_pwm_tb);
    #(DURATION)
    $display("Finished");
    $finish;
end


endmodule
