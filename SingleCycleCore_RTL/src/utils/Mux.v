/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : Mux.v                                                          *
 * Description : This file gives general Muxes                                  *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/6                                                      *
 ********************************************************************************/
 
module Mux2 #(parameter OPERAND_WIDTH = 32) (out, select, a, b);
    input select;
    input [OPERAND_WIDTH - 1 : 0] a;
    input [OPERAND_WIDTH - 1 : 0] b;

    output reg [OPERAND_WIDTH - 1 : 0] out;

    always @ (*) out = (select == 0) ? a : b;
endmodule

module Mux4 #(parameter OPERAND_WIDTH = 32) (out, select, a, b, c, d);
    input [1 : 0] select;
    input [OPERAND_WIDTH - 1 : 0] a;
    input [OPERAND_WIDTH - 1 : 0] b;
    input [OPERAND_WIDTH - 1 : 0] c;
    input [OPERAND_WIDTH - 1 : 0] d;

    output reg [OPERAND_WIDTH - 1 : 0] out;

    always @ (*)
    begin
        case (select)
            2'b00 : out <= a;
            2'b01 : out <= b;
            2'b10 : out <= c;
            2'b11 : out <= d;
        endcase
    end
endmodule