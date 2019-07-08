`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/04/2018 04:25:00 PM
// Design Name: 
// Module Name: fsm
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


module fsm(clk, newGame, row1, row2, row3, row4, change, image_red, image_blue, image_green, playerTurn);
    
    input clk, newGame, row1, row2, row3, row4, change;
    output [0:7] [7:0] image_red, image_blue, image_green;
    output playerTurn;
    
    reg success, playerTurn, chosenRowLeft, chosenRowRight, playL, playR, rowFinish1, rowFinish2, rowFinish3, rowFinish4;
    reg [3:0] crL, crR, countRow1, countRow2, countRow3, countRow4;
    
    reg [0:7] [7:0] image_red, image_blue, image_green;

    always_ff @(posedge clk, posedge newGame)
        if (newGame) begin
            success = 0;
            playerTurn = 1;
            countRow1 = 0;
            countRow2 = 0;
            countRow3 = 0;
            countRow4 = 0;
            rowFinish1 = 0;
            rowFinish2 = 0;
            rowFinish3 = 0;
            rowFinish4 = 0;
            chosenRowLeft = 0;
            chosenRowRight = 0;
            crL = 0;
            crR = 0;
            playL = 0;
            playR = 0;
            image_green = 
            {8'b00000000, 
              8'b00000000, 
              8'b00000000, 
              8'b00000000, 
              8'b00000000, 
              8'b00000000, 
              8'b00000000, 
              8'b00000000};
           image_blue = 
            {8'b00000000,
              8'b00000011,
              8'b00000011,
              8'b00110011,
              8'b00110011,
              8'b00110011,
              8'b00000011,
              8'b00000011};
            image_red = 
            {8'b00000000, 
              8'b00000000, 
              8'b00001100, 
              8'b00001100, 
              8'b11001100, 
              8'b00001100, 
              8'b00001100, 
              8'b00000000};     
        
        end else if (!success && row1 && playerTurn && (crL == 4'b0001 || !chosenRowLeft ) && !rowFinish1 && !(crR == 4'b0001)) begin
            if(!chosenRowLeft) begin
                crL = 4'b0001;
                chosenRowLeft = 1;
                end
            playL = 1;
            image_red [countRow1 + 4] [7] = 0;
            image_red [countRow1 + 4] [6] = 0;
            countRow1 = countRow1 + 1;
            if(image_red [4][6] == 0) begin
                 rowFinish1 = 1;
                 playL = 0;
                 playR = 0;
                 playerTurn = 0;
                 crL = 4'b0000;
                 chosenRowLeft = 0;
                 end
            success = 1;
        
        end else if (!success && row2 && playerTurn && (crL == 4'b0010 || !chosenRowLeft ) && !rowFinish2 && !(crR == 4'b0010)) begin
            if(!chosenRowLeft) begin
                crL = 4'b0010;
                chosenRowLeft = 1;
                end
            playL = 1;
            image_blue [countRow2 + 3] [5] = 0;
            image_blue [countRow2 + 3] [4] = 0;
            countRow2 = countRow2 + 1;
            if(image_blue [5][4] == 0) begin
               rowFinish2 = 1;
               playL = 0;
               playR = 0;
               playerTurn = 0;
               crL = 4'b0000;
               chosenRowLeft = 0;
               end
            success = 1;
        
        end  else if (!success && row3 && playerTurn && (crL == 4'b0100 || !chosenRowLeft ) && !rowFinish3 && !(crR == 4'b0100)) begin
            if(!chosenRowLeft) begin
                crL = 4'b0100;
                chosenRowLeft = 1;
                end
            playL = 1;
            image_red [countRow3 + 2] [3] = 0;
            image_red [countRow3 + 2] [2] = 0;
            countRow3 = countRow3 + 1;
            if(image_red [6][2] == 0) begin
               rowFinish3 = 1;
               playL = 0;
               playR = 0;
               playerTurn = 0;
               crL = 4'b0000;
               chosenRowLeft = 0;
               end
            success = 1;
         
         end else if (!success && row4 && playerTurn && (crL == 4'b1000 || !chosenRowLeft ) && !rowFinish4 && !(crR == 4'b1000)) begin
            if(!chosenRowLeft) begin
                crL = 4'b1000;
                chosenRowLeft = 1;
                end
            playL = 1;
            image_blue [countRow4 + 1] [1] = 0;
            image_blue [countRow4 + 1] [0] = 0;
            countRow4 = countRow4 + 1;
            if(image_blue [7][0] == 0) begin
                rowFinish4 = 1;
                playL = 0;
                playR = 0;
                playerTurn = 0;
                crL = 4'b0000;
                chosenRowLeft = 0;
                end
            success = 1;
         
         end else if (!success && row1 && !playerTurn && (crR == 4'b0001 || !chosenRowRight ) && !rowFinish1 && !(crL == 4'b0001)) begin
           if(!chosenRowRight) begin
                 crR = 4'b0001;
                 chosenRowRight = 1;
                 end
            playR = 1;
            image_red [countRow1 + 4] [7] = 0;
            image_red [countRow1 + 4] [6] = 0;
            countRow1 = countRow1 + 1;
            if(image_red [4][6] == 0) begin
                rowFinish1 = 1;
                playL = 0;
                playR = 0;
                playerTurn = 1;
                crR = 4'b0000;
                chosenRowRight = 0;
                end
            success = 1;
        
        end else if (!success && row2 && !playerTurn && (crR == 4'b0010 || !chosenRowRight ) && !rowFinish2 && !(crL == 4'b0010)) begin
            if(!chosenRowRight) begin
                crR = 4'b0010;
                chosenRowRight = 1;
                end
            playR = 1;
            image_blue [countRow2 + 3] [5] = 0;
            image_blue [countRow2 + 3] [4] = 0;
            countRow2 = countRow2 + 1;
            if(image_blue [5][4] == 0) begin
                rowFinish2 = 1;
                playL = 0;
                playR = 0;
                playerTurn = 1;
                crR = 4'b0000;
                chosenRowRight = 0;
                end
            success = 1;
        
        end  else if (!success && row3 && !playerTurn && (crR == 4'b0100 || !chosenRowRight ) && !rowFinish3 && !(crL == 4'b0100)) begin
            if(!chosenRowRight) begin
                crR = 4'b0100;
                chosenRowRight = 1;
                end
            playR = 1;
            image_red [countRow3 + 2] [3] = 0;
            image_red [countRow3 + 2] [2] = 0;
            countRow3 = countRow3 + 1;
            if(image_red [6][2] == 0) begin
               rowFinish3 = 1;
               playL = 0;
               playR = 0;
               playerTurn = 1;
               crR = 4'b0000;
               chosenRowRight = 0;
               end
            success = 1;
         
         end  else if (!success && row4 && !playerTurn && (crR == 4'b1000 || !chosenRowRight ) && !rowFinish4 && !(crL == 4'b1000)) begin
         if(!chosenRowRight) begin
                 crR = 4'b1000;
                 chosenRowRight = 1;
                 end
            playR = 1;
            image_blue [countRow4 + 1] [1] = 0;
            image_blue [countRow4 + 1] [0] = 0;
            countRow4 = countRow4 + 1;
             if(image_blue [7][0] == 0) begin
                   rowFinish4 = 1;
                   playL = 0;
                   playR = 0;
                   playerTurn = 1;
                   crR = 4'b0000;
                   chosenRowRight = 0;
                   end
            success = 1;
         
         end else if (change) begin
                if(playL || playR) begin
                    playerTurn = !playerTurn;
                    playL = 0;
                    playR = 0;
                end
         end else if (!row1 && !row2 && !row3 && !row4) begin
            success = 0;
         end       
endmodule
