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
 
module Mux2 (out, select, a, b);
    input select;
    input a;
    input b;

    output reg out;

    always @ (*) out = (select == 0) ? a : b;
endmodule

module Mux4 (out, select, a, b, c, d);
    input [1 : 0] select;
    input a;
    input b;
    input c;
    input d;

    output reg out;

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