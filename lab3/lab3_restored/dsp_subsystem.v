module dsp_subsystem (input sample_clock,  input reset, input [1:0] selector, input [15:0] input_sample, output [15:0] output_sample);
	wire [15:0] FIR_output_sample;
	wire [15:0] Echo_output_sample;
	
	MUX_3to1 mux(input_sample,FIR_output_sample,Echo_output_sample,selector,output_sample);
	fir_filter #(13) fir_filter(sample_clock,reset,input_sample,FIR_output_sample);
	echo_machine echo(sample_clock,input_sample,Echo_output_sample);



endmodule
