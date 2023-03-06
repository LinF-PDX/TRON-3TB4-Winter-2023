module fir_filter (sample_clock,reset,input_sample,FIR_output_sample);
	parameter tap_num=64; //number of delay blocks in FIR filter; must be odd number	
	input reset;
	input sample_clock;
	input signed [15:0] input_sample;
	output signed [15:0] FIR_output_sample;	
	reg signed [15:0] coeff [(tap_num-1)/2:0];	
//	
//	wire signed [15:0] FIR_input_history [tap_num-1:0];	// FIR_input_history[k] means x(n-k)
//	wire signed [15:0] adder_wire [(tap_num-3)/2:0];
//	wire signed [15:0] tap_wire [(tap_num-3)/2:0];
//	wire signed [15:0] main_adder_wire [(tap_num-1)/2:0]; // including the middle coeff wire
//	wire signed [15:0] main_wire [(tap_num-1)/2:0]; // including the middle coeff wire	
//	
//	always @(*) begin	
//		coeff[  0]=        -6;
//		coeff[  1]=        -0;
//		coeff[  2]=        18;
//		coeff[  3]=         0;
//		coeff[  4]=       -43;
//		coeff[  5]=        -0;
//		coeff[  6]=        87;
//		coeff[  7]=         0;
//		coeff[  8]=      -158;
//		coeff[  9]=        -0;
//		coeff[ 10]=       261;
//		coeff[ 11]=         0;
//		coeff[ 12]=      -403;
//		coeff[ 13]=        -0;
//		coeff[ 14]=       585;
//		coeff[ 15]=         0;
//		coeff[ 16]=      -807;
//		coeff[ 17]=        -0;
//		coeff[ 18]=      1061;
//		coeff[ 19]=         0;
//		coeff[ 20]=     -1338;
//		coeff[ 21]=        -0;
//		coeff[ 22]=      1620;
//		coeff[ 23]=         0;
//		coeff[ 24]=     -1890;
//		coeff[ 25]=        -0;
//		coeff[ 26]=      2127;
//		coeff[ 27]=         0;
//		coeff[ 28]=     -2313;
//		coeff[ 29]=        -0;
//		coeff[ 30]=      2431;
//		coeff[ 31]=         0;
//		coeff[ 32]=     30296;
//		coeff[ 33]=         0;
//		coeff[ 34]=      2431;
//		coeff[ 35]=        -0;
//		coeff[ 36]=     -2313;
//		coeff[ 37]=         0;
//		coeff[ 38]=      2127;
//		coeff[ 39]=        -0;
//		coeff[ 40]=     -1890;
//		coeff[ 41]=         0;
//		coeff[ 42]=      1620;
//		coeff[ 43]=        -0;
//		coeff[ 44]=     -1338;
//		coeff[ 45]=         0;
//		coeff[ 46]=      1061;
//		coeff[ 47]=        -0;
//		coeff[ 48]=      -807;
//		coeff[ 49]=         0;
//		coeff[ 50]=       585;
//		coeff[ 51]=        -0;
//		coeff[ 52]=      -403;
//		coeff[ 53]=         0;
//		coeff[ 54]=       261;
//		coeff[ 55]=        -0;
//		coeff[ 56]=      -158;
//		coeff[ 57]=         0;
//		coeff[ 58]=        87;
//		coeff[ 59]=        -0;
//		coeff[ 60]=       -43;
//		coeff[ 61]=         0;
//		coeff[ 62]=        18;
//		coeff[ 63]=        -0;
//		coeff[ 64]=        -6;
//	end
//	
//	assign FIR_input_history[0]=input_sample;
//	generate
//		genvar i;
//		for (i=0;i<=tap_num-2;i=i+1) begin: reg_gen
//			FIR_reg fir_reg(sample_clock,reset,FIR_input_history[i],FIR_input_history[i+1]);
//		end		
//		//symmetric structure
//		for (i=0;i<=(tap_num-3)/2;i=i+1) begin: main_wire_gen
//			assign adder_wire[i]=FIR_input_history[i]+FIR_input_history[tap_num-1-i];
//			multiplier mp(adder_wire[i],coeff[i],main_adder_wire[i]);
//			assign main_wire[i]=main_wire[i+1]+main_adder_wire[i];
//		end
//	endgenerate
//	
//	// middle coeff
//	multiplier mp_m(FIR_input_history[(tap_num-1)/2],coeff[(tap_num-1)/2],main_adder_wire[(tap_num-1)/2]);
//	assign main_wire[(tap_num-1)/2]=main_adder_wire[(tap_num-1)/2];	
//	assign FIR_output_sample=main_wire[0]; //<<<1
endmodule


//module FIR_reg (sample_clock,reset,data_input,data_prev);	
//	input reset;
//	input sample_clock;
//	input signed [15:0] data_input;
//	output reg signed [15:0] data_prev;	
//	
//	always @(posedge reset, posedge sample_clock) begin
//		if (reset)
//			data_prev<=16'b0;
//		else
//			data_prev<=data_input;			
//	end
//endmodule
