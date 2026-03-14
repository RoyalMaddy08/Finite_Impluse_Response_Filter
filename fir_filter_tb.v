`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2026 23:52:39
// Design Name: 
// Module Name: fir_filter_tb
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


module fir_filter_tb;
parameter N1=8; 
parameter N2=16;
parameter N3=32;
reg clk;
reg rst;
reg enable;
reg [N2-1:0]input_data;
reg [N2-1:0] data [99:0]; //stores all the input samples from the file
wire [N3-1:0] output_data; // output data
wire [N3-1:0] sampling; //additional output for testing

fir_filter UUT(.input_data(input_data),                   //RTL(TB)
               .output_data(output_data),
               .clk(clk),
               .rst(rst),
               .enable(enable),
               .sampling(sampling)
               );
integer k; // integer for "for loop"
integer file1; // for saving filtered data
always #10 clk=~clk;

initial 
begin
   k=0;//Input sample number, k denotes row number from data file
   $readmemb("input.data",data);// load the data samples and store them in an array from the file called data
   file1=$fopen("save.data","w");
 
 clk=0; //set clk to zero
 #20
 rst=1'b1; //reseting the filters so all coefficients will get back to 0
 #40
 rst=1'b0;
 enable=1'b1; //started the filter
 input_data<=data[0];
 #10
 for(k=1;k<100;k=k+1)
 begin
   @(posedge clk)
   $fdisplay(file1,"%b",output_data);
   input_data<=data[k];
   if(k==99)
   $fclose(file1);
   
 end
 
 
 
 
end

endmodule
