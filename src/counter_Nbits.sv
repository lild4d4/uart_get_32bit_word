`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/31/2020 02:13:35 PM
// Design Name: 
// Module Name: counter_Nbits
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


module counter_Nbits
#(parameter N=4) // si no se especifica parametros durante la instanciacion, entonces se usa el valor por defecto
(
    input  logic            clk, reset,
    output logic [N-1:0] 	count
    );

    always_ff @(posedge clk) begin
        if (reset || count == 3'd7)begin
            count <= 'b0;  //al no especificar ancho de bits, la herramienta lo infiere de la señal a la que se esta asignando. Usar con cuidado.
            end
        else begin
            count <= count+1;
            end
    end
endmodule
