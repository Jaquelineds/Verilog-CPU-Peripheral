`timescale 1ns / 1ps

module fsmCPU(clk,rst,ack,send,data);
  
  	input clk, rst, ack;
  	reg state, nextState;
  	output reg [3:0] data;
	output reg send;
  
  	always @ (posedge clk)
    begin
        if (rst == 1)
          	state = 0;
        else
          	state = nextState;
    end

	always @ (*)
	begin
    	case ({state})
	 		0, 1:
              begin
                  if (ack == 1)
                      nextState = 0;
                  else
                      nextState = 1;
              end
		endcase
	end

	always @ (*)
	begin
      	case ({state})
			0:
              begin
            	  send = 0;
              end
			1:
           	  begin
                  data = 4'b1100;
			  	  send = 1;
              end
		endcase
	end
  
endmodule

module fsmPeripheral(clk,rst,ack,send,newData);
  
  	input clk, rst, send;
  	input [3:0] newData;
	reg state, nextState;
  	reg [3:0] data;
	output reg ack;

  	always @ (posedge clk)
	begin
        if(rst == 1)
			state = 0;
		else
			state = nextState;
	end

	always @ (*)
	begin
       	case ({state})
			0, 1:
              begin
                  if(send == 1)
                      nextState = 1;
                  else
                      nextState = 0;
              end
		endcase
	end

	always @ (*)
	begin
       	case ({state})
			0:
              begin
                  ack = 0;
              end
			1:
              begin
                  data = newData;
                  ack = 1;
              end
		endcase
	end
  
endmodule
