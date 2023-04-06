module temp_register (input clk, reset_n, load, increment, decrement, input [7:0] data, output negative, positive, zero);
	reg signed [7:0] temp;
	
	assign negative=temp[7];
	assign positive=(~temp[7] && ~zero);
	assign zero=(temp==8'b0);	
	
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			temp<=8'b0;
		end else if (load) begin
			temp<=data;
		end else if (increment) begin
			temp<=temp+8'b1;
		end else if (decrement) begin
			temp<=temp-8'b1;
		end
	end

endmodule
