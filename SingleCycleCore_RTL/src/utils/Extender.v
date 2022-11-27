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
    input   [XLEN - 1 : 0] instruction;     // [6..0] are opcodes we don't care
    input   [1: 0] immType;                 // Immediate number's width vary from different instruction types

    output reg [XLEN - 1 : 0] extendedImm;  // Extended immediate number 

    always @ (*)
        case(immType)
            // I-type immediate, instruction[31..20] is imm
            ITypeImm   : extendedImm = {{20{instruction[XLEN - 1]}}, instruction[XLEN - 1 : 20]};
            default    : extendedImm = {XLEN{1'bx}};
        endcase
endmodule