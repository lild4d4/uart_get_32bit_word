`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2020 02:32:22 PM
// Design Name: 
// Module Name: TDM
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


module TDM(
    input logic [3:0] d1,d2,d3,d4,d5,d6,d7,d8,
    input logic [2:0] count,
    output logic [7:0] anodos,
    output logic [3:0] BCD
    
    );
    
    always_comb begin   //notar que los anodos tiene logica inversa, para prenderlos debe esatr en 0.
    
        case (count)
    
            3'd0: begin
                anodos = ~8'b00000001;  // se agrega el anodo correspondiente
                BCD = d1;               // se agrega el valor del digito correspondiente
                end
                
            3'd1: begin
                anodos = ~8'b00000010;
                BCD = d2;
                end
                
            3'd2: begin
                anodos = ~8'b00000100;
                BCD = d3;
                end
                
            3'd3: begin
                anodos = ~8'b00001000;
                BCD = d4;
                end    
              
            3'd4: begin
                anodos = ~8'b00010000;
                BCD = d5;
                end
                
            3'd5: begin
                anodos = ~8'b00100000;
                BCD = d6;
                end
                
            3'd6: begin
                anodos = ~8'b01000000;
                BCD = d7;
                end
                
            3'd7: begin
                anodos = ~8'b10000000;
                BCD = d8;
                end    
            default: begin
                anodos = ~8'b00000000;
                BCD = 'd0;
            end
        endcase
    
    end
endmodule
