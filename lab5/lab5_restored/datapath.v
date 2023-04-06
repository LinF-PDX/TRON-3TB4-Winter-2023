module datapath (input clk, reset_n,
				// Control signals
				input write_reg_file, result_mux_select,
				input [1:0] op1_mux_select, op2_mux_select,
				input start_delay_counter, enable_delay_counter,
				input commit_branch, increment_pc,
				input alu_add_sub, alu_set_low, alu_set_high,
				input load_temp, increment_temp, decrement_temp,
				input [1:0] select_immediate,
				input [1:0] select_write_address,
				// Status outputs
				output br, brz, addi, subi, sr0, srh0, clr, mov, mova, movr, movrhs, pause,
				output delay_done,
				output temp_is_positive, temp_is_negative, temp_is_zero,
				output register0_is_zero,
				// Motor control outputs
				output [3:0] stepper_signals
);
// The comment /*synthesis keep*/ after the declaration of a wire
// prevents Quartus from optimizing it, so that it can be observed in simulation
// It is important that the comment appear before the semicolon
wire [7:0] position /*synthesis keep*/;
wire [7:0] delay /*synthesis keep*/;
wire [7:0] register0 /*synthesis keep*/;
//user added
wire [7:0] alu_result_wire/*synthesis keep*/;
wire [7:0] pc_wire/*synthesis keep*/;
wire [7:0] q_wire/*synthesis keep*/;
wire [7:0] result_mux_wire/*synthesis keep*/;
wire [1:0] write_select_wire/*synthesis keep*/;
wire [7:0] selected0_wire/*synthesis keep*/;
wire [7:0] selected1_wire/*synthesis keep*/;
wire [7:0] register2 /*synthesis keep*/;
wire [7:0] register3 /*synthesis keep*/;
wire [7:0] immediate_wire/*synthesis keep*/;
wire [7:0] op1_wire/*synthesis keep*/;
wire [7:0] op2_wire/*synthesis keep*/;

pc the_pc(
	// Inputs
	.clk (clk),
	.reset_n (reset_n),
	.branch (commit_branch),
	.increment (increment_pc),
	.newpc (alu_result_wire),
	// Outputs
	.pc (pc_wire)
);

instruction_rom the_instruction_rom(
	// Inputs
	.address (pc_wire),
	.clock (clk),
	//user added
	.data(),
	.wren(),
	// Outputs
	.q (q_wire)
);

decoder the_decoder (
	// Inputs
	.instruction (q_wire[7:2]),
	// Outputs
	.br (br),
	.brz (brz),
	.addi (addi),
	.subi (subi),
	.sr0 (sr0),
	.srh0 (srh0),
	.clr (clr),
	.mov (mov),
	.mova (mova),
	.movr (movr),
	.movrhs (movrhs),
	.pause (pause)
);
regfile the_regfile(
	// Inputs
	.clk (clk),
	.reset_n (reset_n),
	.write (write_reg_file),
	.data (result_mux_wire), 
	.select0 (q_wire[1:0]),
	.select1 (q_wire[3:2]),
	.wr_select (write_select_wire),
	// Outputs
	.selected0 (selected0_wire),
	.selected1 (selected1_wire),
	.delay (delay),
	.position (position),
	.register0 (register0)
);

write_address_select the_write_address_select(
	// Inputs
	.select (select_write_address),
	.reg_field0 (q_wire[1:0]),
	.reg_field1 (q_wire[3:2]),
	// Outputs
	.write_address(write_select_wire)
);

result_mux the_result_mux (
	.select_result (result_mux_select),
	.alu_result (alu_result_wire),
	.result (result_mux_wire)
);

immediate_extractor the_immediate_extractor(
	// Inputs
	.instruction (q_wire),
	.select (select_immediate),
	// Outputs
	.immediate (immediate_wire)
);

alu the_alu(
	// Inputs
	.add_sub (alu_add_sub),
	.set_low (alu_set_low),
	.set_high (alu_set_high),
	.operanda (op1_wire),
	.operandb (op2_wire),
	// Outputs
	.result (alu_result_wire)
);

op1_mux the_op1_mux(
	// Inputs
	.select (op1_mux_select),
	.pc (pc_wire),
	.register (selected0_wire),
	.register0 (register0),
	.position (position),
	// Outputs
	.result(op1_wire)
);

op2_mux the_op2_mux(
	// Inputs
	.select (op2_mux_select),
	.register (selected1_wire),
	.immediate (immediate_wire),
	// Outputs
	.result (op2_wire)
);

stepper_rom the_stepper_rom(
	// Inputs
	.address (position[2:0]),
	.clock (clk),
	//user added
	.data(),
	.wren(),
	// Outputs
	.q (stepper_signals)
);

branch_logic the_branch_logic(
	// Inputs
	.register0 (register0),
	// Outputs
	.branch (register0_is_zero)
);

delay_counter the_delay_counter(
	// Inputs
	.clk(clk),
	.reset_n (reset_n),
	.start (start_delay_counter),
	.enable (enable_delay_counter),
	.delay (delay),
	// Outputs
	.done (delay_done)
);

temp_register the_temp_register(
	// Inputs
	.clk (clk),
	.reset_n (reset_n),
	.load (load_temp),
	.increment (increment_temp),
	.decrement (decrement_temp),
	.data (selected0_wire),
	// Outputs
	.negative (temp_is_negative),
	.positive (temp_is_positive),
	.zero (temp_is_zero)
);

endmodule
