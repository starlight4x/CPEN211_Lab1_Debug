module ALU_test();

  reg [15:0] ain_t, bin_t ;
  reg [1:0] ALUop_t ;

  wire [15:0] alu_out_t ;
  wire status_in_t ;

  ALU #(16,2) dut(
	.ain(ain_t), 
	.bin(bin_t),
	.alu_out(alu_out_t), 
	.ALUop(ALUop_t), 
	.status_in(status_in_t)
  );
/*
  initial begin		//Iterative test for all cases (Takes long time to process ~10 minutes)
	ain_t = 16'b0;
	bin_t = 16'b0;
	#10;
   	repeat (65535) begin
		repeat (65535) begin
			#10;
			ALUop_t = 2'b0;
			repeat (4) begin
				#10;
				if (ALUop_t == 2'b00 & alu_out_t != ain_t + bin_t) begin
					$display("Error: %d + %d != %d", ain_t, bin_t, alu_out_t);
					$stop;
				end
				else if (ALUop_t == 2'b01 & alu_out_t != ain_t - bin_t) begin
					$display("Error: %d - %d != %d", ain_t, bin_t, alu_out_t);
					$stop;
				end
				else if (ALUop_t == 2'b10 & alu_out_t != (ain_t & bin_t)) begin
					$display("Error: %d & %d != %d", ain_t, bin_t, alu_out_t);
					$stop;
				end
				else if (ALUop_t == 2'b11 & alu_out_t != ain_t) begin
					$display("Error: %d != %d", ain_t, alu_out_t);
					$stop;
				end
				ALUop_t = ALUop_t + 2'b01;
			end
			#10;
			ain_t = ain_t + 16'b0000000000000001;
		end
		#10;
		bin_t = bin_t + 16'b0000000000000001;
	end
  end
*/

  initial begin
	ain_t = 16'b0000000000000001;
	bin_t = 16'b0000000000000010;
	ALUop_t = 2'b00;
	#10;

	ALUop_t = 2'b01;
	#10;

	ALUop_t = 2'b10;
	#10;

	ALUop_t = 2'b11;
	#10;

	ain_t = 16'b0000000000000111;
	bin_t = 16'b0000000000001111;
	ALUop_t = 2'b10;
	#10;

	ain_t = 16'b0000000000000011;
	bin_t = 16'b0000000000000011;		//Test case for status output
   	ALUop_t = 2'b01;
	#10; 
  end
endmodule
	
module shifter_Test();

  reg [1:0] shift_t;
  reg [15:0] b_t;

  wire [15:0] shift_out_t ;

  shifter #(2, 16) dut(
	.shift(shift_t), 
	.b(b_t), 
	.shift_out(shift_out_t)
  );

  initial begin

	b_t = 16'b1111000011001111;
	shift_t = 2'b00;
	#10;

	repeat(3) begin
		shift_t = shift_t + 2'b01;
		#10;
 	end
  end
endmodule


module regfile_Test();

  reg write_t, clk_t;
  reg [2:0] writenum_t, readnum_t;
  reg [15:0] data_in_t;
  
  wire [15:0] data_out_t;

  regfile dut(
	.writenum(writenum_t), 
	.readnum(readnum_t), 
	.write(write_t), 
	.data_in(data_in_t), 
	.clk(clk_t), 
	.data_out(data_out_t)
  );

  initial begin
    clk_t = 1'b0;
    #10;
    forever begin
      clk_t = 1'b1;
      #10;
      clk_t = 1'b0;
      #10;
    end
  end

  initial begin
    data_in_t  = 16'd2;
    writenum_t = 3'b000;
    readnum_t  = 3'b111;
    write_t    = 1'b0;
    #100;
    
    repeat(7) begin                     //Attempting to write 2n to register n-1 (reg0->2, reg1->4, reg2->6 ,..., reg7->16)
      data_in_t = data_in_t + 16'd2;    //This process is done in ascending order from reg0 to reg7
      writenum_t = writenum_t + 3'b1; 
      write_t = 1'b0;
      #100;

      write_t = 1'b1;
      #100;
    end					//Given this setup, reg0 should contain no values righ now

    #500;

    repeat(7) begin   
      readnum_t = readnum_t - 3'b1; 	//Attempting to read register from reg7 to reg0
      #100;
    end
					//Note: Check if reading of reg0 give undefined signal!
    $stop;
  end
endmodule




































