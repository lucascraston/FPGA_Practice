module top(
	input i_clk,
	input i_switch_1,
	input rst_n,
	output pwm
	);
	
	wire rst = ~rst_n;
	wire o_switch_1;
	reg r_switch_1;
	
	debounce_switch filtered_sw1
	(.i_Clk(i_clk),
	.i_Switch(i_switch_1),
	.o_Switch(o_switch_1)
	);



	PWM_driver #(.CNTR_LEN(8))pwm_instance(
		.clk(i_clk),
		.rst(rst),
		.compare(8'b1000000),
		.PWM_pin(pwm)
	);
	
	
	always @(posedge i_clk)
		begin
			r_switch_1 <= o_switch_1;
			if (o_switch_1 == 1'b0 && r_switch_1 == 1'b1)
				begin
					//change the compare value by -1 or +1
				end	
		end	
		
endmodule



