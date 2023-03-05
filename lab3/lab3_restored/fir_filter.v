module fir_filter (sample_clock,reset,input_sample,FIR_output_sample);
	parameter tap_num=13; //number of delay blocks in FIR filter; must be odd number	
	input reset;
	input sample_clock;
	input signed [15:0] input_sample;
	output signed [15:0] FIR_output_sample;	
	reg signed [15:0] coeff [(tap_num-1)/2:0];	
	
	wire signed [15:0] FIR_input_history [tap_num-1:0];	// FIR_input_history[k] means x(n-k)
	wire signed [15:0] adder_wire [(tap_num-3)/2:0];
	wire signed [15:0] tap_wire [(tap_num-3)/2:0];
	wire signed [15:0] main_adder_wire [(tap_num-1)/2:0]; // including the middle coeff wire
	wire signed [15:0] main_wire [(tap_num-1)/2:0]; // including the middle coeff wire	
	
	always @(*) begin	
		coeff[  0]=      6375;
		coeff[  1]=         1;
		coeff[  2]=     -3656;
		coeff[  3]=         3;
		coeff[  4]=      4171;
		coeff[  5]=         4;
		coeff[  6]=     28404;
//		coeff[  7]=         4;
//		coeff[  8]=      4171;
//		coeff[  9]=         3;
//		coeff[ 10]=     -3656;
//		coeff[ 11]=         1;
//		coeff[ 12]=      6375;
	end
	
	assign FIR_input_history[0]=input_sample;
	generate
		genvar i;
		for (i=0;i<=tap_num-2;i=i+1) begin: reg_gen
			FIR_reg fir_reg(sample_clock,reset,FIR_input_history[i],FIR_input_history[i+1]);
		end		
		//symmetric structure
		for (i=0;i<=(tap_num-3)/2;i=i+1) begin: main_wire_gen
			assign adder_wire[i]=FIR_input_history[i]+FIR_input_history[tap_num-1-i];
			multiplier mp(adder_wire[i],coeff[i],main_adder_wire[i]);
			assign main_wire[i]=main_wire[i+1]+main_adder_wire[i];
		end
	endgenerate
	
	// middle coeff
	//multiplier already applied right shift of 16 to compensate for 32768=2^15 pre-multiplication in coefficients; but 16-15=1 shift beyond
	multiplier mp_m(FIR_input_history[(tap_num-1)/2],coeff[(tap_num-1)/2],main_adder_wire[(tap_num-1)/2]);
	assign main_wire[(tap_num-1)/2]=main_adder_wire[(tap_num-1)/2];	
	assign FIR_output_sample=main_wire[0]; //<<<1
endmodule


module FIR_reg (sample_clock,reset,data_input,data_prev);	
	input reset;
	input sample_clock;
	input signed [15:0] data_input;
	output reg signed [15:0] data_prev;	
	
	always @(posedge reset, posedge sample_clock) begin
		if (reset)
			data_prev<=16'b0;
		else
			data_prev<=data_input;			
	end
endmodule
