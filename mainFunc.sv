`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2018 04:20:10 PM
// Design Name: 
// Module Name: mainFunc
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


module mainFunc(input logic clk, rst, i_ilp, i_irp, output logic a,b,c,d,e,f,g,dp, output logic [3:0] an);

    reg [3:0] in1, in2, in3, in4;

    assign an = 4'b1111;

    assign dp = 1'b0;

    scoreBoard example(rst, i_ilp, i_irp, in1, in2, in3, in4);
    
    SevSeg_4digit seg(clk, in1, in2, in3, in4, a, b, c, d, e, f, g, dp, an);

endmodule
