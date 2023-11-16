`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: COLLEGE OF VLSI
// Engineer: ABHISHEK KUMAR KUSHWAHA
// 
// Create Date: 17.05.2023 15:46:12
// Designe Name: general_clk_div_by_odd
// Module Name: general_clk_div_by_odd
// Project Name: general_clk_div_by_odd
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module general_clk_div_by_odd(
	input		clk_in,
    input       rst,    
	output 		clk_out
    );
parameter DIV_BY = 9 ;
parameter WIDTH = $clog2(DIV_BY);

reg  [WIDTH-1:0] count;
reg  Tff_A, Tff_B;
wire B1,A1;

assign 	 clk_out = Tff_B ^ Tff_A;	//XOR gate produces output clock.


//Counter for division by N
always@(posedge clk_in or negedge rst)
	begin
        if(!rst)begin
            count <=0;
        end
		else if(count == DIV_BY-1)	//Count to N-1. Ex: Use 4 to divide by 5
			begin
				count <= 4'b0000;
			end	
		else
			begin
				count <= count + 1;
			end	
	end

//Sets A to high for one clock cycle after counter is 0
//always@(*)
//	begin
//    if(count == 4'b0000)
//			A1 = 1;
//		else
//			A1 = 0;
//	end
assign A1 = (count == 4'b0000)? 1'b1 :1'b0;
//Sets B to high for one clock cycle after counter is (N+1)/2
//always@(*)
//	begin

//		if(count ==((DIV_BY+1)/2))	//Use (N+1)/2. Ex: (5+1)/2 = 3		
//			B1 = 1;
//		else
//			B1 = 0;
//	end
assign B1 = (count ==((DIV_BY+1)/2))? 1'b1 :1'b0;

//T flip flop toggles 
always@(negedge A1 or negedge rst)		// Toggle signal Tff_A whenever A1 goes from 1 to 0
	 if(!rst)begin
        Tff_A <= 0;
        end
	else begin
		Tff_A <= ~Tff_A;
	end

always@(negedge clk_in or negedge rst)
	begin
	        if(!rst)begin
            Tff_B <= 0;
        end
		else if(B1)				// Toggle signal Tff_B whenever B1 clk_in goes from 1 to 0
			begin				// and B1 is 1
				Tff_B <= ~Tff_B;
			end
	end

endmodule

