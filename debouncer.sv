`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/05/2018 01:17:33 PM
// Design Name: 
// Module Name: debouncer
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


module debounce (
    input clk,
    input btn,
    output out
  );
 
  reg [16:0] ctr_d, ctr_q;
  reg [1:0] sync_d, sync_q;
 
  assign out = ctr_q == {17{1'b1}};
 
  always @(*) begin
    sync_d[0] = btn;
    sync_d[1] = sync_q[0];
    ctr_d = ctr_q + 1'b1;
 
    if (ctr_q == {17{1'b1}}) begin
      ctr_d = ctr_q;
    end
 
    if (!sync_q[1])
      ctr_d = 17'd0;
  end
 
  always @(posedge clk) begin
    ctr_q <= ctr_d;
    sync_q <= sync_d;
  end

endmodule
