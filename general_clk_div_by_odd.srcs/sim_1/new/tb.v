`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.05.2023 14:58:19
// Design Name: 
// Module Name: tb
// Project Name: 
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


// Code your testbench here
// or browse Examples
module tb();
  parameter DIV_BY = 13 ;
  parameter WIDTH = $clog2(DIV_BY);

  reg       clk_in;
  reg       rst; 
  wire      clk_out;

  general_clk_div_by_odd #(.DIV_BY(DIV_BY), .WIDTH(WIDTH)) dut_inst (clk_in, rst, clk_out );

  initial begin
    clk_in = 1'b0;
    forever #5 clk_in = ~clk_in;
  end

  initial begin
    rst = 1'b0;
    @(posedge clk_in);
    rst = 1'b1;   
  end
endmodule
