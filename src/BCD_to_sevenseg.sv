`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2020 03:09:36 PM
// Design Name: 
// Module Name: BCD_to_sevenseg
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


module BCD_to_sevenseg(
    input logic [3:0] BCD,
    output logic [6:0] sevenseg
    );
    
    always_comb begin       //notar que los segmentos funcionan con logica inversa
        case(BCD)
            4'd0: sevenseg = ~7'b1111110; // abcdefg
            4'd1: sevenseg = ~7'b0110000;
            4'd2: sevenseg = ~7'b1101101;
            4'd3: sevenseg = ~7'b1111001;
            4'd4: sevenseg = ~7'b0110011;
            4'd5: sevenseg = ~7'b1011011;
            4'd6: sevenseg = ~7'b1011111;
            4'd7: sevenseg = ~7'b1110000;
            4'd8: sevenseg = ~7'b1111111;
            4'd9: sevenseg = ~7'b1111011;
            4'd10: sevenseg =~7'b1110111;
            4'd11: sevenseg =~7'b0011111;
            4'd12: sevenseg =~7'b1001110;
            4'd13: sevenseg =~7'b0111101;
            4'd14: sevenseg =~7'b1001111;
            4'd15: sevenseg =~7'b1000111;
            default: sevenseg = ~7'b0000000;
        endcase
    end
endmodule
