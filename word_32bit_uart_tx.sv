`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.01.2022 12:19:03
// Design Name: 
// Module Name: word_32bit_uart_tx
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


module word_32bit_uart_tx(
    input logic clk, reset,
    input logic addr_query,
    input logic [31:0] addr,
    output logic tx
    );
    
    //byte query --------------------------------------------------------------------------------------
    
    logic byte_query;
    logic byte_end;
    logic [7:0] byte_data;
    logic [7:0] pre_byte_data;
    
    always_ff@(posedge clk) begin
        if(reset) byte_data <= 0;
        else byte_data <= pre_byte_data;
    end
    
    uart_sm_tx byte_tx(clk,reset,byte_query,byte_data,tx,byte_end);
    
    //byte count --------------------------------------------------------------------------------------
    
    logic [2:0] byte_contador;
    logic [2:0] pre_byte_contador;
    
    always_ff@(posedge clk) begin
        if(reset) byte_contador <= 0;
        else byte_contador <= pre_byte_contador;
    end
    
    //state machine --------------------------------------------------------------------------------------
    
    localparam IDLE = 0;
    localparam START = 1;
    localparam SEND1 = 2;
    localparam SEND2 = 3;
    localparam WAITT = 4;
    
    logic [2:0] state;
    logic [2:0] next_state;
    
    always_ff@(posedge clk) begin
        if(reset) state <= IDLE;
        else state <= next_state;
    end
    
    always_comb begin
        next_state= state;
        pre_byte_contador = byte_contador;
        byte_query = 0;
        pre_byte_data = byte_data;
        case(state)
            IDLE: begin
                if(addr_query) begin
                    next_state = START;
                    pre_byte_contador = 0;
                end
            end
            START: begin
                pre_byte_contador = byte_contador + 1;
                case(byte_contador)
                    0: begin
                        pre_byte_data = addr[7:0];
                        next_state = SEND1;
                    end
                    1: begin
                        pre_byte_data = addr[15:8];
                        next_state = SEND1;
                    end
                    2: begin
                        pre_byte_data = addr[23:16];
                        next_state = SEND1;
                    end
                    3: begin
                        pre_byte_data = addr[31:24];
                        next_state = SEND1;
                    end
                    4: begin
                        next_state = IDLE;
                    end
                endcase
            end
            SEND1: begin
                byte_query = 1;
                next_state = SEND2;
            end
            SEND2: begin
                byte_query = 1;
                next_state = WAITT;
            end
            WAITT: begin
                if(byte_end) next_state = START;
            end
        endcase
    end
endmodule
