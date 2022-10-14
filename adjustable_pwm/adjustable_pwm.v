module adjustable_pwm #(parameter CNTR_LEN = 8)(
	input clk,
	input rst,
	input i_cycle_up,
	input i_cycle_down,
	output PWM_pin
	);
	
	reg PWM_d,PWM_q;
	reg [CNTR_LEN -1:0] CTR_d, CTR_q;
	reg [CNTR_LEN -1:0] compare =8;

	reg r_cycle_up;
	wire o_cycle_up;
	
	reg r_cycle_down;
	wire o_cycle_down;
	
	assign PWM_pin = PWM_q;


	debounce_switch #(.c_DEBOUNCE_LIMIT(100)) fltr_cycle_up
	(
		.i_Clk(clk),
		.i_Switch(i_cycle_up),
		.o_Switch(o_cycle_up)

	);

	debounce_switch #(.c_DEBOUNCE_LIMIT(100)) fltr_cycle_down
	(
		.i_Clk(clk),
		.i_Switch(i_cycle_down),
		.o_Switch(o_cycle_down)

	);
	
	
	
	always @* begin 
		CTR_d = CTR_q + 1;
		if(compare > CTR_q)
			PWM_d = 1'b1; 
		else
			PWM_d = 1'b0;
	end
	
	always @(posedge clk) begin
		
		r_cycle_up <= o_cycle_up;
		r_cycle_down <= o_cycle_down;
		if(o_cycle_up == 1'b0 && r_cycle_up == 1'b1) begin
			compare <= compare +1;
		end
		if(o_cycle_down == 1'b0 && r_cycle_down == 1'b1) begin
			compare <= compare -1;
		end

		if(rst) begin
			CTR_q <= 1'b0;
		end
		else begin
			CTR_q <= CTR_d;
		end	
		PWM_q <= PWM_d;	
	end	
	



endmodule	

