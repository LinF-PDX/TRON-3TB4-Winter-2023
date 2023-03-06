module echo_machine(sample_clock,input_sample,output_sample);
	input sample_clock;
	input signed [15:0] input_sample;
	output reg signed [15:0] output_sample;
	wire signed [15:0] feedback,delay_signal;
	assign feedback=output_sample;

	
	shiftregister delay(.clock(sample_clock),.shiftin(feedback),.shiftout(delay_signal),.taps());
	always @(posedge sample_clock) begin
		output_sample <= input_sample + (delay_signal >> 2);
	end
	
//	if(delay_signal[15] == 1'b1)begin
//		output_sample = input_sample + (delay_signal >> 2)|(15'b11 << 15);
//	end else begin
//		output_sample = input_sample + (delay_signal >> 2);
//	end
	
	
	
//	always@(posedge sample_clock) begin
//		output_sample<=(delay_signal>>3)+input_sample;
//	end
endmodule
