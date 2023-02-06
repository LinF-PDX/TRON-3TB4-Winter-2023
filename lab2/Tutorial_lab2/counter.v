module counter (input clk, input reset_n, start_n, stop_n, output reg [19:0] ms_count);

	reg count_state = 1'b0;
	
	always@(posedge clk, negedge reset_n) begin
		if (!reset_n) begin				//KEY[0]
			ms_count <= 1'b0;
		end
		else if (!start_n) begin		//KEY[1]
			count_state <= 1'b1;
		end
		else if (!stop_n) begin			//KEY[2]
			count_state <= 1'b0;
		end
		else if (count_state == 1'b1) begin
			ms_count = ms_count + 1'b1;
		end
	end
endmodule
