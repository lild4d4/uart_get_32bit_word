`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2020 01:43:22 PM
// Design Name: 
// Module Name: separador
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


module separador#(parameter N = 32)(
    input logic [N-1:0] BCD,
    output logic [3:0] d1,d2,d3,d4,d5,d6,d7,d8
    );

   assign d1 = BCD[3:0], d2 = BCD[7:4], d3 = BCD[11:8], d4 = BCD[15:12], d5 = BCD[19:16], d6 = BCD[23:20], d7 = BCD[27:24],
             d8 = BCD[31:28];
    
endmodule
