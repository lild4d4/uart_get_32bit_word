`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01.02.2022 20:10:25
// Design Name: 
// Module Name: UART_interface
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


module UART_interface(
    input logic clk,reset,
    input logic instr_query,
    input logic [31:0] addr,
    input logic rx,
    output logic tx,
    output logic [31:0] Instr
    );
    
    logic div_clk;
    
    clock_divider #(163) div(clk,reset, div_clk);
    
    word_32bit_uart_tx instruction_query(div_clk,reset,instr_query,addr,tx);
    
    word_32_bit_uart_rx get_instruction(div_clk,reset,rx,Instr); 
    
endmodule
