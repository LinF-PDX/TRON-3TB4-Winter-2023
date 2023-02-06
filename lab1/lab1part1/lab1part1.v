module lab1part1 (input clk, reset, enable, output reg [3:0]count); //counter
	always @(posedge clk) begin
		if (enable) begin
			count <= count + 1'b1;
			if (reset) begin
				count <= 4'b0;
			end
			else if (count == 4'b1111) begin
				count <= 4'b0;
			end
		end
	end
endmodule
