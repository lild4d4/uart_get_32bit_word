`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/26/2020 10:43:59 AM
// Design Name: 
// Module Name: NumToSeven
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


module NumToSeven(
    input logic [31:0] BCD_in,          //entradas y salidas requeridas
    input logic clock,reset,
    output logic [6:0] segments,
    output logic [7:0] anodos
    );
    
    logic [3:0] d1,d2,d3,d4,d5,d6,d7,d8;       
    logic [2:0] count1;
    logic [3:0] BCD;
    
    separador sep(.BCD(BCD_in),.d1(d1),.d2(d2),.d3(d3),.d4(d4),.d5(d5),.d6(d6),.d7(d7),.d8(d8));//separa BCD_in(32bits) 
                                                                                               //en 8digitos de 4bits
                                                                                               
// se podria usar el siguiente assign en vez del "separador", hacen lo mismo, pero se opto por usar un modulo especial 
//para seguir con el esquema
//    assign d1 = BCD_in[3:0], d2 = BCD_in[7:4], d3 = BCD_in[11:8], d4 = BCD_in[15:12], d5 = BCD_in[19:16],
//                 d6 = BCD_in[23:20], d7 = BCD_in[27:24], d8 = BCD_in[31:28];
        
    counter_Nbits #(3) count(.clk(clock),.reset(reset),.count(count1)); //contador interno para el control de la TDM
    TDM multiplex(.d1(d1),.d2(d2),.d3(d3),.d4(d4),.d5(d5),.d6(d6),.d7(d7),.d8(d8),.count(count1),.anodos(anodos),.BCD(BCD));
    //por cada valor de count1 habra como salida un digito de 4bits(en BCD) y el anodo correspondiente
    
    BCD_to_sevenseg toseven(.BCD(BCD),.sevenseg(segments)); // se recive el digito en BCD y se decodifica a sevenseg 

endmodule

// notar que tanto el contador como el decodificador pueden ir todos juntos en la TDM, se opto por esta forma para mantener el
//orden y el esquema inicial    
