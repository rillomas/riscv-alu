// RISC-V ALU that can perform add,sub,slt,and,or,xor in 32bit
module riscv_alu #(
		parameter WIDTH=32,
		parameter OP_WIDTH=4
	) (
		input logic [WIDTH-1:0] inA, inB,
		input logic aluOp[OP_WIDTH-1:0],
		output logic [WIDTH-1:0] result
	);
	logic [WIDTH-1:0] sum,diff,lt,and_,or_,xor_;
	assign sum = inA + inB;
	assign diff = inA - inB;
	assign lt = inA < inB;
	assign and_ = inA & inB;
	assign or_ = inA | inB;
	assign xor_ = inA ^ inB;
	always_comb begin
		case (aluOp)
			4'b0000: result = sum;  // funct3:000 funct7:0000000
			4'b0001: result = diff; // funct3:000 funct7:0100000
			4'b0100: result = lt;   // funct3:010 funct7:0000000
			4'b1000: result = xor_; // funct3:100 funct7:0000000
			4'b1100: result = or_;  // funct3:110 funct7:0000000
			4'b1110: result = and_; // funct3:111 funct7:0000000
			default: result = 32'hcccccccc; // nop
		endcase
	end

endmodule