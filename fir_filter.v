`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:  RoyalMaddy07
// Engineer: Akshay Nambiar 
// 
// Create Date: 14.03.2026 21:27:38
// Design Name: 
// Module Name: fir_filter
// Project Name: Finite Impulse Response
// Target Devices: AT-100 
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


module fir_filter(input_data, clk, rst, enable, sampling, output_data);

parameter N1=8;  //No. of taps or FIR co-efficient word width
parameter N2=16; // input data word width
parameter N3=32; // output data word width

wire signed [N1-1:0]b[7:0]; // This is an array in which b has 8 variables like b0, b1, b2, b3, b4, b5, b6, b7 and each has 8 bit signed binary

// filter co-efficinet 
assign b[0]=8'b00010000;
assign b[1]=8'b00010000;
assign b[2]=8'b00010000;
assign b[3]=8'b00010000;
assign b[4]=8'b00010000;
assign b[5]=8'b00010000;
assign b[6]=8'b00010000;
assign b[7]=8'b00010000;

input signed [N2-1:0]  input_data; //input data (precision) 
output signed [N2-1:0] sampling; // output samples 
input clk;
input rst; // reset filter to zero 
input enable; // enable the filter 
output signed [N3-1:0] output_data; // This is where filtered data would come
reg signed [N3-1:0] output_data_reg; // This is where it would be stored 
reg signed [N2-1:0] sample[0:6]; // used to store samples and shift them; uk,uk-1,uk-2, uk-3,uk-4, uk-5,uk-6

always@(posedge clk)
begin
    if(rst==1'b1)
      begin
       sample[0]<=0;
       sample[1]<=0;
       sample[2]<=0;
       sample[3]<=0;
       sample[4]<=0;
       sample[5]<=0;
       sample[6]<=0;
       output_data_reg<=0;
      end
    
    if((enable==1'b1)&&(rst==1'b0))
     begin
      output_data_reg=b[0]*input_data+ b[1]*sample[0]+ b[2]*sample[1]+ b[3]*sample[2]+ b[4]*sample[3]+ b[5]*sample[4]+b[6]*sample[5]+ b[7]*sample[6];
      
     sample[0]<=input_data;
     sample[1]<=sample[0];
     sample[2]<=sample[1];
     sample[3]<=sample[2];
     sample[4]<=sample[3];
     sample[5]<=sample[4];
     sample[6]<=sample[5];
     end
    end 

assign output_data=output_data_reg;
assign sampling = sample[0];



endmodule
