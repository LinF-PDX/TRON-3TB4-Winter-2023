module alu (input add_sub, set_low, set_high, input [7:0] operanda , operandb, output reg [7:0] result);

always @(*) begin
	if (set_low) begin //SR0
		result<={operanda[7:4], operandb[3:0]};
	end else if (set_high) begin //SRH0
		result<={operandb[3:0], operanda[3:0]};
	end else if (!add_sub) begin //note: add_sub=0 -> addition
		result<=operanda+operandb;
	end else begin
		result<=$signed(operanda-operandb);
//		result<=operanda-operandb;
	end
end

endmodule
