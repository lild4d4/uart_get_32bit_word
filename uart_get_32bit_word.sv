`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.01.2022 13:06:16
// Design Name: 
// Module Name: uart_get_32bit_word
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

 
module uart_get_32bit_word(
    input logic clk, reset,
    input logic addr_query,
    input logic [15:0] addr,
    input logic rx,
    output logic tx,
    output logic tx_debug,
    output logic div_clk_debug,
    output logic rx_debug,
    output logic query_debug,
    output logic [6:0] segments,
    output logic [7:0] anodos
    );
    
    //clocks -------------------------------------------------------------------------------------------------------------------
    
    logic div_clk;
    logic div_clk1;
    
    clock_divider #(163) div(clk, ~reset, div_clk);  
    clock_divider #(49999) div1(clk, ~reset, div_clk1);
    
    //Buttons ------------------------------------------------------------------------------------------------------------------
    
    logic PB_pressed_status,PB_pressed_pulse,PB_released_pulse;
    
    pb_debouncer #(1) db1(div_clk,~reset,addr_query,PB_pressed_status,PB_pressed_pulse,PB_released_pulse); 
    
    //query ---------------------------------------------------------------------------------------------------------------------
    
    logic [31:0] addr_a;
    assign addr_a[15:0] = addr;
    logic [31:0] Instr;
    
    word_32bit_uart_tx instruction_query(div_clk,~reset,PB_pressed_pulse,addr_a,tx);
    
    word_32_bit_uart_rx get_instruction(div_clk,rx,~reset,Instr);               
    
    //Display ------------------------------------------------------------------------------------------------------------------
    
    NumToSeven svn(Instr,div_clk1,~reset,segments,anodos);  
    
    //debug signals -------------------------------------------------------------------------------------------------------------
    
    assign tx_debug = tx;
    assign rx_debug = rx;
    assign div_clk_debug = div_clk;
    assign query_debug = PB_pressed_pulse;  
    
endmodule
