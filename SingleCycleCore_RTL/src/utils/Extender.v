/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : Extender.v                                                     *
 * Description : This file gives a general adder                                *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/6                                                      *
 ********************************************************************************/
 
module Extender #(parameter EXTENDED_WIDTH = 32) (extendedImm, instruction, immType);
    input   [EXTENDED_WIDTH - 1 : 7] instruction;     // [6..0] are opcodes we don't care
    input   [1: 0] immType;                           // Immediate number's width vary from different instruction types

    output reg [EXTENDED_WIDTH - 1 : 0] extendedImm;  // Extended immediate number 

    always @ (*)
        case(immType)
            2'b00   : extendedImm = {{20{instruction[EXTENDED_WIDTH - 1]}}, instruction[EXTENDED_WIDTH - 1 : 20]};
            default : extendedImm = {EXTENDED_WIDTH{1'bx}};
        endcase
endmodule