/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : Adder.v                                                        *
 * Description : This file gives a general adder                                *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/6                                                      *
 ********************************************************************************/
 
module Adder #(parameter OPERAND_WIDTH = 32) (y, op1, op2);
    input  [OPERAND_WIDTH - 1 : 0] op1;
    input  [OPERAND_WIDTH - 1 : 0] op2;
    output [OPERAND_WIDTH - 1 : 0] y;

    assign y = op1 + op2;
endmodule