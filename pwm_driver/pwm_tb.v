`timescale 1ns / 10ps
`include "PWM_driver.v"

module pwm_tb;

wire out;
reg clk = 0;
reg rst = 1;


//reg compare = 0;

localparam DURATION = 1000000;

PWM_driver #(.CNTR_LEN(4)) DUT
(
 .clk(clk),
 .rst(rst),
 .compare(4'b1000),
 .PWM_pin(out)   

);


always begin
    #41.667
    clk = ~clk;
end

initial begin
    #100
    rst = 1'b0;
   
end


initial begin
    

    $dumpfile("pwm_driver.vcd");
    $dumpvars(0,pwm_tb);
    #(DURATION)
    $display("Finished");
    $finish;
end


endmodule
