module lab2Test (input CLOCK_50, input [2:0] KEY, output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);

	wire clk_en;
	wire rand_ready;
	wire [3:0] digit0,digit1,digit2,digit3,digit4,digit5;
	
	clock_divider(.Clock(CLOCK_50), .Reset_n(KEY[1]), .Pulse_ms(clk_en));
	random(.clk(clk_in), .reset_n(KEY[1]), .resume_n(KEY[2]), .random(rand), .rnd_ready(rand_ready));
	hex_to_bcd_converter(CLOCK_50, KEY[1], rand, digit0, digit1, digit2, digit3, digit4, digit5);
	seven_seg_decoder decoder0(digit0, HEX0);
	seven_seg_decoder decoder1(digit1, HEX1);
	seven_seg_decoder decoder2(digit2, HEX2);
	seven_seg_decoder decoder3(digit3, HEX3);
	seven_seg_decoder decoder4(digit4, HEX4);
	seven_seg_decoder decoder5(digit5, HEX5);
	

endmodule

/*
//----------------RANDOM MODULE TEST-----------------
module lab2Test (input clk_in, reset, resume, output [13:0] rand,
	output rand_ready);
	
	random(.clk(clk_in), .reset_n(reset), .resume_n(resume), .random(rand), .rnd_ready(rand_ready));

endmodule
*/

module random (input clk, reset_n, resume_n, output reg [13:0] random,
	output reg rnd_ready);
	//for 14 bits Liner Feedback Shift Register,
	//the Taps that need to be XNORed are: 14, 5, 3, 1
	wire xnor_taps, and_allbits, feedback;
	reg [13:0] reg_values;
	reg enable=1;
	always @ (posedge clk, negedge reset_n, negedge resume_n) begin
		if (!reset_n) begin
			reg_values<=14'b11111111111111;
			//the LFSR cannot be all 0 at beginning.
			enable<=1;
			rnd_ready<=0;
		end
		else if (!resume_n) begin
			enable<=1;
			rnd_ready<=0;
			reg_values<=reg_values;
		end
		else begin
			if (enable) begin
				reg_values[13]=reg_values[0];
				reg_values[12:5]=reg_values[13:6];
				reg_values[4]<=reg_values[0] ^ reg_values[5];
				// tap 5 of the diagram from the lab manual
				reg_values[3]=reg_values[4];
				reg_values[2]<=reg_values[0] ^ reg_values[3];
				// tap 3 of the diagram from the lab manual
				reg_values[1]=reg_values[2];
				reg_values[0]<=reg_values[0] ^ reg_values[1];
				// tap 1 of the diagram from the lab manual
				/* fill your code here to make sure the random */
				
				/* number is between 1000 and 5000 */
				
				if (reg_values >= 1000 && reg_values <= 5000) begin
					random <= reg_values;
					rnd_ready <= 1'b1;
					enable <= 1'b0;
				end
				
			end //end of ENABLE.
		end
	end
endmodule

module hex_to_bcd_converter (input wire clk, reset, input wire [19:0] hex_number,
	output [3:0] bcd_digit_0, bcd_digit_1, bcd_digit_2, bcd_digit_3, bcd_digit_4, bcd_digit_5);
	
	//DE1-SoC has 6 7_seg_LEDs, 20 bits can represent decimal 999999.
	//This module is designed to convert a 20 bit binary representation to BCD
	
	integer i, k;
	wire [19:0] hex_number1; // the last 20 bits of input hex_number
	reg [3:0] bcd_digit [5:0]; //simplifies program
	assign hex_number1=hex_number[19:0];
	assign bcd_digit_0=bcd_digit[0];
	assign bcd_digit_1=bcd_digit[1];
	assign bcd_digit_2=bcd_digit[2];
	assign bcd_digit_3=bcd_digit[3];
	assign bcd_digit_4=bcd_digit[4];
	assign bcd_digit_5=bcd_digit[5];
	
	always @ (*) begin
		//set all 6 digits to 0
		for (i=5; i>=0; i=i-1) begin
			bcd_digit[i] = 4'b0;
		end
		//shift 20 times
		for (i=19; i>=0; i=i-1) begin
			bcd_digit[0] = bcd_digit[0] + hex_number1[i];
			//check all 6 BCD tetrads, if >=5 then add 3
			for (k=5; k>=0; k=k-1) begin
				if (bcd_digit[k] >= 5) begin
					bcd_digit[k] = bcd_digit[k] + 4'd3;
				end
			end
			//shift one bit of BIN/HEX left for the first 5 tetrads
			for (k=5; k>=1; k=k-1) begin
				bcd_digit[k]=bcd_digit[k] << 1;
				bcd_digit[k][0]=bcd_digit[k-1][3];
			end
			//shift one bit of BIN/HEX left, for the last tetrad
			bcd_digit[0] = bcd_digit[0] << 1;
		end //end for loop
		bcd_digit[0] = bcd_digit[0] + hex_number1[0];
	end //end of always.
endmodule

module clock_divider (input Clock, Reset_n, output reg Pulse_ms);
	parameter factor=10; //50000;	// 32'h000061a7;
	reg [31:0] countQ;
	always @ (posedge Clock, negedge Reset_n) begin
		if (!Reset_n) begin
			countQ<=0;
			Pulse_ms<=0;
		end 
		else begin 
			if (countQ<factor/2) begin
					countQ<=countQ+1;
					Pulse_ms<=0;
				end
			else if (countQ<factor) begin
					countQ<=countQ+1;
					Pulse_ms<=1;
			end
			else begin//countQ==factor					 
					countQ<=0;
					Pulse_ms<=0;
			end	
		end 
	end
endmodule

module seven_seg_decoder(input [3:0] x, output reg [6:0] hex_LEDs);
	// sorry did not follow the lab manual instruction strictly---
	// did not use the assign statement for the first two segments.
	always @(*) begin 
		case (x)
			4'b0000:  hex_LEDs=7'b1000000;  // decimal 0
			4'b0001:  hex_LEDs=7'b1111001;  // 1
			4'b0010:  hex_LEDs=7'b0100100; //2
			4'b0011:  hex_LEDs=7'b0110000;  // 3
			4'b0100:  hex_LEDs=7'b0011001;  // 4
			4'b0101:  hex_LEDs=7'b0010010;  //5
			4'b0110:  hex_LEDs=7'b0000010;  //6
			4'b0111:  hex_LEDs=7'b1111000; //7
			4'b1000:  hex_LEDs=7'b0000000; //8
			4'b1001:  hex_LEDs=7'b0010000;//9 
			4'b1010:  hex_LEDs=7'b0001000;//A
			4'b1011:  hex_LEDs=7'b0000011; //b
			4'b1100:  hex_LEDs=7'b1000110;//C
			4'b1101:  hex_LEDs=7'b0100001;//d
			4'b1110:  hex_LEDs=7'b0000110;//E
		//	4'b1111:  hex_LEDs=7'b0001110; //F
			4'b1111:  hex_LEDs=7'b1111111;   //when value is 1111, turn all segments off!!!
		endcase
	end
endmodule
