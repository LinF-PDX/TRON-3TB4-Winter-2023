module lab1part2 (input [3:0] SW, output [6:0] HEX0);
	reg [6:0] reg_LEDs;
	
	assign HEX0[0]= ( (SW[2]&(~SW[1])&(~SW[0])) | ((~SW[3])&(~SW[2])&(~SW[1])&SW[0]) | (SW[3]&SW[1]) );
	
	assign HEX0[1]= ( (SW[2]&(~SW[1])&SW[0]) | (SW[3]&SW[2]&SW[0]) | ((~SW[3])&SW[2]&SW[1]&(~SW[0])) | (SW[3]&(~SW[2])&SW[1]&(~SW[0])) );
	
	assign HEX0[6:2]=reg_LEDs[6:2];
	
	
	always @(*) begin
		case (SW)
			4'b0000: reg_LEDs[6:2]=5'b10000; //7’b1000000 decimal 0
			4'b0001: reg_LEDs[6:2]=5'b11110; //7’b1111001 decimal 1
			4'b0010: reg_LEDs[6:2]=5'b01001; //7’b0100100 decimal 2
			4'b0011: reg_LEDs[6:2]=5'b01100; //7’b0110000 decimal 3
			4'b0100: reg_LEDs[6:2]=5'b00110; //7’b0011001 decimal 4
			4'b0101: reg_LEDs[6:2]=5'b00100; //7’b0010010 decimal 5
			4'b0110: reg_LEDs[6:2]=5'b00000; //7’b0000010 decimal 6
			4'b0111: reg_LEDs[6:2]=5'b11110; //7’b1111000 decimal 7
			4'b1000: reg_LEDs[6:2]=5'b00000; //7’b0000000 decimal 8
			4'b1001: reg_LEDs[6:2]=5'b00100; //7’b0010000 decimal 9
			4'b1010: reg_LEDs[6:2]=5'b10001; //7’b1000111 letter L
			4'b1011: reg_LEDs[6:2]=5'b11110; //7’b1111001 letter I
			4'b1100: reg_LEDs[6:2]=5'b10010; //7’b1001001 letter N
			4'b1101: reg_LEDs[6:2]=5'b00011; //7’b0001110 letter F
			4'b1110: reg_LEDs[6:2]=5'b10000; //7’b1000001 letter U
			4'b1111: reg_LEDs[6:2]=5'b11111; //7’b1111111 OFF
		/* finish the case block */
			default: reg_LEDs[6:2] = 5'bx;
		endcase
	end
endmodule
