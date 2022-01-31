`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.01.2022 12:11:42
// Design Name: 
// Module Name: uart_sm_tx
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


module uart_sm_tx(
    input logic clk,
    input logic reset,
    input logic send_pulse,
    input logic [7:0] byte_in,
    output logic tx,
    output logic byte_end
    );
    
    //Tx --------------------------------------------------------------------------------------------------
    
    logic pre_tx;
    
    always_ff@(posedge clk) begin
        if(reset) tx <= 1;
        else tx <= pre_tx;
    end
    
    //cycles count --------------------------------------------------------------------------------------------------
    
    logic [4:0] count;
    logic [4:0] pre_count;
    
    always_ff@(posedge clk) begin
        if(reset) count <= 0;
        else count <= pre_count;
    end
    
    //bit count --------------------------------------------------------------------------------------------------
    
    logic [3:0] bit_count;
    logic [3:0] pre_bit_count;
    
    always_ff@(posedge clk) begin
        if(reset) bit_count <= 0;
        else bit_count <= pre_bit_count;
    end
    
    // STATE MACHINE %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    localparam IDLE = 0;
    localparam SEND = 1;
    localparam WAITB = 2;
    
    logic [1:0] state;
    logic [1:0] next_state;
    
    always_ff@(posedge clk) begin
        if(reset) state<= IDLE;
        else state <= next_state;
    end
    
    always_comb begin
        next_state = state;
        pre_count = count;
        pre_bit_count = bit_count;
        pre_tx = tx;
        byte_end = 0;
        case(state)
            IDLE: begin
                pre_tx = 1;
                if(send_pulse == 1) begin
                    pre_bit_count = 0;
                    pre_count = 0;
                    next_state = SEND;
                end
            end
            
            SEND: begin
                pre_count = count + 1;
                if(count == 31) begin
                    pre_bit_count = bit_count + 1;
                    pre_count = 0;
                end
                case(bit_count)
                    0: begin
                        pre_tx = 0;
                    end
                    1: begin
                        pre_tx = byte_in[0];
                    end
                    2: begin
                        pre_tx = byte_in[1];
                    end
                    3: begin
                        pre_tx = byte_in[2];
                    end
                    4: begin
                        pre_tx = byte_in[3];
                    end
                    5: begin
                        pre_tx = byte_in[4];
                    end
                    6: begin
                        pre_tx = byte_in[5];
                    end
                    7: begin
                        pre_tx = byte_in[6];
                    end
                    8: begin
                        pre_tx = byte_in[7];
                    end
                    9: begin
                        pre_tx = 1;
                    end
                    10: begin
                        next_state = IDLE;
                        byte_end = 1;
                    end
                endcase
            end
        endcase
    end
endmodule
