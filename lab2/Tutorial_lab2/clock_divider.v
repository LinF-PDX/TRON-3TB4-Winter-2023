module clock_divider (input Clock, Reset_n, output reg clk_ms);
	parameter factor=100000; //50000; // 32'h000061a7;
	
	reg [31:0] countQ;
	
	always @ (posedge Clock, negedge Reset_n) begin
		if (!Reset_n) begin
			clk_ms <= 32'b0;
		end
		else if (countQ == factor-1) begin
			countQ <= 32'b0;
		end
		else begin
			if (countQ<factor/2) begin
				clk_ms <= 1'b1;
			end
			else begin
				clk_ms <= 1'b0;
			end
			countQ <= countQ + 32'b1;
		end
	end
endmodule 