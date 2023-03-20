module fir_filter (sample_clock,reset,input_sample,FIR_output_sample);
	parameter N=64; //number of delay blocks in FIR filter; must be odd number	
	input reset;
	input sample_clock;
	input signed [15:0] input_sample;
	output signed [15:0] FIR_output_sample;	
	wire signed [15:0] mul [N:0];
	reg signed [15:0] coeff [N:0];
	reg signed [15:0] z[N:0];	//register to store input signal
	reg signed [15:0] sum_reg;
	reg signed [15:0] out_signal;
	integer i;
	
	assign FIR_output_sample = out_signal;

	always @(*) begin	
		coeff[  0]=        -6;
		coeff[  1]=        -0;
		coeff[  2]=        18;
		coeff[  3]=         0;
		coeff[  4]=       -43;
		coeff[  5]=        -0;
		coeff[  6]=        87;
		coeff[  7]=         0;
		coeff[  8]=      -158;
		coeff[  9]=        -0;
		coeff[ 10]=       261;
		coeff[ 11]=         0;
		coeff[ 12]=      -403;
		coeff[ 13]=        -0;
		coeff[ 14]=       585;
		coeff[ 15]=         0;
		coeff[ 16]=      -807;
		coeff[ 17]=        -0;
		coeff[ 18]=      1061;
		coeff[ 19]=         0;
		coeff[ 20]=     -1338;
		coeff[ 21]=        -0;
		coeff[ 22]=      1620;
		coeff[ 23]=         0;
		coeff[ 24]=     -1890;
		coeff[ 25]=        -0;
		coeff[ 26]=      2127;
		coeff[ 27]=         0;
		coeff[ 28]=     -2313;
		coeff[ 29]=        -0;
		coeff[ 30]=      2431;
		coeff[ 31]=         0;
		coeff[ 32]=     30296;
		coeff[ 33]=         0;
		coeff[ 34]=      2431;
		coeff[ 35]=        -0;
		coeff[ 36]=     -2313;
		coeff[ 37]=         0;
		coeff[ 38]=      2127;
		coeff[ 39]=        -0;
		coeff[ 40]=     -1890;
		coeff[ 41]=         0;
		coeff[ 42]=      1620;
		coeff[ 43]=        -0;
		coeff[ 44]=     -1338;
		coeff[ 45]=         0;
		coeff[ 46]=      1061;
		coeff[ 47]=        -0;
		coeff[ 48]=      -807;
		coeff[ 49]=         0;
		coeff[ 50]=       585;
		coeff[ 51]=        -0;
		coeff[ 52]=      -403;
		coeff[ 53]=         0;
		coeff[ 54]=       261;
		coeff[ 55]=        -0;
		coeff[ 56]=      -158;
		coeff[ 57]=         0;
		coeff[ 58]=        87;
		coeff[ 59]=        -0;
		coeff[ 60]=       -43;
		coeff[ 61]=         0;
		coeff[ 62]=        18;
		coeff[ 63]=        -0;
		coeff[ 64]=        -6;
	end
	
	generate
		genvar x;
		for (x = 0; x < N+1; x = x+1) begin: multiply
			multiplier mux(coeff[x], z[x], mul[x]);
		end
	endgenerate
	
	always@ (posedge sample_clock or posedge reset) begin
		if (reset) begin
			out_signal = 0;
			for (i = 0; i < N+1; i = i+1) begin
				z[i] = 16'b0;
			end
		end
		else begin
			for (i = 1; i < N; i = i+1) begin
				z[N-i] = z[N-i-1];
			end
			z[0] = input_sample;
		end
		sum_reg = 16'b0;
		for (i = 0; i < N+1; i = i+1) begin
			sum_reg = sum_reg + mul[i];
		end
		out_signal = sum_reg;
	end
endmodule

