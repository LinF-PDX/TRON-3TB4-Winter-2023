module lab2Test (input clk_in, reset, resume, output reg [13:0] rand,
	output reg rand_ready);
	
	random(clk_in, reset, resume, rand, rand_ready);

endmodule
