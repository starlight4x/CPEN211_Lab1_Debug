module ALU (ain, bin, alu_out, ALUop, status_in);

parameter m = 16 ;
parameter n = 1 ;
input [m-1:0] ain ;
input [m-1:0] bin ;
input [n:0] ALUop ;

output reg [m-1:0] alu_out ;
output reg [n-1:0] status_in ;

always @ (*) begin
	case(ALUop)
		2'b00: alu_out = ain + bin ;
		2'b01: alu_out = ain - bin ;
		2'b10: alu_out = ain & bin ;
		2'b11: alu_out = ain ;
	endcase
	if (alu_out == 16'b0)
		status_in = 1'b1 ;
	else
		status_in = 1'b0 ;
 end
endmodule