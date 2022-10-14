module PWM_driver #(parameter CNTR_LEN = 8)(
	input clk,
	input rst,
	input [CNTR_LEN -1:0] compare,
	output PWM_pin
	);
	
	reg PWM_d,PWM_q;
	reg [CNTR_LEN -1:0] CTR_d, CTR_q;
	
	assign PWM_pin = PWM_q;
	
	
	always @* begin 
		CTR_d = CTR_q + 1;
		if(compare > CTR_q)
			PWM_d = 1'b1; 
		else
			PWM_d = 1'b0;
	end
	
	always @(posedge clk) begin
		if(rst) begin
			CTR_q <= 1'b0;
		end
		else begin
			CTR_q <= CTR_d;
		end	
		PWM_q <= PWM_d;	
	end	
endmodule	

