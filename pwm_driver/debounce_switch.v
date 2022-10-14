module debounce_switch
	(input i_Clk,
	input i_Switch,
	output o_Switch);

	parameter c_DEBOUNCE_LIMIT = 250000; //param are constants

	reg r_State = 1'b0;
	reg [17:0] r_count = 0; 
	
	always @(posedge i_Clk) 
		begin
			if(i_Switch !== r_State && r_count < c_DEBOUNCE_LIMIT)
				 r_count <= r_count +1; //counter
			else if (r_count == c_DEBOUNCE_LIMIT)
				begin
					r_count <=0;
					r_State <= i_Switch;
				end	
			else
				r_count <=0;
		end
	assign o_Switch = r_State;
endmodule	
		
	