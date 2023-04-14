module delay_counter (input clk, reset_n, start, enable, input [7:0] delay, output reg done);
	parameter BASIC_PERIOD=20'd500000;   // can change this value to make delay longer
//	parameter BASIC_PERIOD=20'd5;
	reg [7:0] count;
	reg [19:0] sub_count;	
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			count<=8'b0;			
			sub_count <= 20'b0;
			done<=1'b0;
		end else if (start) begin
			count<=delay;	
			sub_count <= 20'b0;		
			done<=1'b0;
		end else if (enable) begin
			//sub counter
			if (count==8'b0) begin
				done<=1'b1;
				count<=8'b0;
				sub_count <= 20'b0;
			end else begin
				done<=1'b0;
				if (sub_count < BASIC_PERIOD-1) begin
					sub_count <= sub_count + 20'b1;
					// count<=count;
				end else if (sub_count == BASIC_PERIOD-1) begin
					count<=count-8'b1;
					sub_count <= 20'b0;
				end else begin //disable latch
					count<=delay;
					sub_count <= 20'b0;
				end
			end
		end else begin
			count<=8'b0;			
			sub_count <= 20'b0;
			done<=1'b0;
		end
	end
endmodule
