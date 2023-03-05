module MUX_3to1(input [15:0] d0,d1,d2,input [1:0] sel,output reg [15:0] q);
	always @(*) begin
		case(sel)
			2'b00:q=d0;
			2'b01:q=d1;
			2'b10:q=d2;
			2'b11:q=d0;
			default:q=d0;
		endcase
	end
endmodule
