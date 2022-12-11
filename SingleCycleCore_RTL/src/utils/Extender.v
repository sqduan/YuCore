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
 
module Extender (extendedImm, instruction, immType);
    `include "../Parameters.vh"
    input   [XLEN - 8 : 0] instruction;     // [31..7] are the immediate number
    input   [1: 0] immType;                 // Immediate number's width vary from different instruction types

    output reg [XLEN - 1 : 0] extendedImm;  // Extended immediate number 

    always @ (*)
        case(immType)
            // I-type immediate, instruction[31..20] is imm
            I_TYPE_IMM : extendedImm = {{20{instruction[XLEN - 8]}}, instruction[XLEN - 8 : 13]};
            default    : extendedImm = {XLEN{1'bx}};
        endcase
endmodule