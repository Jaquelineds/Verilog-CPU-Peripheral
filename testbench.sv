// Code your testbench here
// or browse Examples
`timescale 1ns / 1ps

module test;

  wire [3:0] data;
  wire send;
  wire ack;
  reg clk1, clk2;
  reg rst;

	// Instantiate the Unit Under Test (UUT)
	fsmPeripheral peripheral (
      .clk(clk1),
      .rst(rst),
      .ack(ack),
      .send(send),
      .newData(data)
	);
  
    fsmCPU cpu (
      .clk(clk2),
        .rst(rst),
        .ack(ack),
        .send(send),
        .data(data)
      );
 

	initial begin
		// Initialize Inputs
      
      $dumpfile("dump.vcd");
      $dumpvars;
      	clk1 = 0;
      	clk2 = 0;
		rst = 1;

		// Wait 100 ns for global reset to finish
		#100;
        rst = 0;
        #100;
      
      #100;
      
      
      
      	#100;
        
	  $finish;
	end
   always  #5  begin
     clk1 = !clk1;
   end
   always #16 begin //set same as above to simulate synchronous behavior
     clk2 = !clk2;
   end
endmodule
