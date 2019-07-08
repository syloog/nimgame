`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/03/2018 05:07:09 PM
// Design Name: 
// Module Name: top
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


module top(clk, newGame, reset, i_irp, i_ilp, i_drp, i_dlp,row1, row2, row3, row4, change, a, b, c, d, e, f, g, dp, an, reset_out, OE, SH_CP, ST_CP, DS, col_select, playerTurn);

    input clk, newGame, reset, row1, row2, row3, row4, change;
    input reg i_irp, i_ilp, i_drp, i_dlp;
    reg [3:0] o_lps, o_rps, o_lps_second, o_rps_second;
    output a, b, c, d, e, f, g, dp, playerTurn;
    output [3:0] an;
    output reset_out, OE, SH_CP, ST_CP, DS;
    output [7:0] col_select;
    logic [0:2] col_num;
   
    wire row1Deb, row2Deb, row3Deb, row4Deb, changeDeb;
    
    reg [0:7] [7:0]  image_green, image_blue, image_red;
    
    reg playerTurn;
    
    initial begin
        o_lps = 4'b0000;
        o_rps = 4'b0000;
        o_lps_second = 4'b0000;
        o_rps_second = 4'b0000;
    end

    debounce deb1(clk, row1, row1Deb);
    debounce deb2(clk, row2, row2Deb);
    debounce deb3(clk, row3, row3Deb);
    debounce deb4(clk, row4, row4Deb);
    debounce deb5(clk, change, changeDeb);

    fsm fsm1(clk, newGame, row1Deb, row2Deb, row3Deb, row4Deb, changeDeb, image_red, image_blue, image_green, playerTurn);

    up_down_counter up1(
    o_lps     ,  // Output of the counter
    o_lps_second,
    i_ilp  ,  // enable for counter
    i_dlp  ,
    clk     ,  // clock Input
    reset      // reset Input
    );

    up_down_counter up2(
    o_rps     ,  // Output of the counter
    o_rps_second,
    i_irp  ,  // enable for counter
    i_drp  ,
    clk     ,  // clock Input
    reset      // reset Input
    );

    SevSeg_4digit sev1
    (clk,
    o_lps, o_lps_second, o_rps, o_rps_second, //user inputs for each digit (hexadecimal value)
    a, b, c, d, e, f, g, dp, // just connect them to FPGA pins (individual LEDs).
    an // just connect them to FPGA pins (enable vector for 4 digits active low)
	);

    display8x8 display(
            .clk(clk),
            
            // RGB data for display current column
            .red_vect_in(image_red[col_num]),
            .green_vect_in(image_green[col_num]),
            .blue_vect_in(image_blue[col_num]),
            
            .col_data_capture(), // unused
            .col_num(col_num),
            
            // FPGA pins for display
            .reset_out(reset_out),
            .OE(OE),
            .SH_CP(SH_CP),
            .ST_CP(ST_CP),
            .DS(DS),
            .col_select(col_select)
        );

endmodule
