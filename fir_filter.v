module fir_filter(clock, reset, input_signal, output_signal);
	input clock;
	input reset;
	input signed [15:0] input_signal;
	output reg signed [15:0] output_signal;
	
	parameter tap = 15;//default value
	
	reg signed[15:0] coeff[14:0];
	// {-1, 6376, -1, -3652, 0, 4174, 2, 28404, 2, 4174, 0, -3652, -1, 6376, -1};
	
	reg signed[15:0] delayed[14:0];
	
	wire signed[31:0] sum [14:0];
	
	reg signed[15:0] final_sum [14:0];
	
	reg signed[15:0] final;
	
	integer a, b, c;
	always@(*) begin
		coeff[0] = -1;
		coeff[1] = 6376;
		coeff[2] = -1;
		coeff[3] = -3652;
		coeff[4] = 0;
		coeff[5] = 4174;
		coeff[6] = 2;
		coeff[7] = 28404;
		coeff[8] = 2;
		coeff[9] = 4174;
		coeff[10] = 0;
		coeff[11] = -3652;
		coeff[12] = -1;
		coeff[13] = 6376;
		coeff[14] = -1;
	end
	
	generate  
	genvar i;
	for (i = 0; i < tap; i = i + 1) begin: mult_result
		multiplier mult_result(coeff[i],delayed[i], sum[i]);
	end
	endgenerate
	
	always @(posedge clock, posedge reset) begin
		if (reset) begin
			output_signal = 0;
		end
		
		else begin
			delayed[0] = input_signal;
			for (a = 1; a < tap;a = a + 1)begin
				delayed[a] = delayed[a-1];
			end
		end
		
		for(b = 0; b < tap; b = b + 1) begin 
			final_sum[b] = sum[b] >>> 15; //2^15 = 32768
		end
		
		for(c = 0; c < tap; c = c + 1) begin
			final = final + final_sum[c];
		end
		
		output_signal = final; 
	end
	
	
	
endmodule 