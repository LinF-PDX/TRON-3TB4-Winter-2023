module D_flipflop (input d, clk, output reg q, output q_b); //D flipflop
	always @(posedge clk) begin
		q <= d;
	end
	assign q_b = ~q;
endmodule

module D_ffwActiveLowSyncReset (input d, clk, reset, output reg q, output q_b); //D_ffwActiveLowSyncReset
	always @(posedge clk) begin
		if (~reset) begin
			q <= 1'b0;
		end
		else begin 
			q <= d;
		end
	end
	assign q_b = ~q;
endmodule


module D_ffwALSR_ALenable (input d, clk, reset, enable, output reg q, output q_b); //D_ffwALSR_ALenable
	always @(posedge clk) begin
		if (~enable) begin
			if (reset == 1'b0) begin
				q = 1'b0;
			end
			else begin
			q <= d;
			end
		end
	end
	assign q_b = ~q;
endmodule

module D_latch (input d, en, output	reg q, output q_b); //D_latch
	always @(*) begin
		if (en) begin
			q <= d;
		end
		else begin
		q = 1'b0;
		end
	end
	assign q_b = ~q;
endmodule

module multiplexer (a, b, c, d, sel, out); //multiplexer
	input a, b, c, d;
	input [1:0] sel;
	output reg out;
	always @(*) begin
		case (sel)
			2'b00: out <= a;
			2'b01: out <= b;
			2'b10: out <= c;
			2'b11: out <= d;
		endcase
	end
endmodule

module coutner (input clk, reset, enable, output reg [3:0]count); //counter
	always @(posedge clk) begin
		if (enable) begin
			count <= count + 1'b1;
			if (reset) begin
				count <= 4'b0;
			end
			else if (count == 4'b1111) begin
				count <= 4'b0;
			end
		end
	end
endmodule






