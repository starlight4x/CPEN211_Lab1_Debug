module datapath_Test();

reg clk_t;
reg vsel_t, asel_t, bsel_t, loada_t, loadb_t, loadc_t, loads_t, write_t;

reg [15:0] datapath_in_t;
reg [2:0] writenum_t, readnum_t;
reg [1:0] ALUop_t, shift_t;

wire [15:0] datapath_out_t;
wire [0:0] status_t;

datapath #(16) dut(
	.datapath_in(datapath_in_t), 
	.vsel(vsel_t), 
	.asel(asel_t), 
	.bsel(bsel_t), 
	.loada(loada_t), 
	.loadb(loadb_t), 
	.loadc(loadc_t), 
	.loads(loads_t), 
	.writenum(writenum_t), 
	.write(write_t), 
	.readnum(readnum_t), 
	.clk(clk_t), 
	.ALUop(ALUop_t), 
	.shift(shift_t), 
	.datapath_out(datapath_out_t), 
	.status(status_t)
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
  
  loada_t = 1'b0;	//Setting all loads as 0
  loadb_t = 1'b0;
  loadc_t = 1'b0;
  loads_t = 1'b0;	//---------------------

  vsel_t = 1'b1; 	//Setting Vselect to read from datapath input wire;
  #100;			//---------------------


  datapath_in_t = 16'd7; //Writing 7 to R0
  writenum_t = 3'b0;
  write_t = 1'b0;
  #100;
  
  write_t = 1'b1;
  #100;

  write_t = 1'b0;	
  #100; 		//---------------------


  datapath_in_t = 16'd2; //Writing 2 to R1
  writenum_t = 3'b001;
  write_t = 1'b1;
  #100;

  write_t = 1'b0;
  #100;			//---------------------


  readnum_t = 3'b0; 	//Reading 7 from R0
  #100;

  loadb_t = 1'b1;	//Loading 7 into B
  #100;
 
  loadb_t = 1'b0;		
  #100;			//---------------------


  readnum_t = 3'b001; 	//Reading 2 from R1
  #100;

  loada_t = 1'b1;	//Loading 7 into A
  #100;
 
  loada_t = 1'b0;		
  #100;			//---------------------


  shift_t = 2'b01;      //Left shift 7 to become 14
  #100;			//---------------------

  
  asel_t = 1'b1;	//setting Aselect and Bselect to use values from A and B 
  bsel_t = 1'b1;
  #100;			//---------------------


  ALUop_t = 2'b00;	//Setting ALU to adding input A and B values
  #100;			//---------------------


  loadc_t = 1'b1;	//Load C and S registers
  loads_t = 1'b1;
  #100;

  loadc_t = 1'b0;
  loads_t = 1'b0;
  #100;			//---------------------

			//At this point datapath_out should contain a value of 16!


  vsel_t = 1'b0; 	//Setting Vselect to read from datapath_out;
  #100;			//---------------------



  writenum_t = 3'b010; 	//Write output value 16 into R2
  write_t = 1'b1;
  #100;
  
  write_t = 1'b0;
  #100; 		//---------------------

$stop;
end

endmodule










