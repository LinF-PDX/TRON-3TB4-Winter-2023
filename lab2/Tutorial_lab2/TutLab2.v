module TutLab2 (input CLOCK_50, input [2:0] KEY, output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

	wire clk_en;
	wire [19:0] ms;
	wire [3:0] digit0,digit1,digit2,digit3, digit4,digit5;
	
	clock_divider(.Clock(CLOCK_50), .Reset_n(KEY[0]), .clk_ms(clk_en));
	counter(.clk(clk_en), .reset_n(KEY[0]), .start_n(KEY[1]), .stop_n(KEY[2]), .ms_count(ms));
	hex_to_bcd_converter(clk_en, KEY[0], ms, digit0, digit1, digit2, digit3, digit4, digit5);
	seven_seg_decoder decoder0(digit0, HEX0);
	seven_seg_decoder decoder1(digit1, HEX1);
	seven_seg_decoder decoder2(digit2, HEX2);
	seven_seg_decoder decoder3(digit3, HEX3);
	seven_seg_decoder decoder4(digit4, HEX4);
	seven_seg_decoder decoder5(digit5, HEX5);
	
endmodule



/*//clock divider test
module TutLab2 (input clock_in, input [2:0] KEY, output [19:0] count_out);

	//clock_divider clk1(.Clock(clock_in), .Reset_n(KEY[0]), .clk_ms(clock_out));
	counter (.clk(clock_in), .reset_n(KEY[0]), .start_n(KEY[1]), .stop_n(KEY[2]), .ms_count(count_out));

endmodule

/*
module clock_divider (input Clock, output reg clk_ms);
	parameter factor=50000; //50000; // 32'h000061a7;
	
	reg [31:0] countQ;
	
	always @ (posedge Clock) begin
		if (countQ == factor-1) begin
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
*/