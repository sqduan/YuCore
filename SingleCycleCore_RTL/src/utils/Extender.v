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
 
module Extender (extendedImm, imm, immSrc);
    `include "../Parameters.vh"
    input [XLEN - 8 : 0] imm;             // [31..7] are the immediate number part of the instruction
    input [1 : 0] immSrc;                  // Immediate number's width vary from different instruction types

    output reg [XLEN - 1 : 0] extendedImm;  // Extended immediate number 

    always @ (*)
        case(immSrc)
            // I-type immediate, imm[31..20] is imm
            I_TYPE_IMM : extendedImm = {{20{imm[XLEN - 8]}}, imm[XLEN - 8 : 13]};
            S_TYPE_IMM : extendedImm = {{20{imm[XLEN - 8]}}, imm[XLEN - 8 : 18], imm[4 : 0]};
            default    : extendedImm = {XLEN{1'bx}};
        endcase
endmodule