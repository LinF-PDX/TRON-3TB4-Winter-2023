module pc (input clk, reset_n, branch, increment, input [7:0] newpc, output reg [7:0] pc);
	parameter RESET_LOCATION = 8'h00;
	always @(posedge clk or negedge reset_n) begin
		if (!reset_n) begin
			pc<=RESET_LOCATION;
		end else if (increment) begin
			pc<=pc+8'b1;
		end else if (branch) begin
			pc<=newpc;
		end
	end			
endmodule