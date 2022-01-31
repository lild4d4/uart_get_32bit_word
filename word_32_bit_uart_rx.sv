`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.01.2022 12:19:25
// Design Name: 
// Module Name: word_32_bit_uart_rx
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


module word_32_bit_uart_rx(
    input logic clk,reset,
    input logic rx,
    output logic [31:0] instr
    );
    
    //byte in -------------------------------------------------------------------------------------------------
    
    logic [7:0] byte_in;
    logic byte_end;
    
    uart_sm_rx byte_rx(clk,reset,rx,byte_in,byte_end);
    
    //instr ----------------------------------------------------------------------------------------------------
    
    logic [31:0] pre_instr;
    
    always_ff@(posedge clk) begin
        if(reset) instr <= 0;
        else instr <= pre_instr;
    end
    
    // state machine ----------------------------------------------------------------------------------------------------
    
    localparam WAITB1 = 0;
    localparam BYTE1 = 1;
    localparam WAITB2 = 2;
    localparam BYTE2 = 3;
    localparam WAITB3 = 4;
    localparam BYTE3 = 5;
    localparam WAITB4 = 6;
    localparam BYTE4 = 7;
    
    logic [2:0] state;
    logic [2:0] next_state;
    
    always_ff@(posedge clk) begin
        if(reset) state <= WAITB1;
        else state <= next_state;
    end
    
    always_comb begin
        next_state =  state;
        pre_instr = instr;
        case(state)
            WAITB1: begin
                if(byte_in == 1) begin
                    if(byte_end) next_state = BYTE1;
                end 
            end
            
            BYTE1: begin
                if(byte_end) next_state = WAITB2;
                else pre_instr[7:0] = byte_in;
            end
            
            WAITB2: begin
                if(byte_in == 2) begin
                    if(byte_end) next_state = BYTE2;
                end
            end
            
            BYTE2: begin
                if(byte_end) next_state = WAITB3;
                else pre_instr[15:8] = byte_in;
            end
            
            WAITB3: begin
                if(byte_in == 3) begin
                    if(byte_end) next_state = BYTE3;
                end
            end
            
            BYTE3: begin
                if(byte_end) next_state = WAITB4;
                else pre_instr[23:16] = byte_in;
            end
            
            WAITB4: begin
                if(byte_in == 4) begin
                    if(byte_end) next_state = BYTE4;
                end
            end
            
            BYTE4: begin
                if(byte_end) next_state = WAITB1;
                else pre_instr[31:24] = byte_in;
            end
        endcase
    end
endmodule
