module write_address_select (input [1:0] select, input [1:0] reg_field0, reg_field1, output reg [1:0] write_address);
	//mux
	always @(*) begin
		case(select)
			2'b00:write_address<=0;
			2'b01:write_address<=reg_field0;
			2'b10:write_address<=reg_field1;
			2'b11:write_address<=2;
			default:write_address<=0; //error case
		endcase
	end
endmodule
