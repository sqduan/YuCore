/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : Decoder.v                                                      *
 * Description : decoder for Yu Core                                            *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/12/11                                                     *
 ********************************************************************************/

module Decoder (srcRegister1, srcRegister2, desRegister, f3, opcode, imm, instruction);
    `include "Parameters.vh"
    input  [XLEN - 1 : 0] instruction;

    output [4 : 0] srcRegister1;
    output [4 : 0] srcRegister2;
    output [4 : 0] desRegister;

    output [6 : 0] opcode;
    output [2 : 0] f3;

    output [24 : 0] imm;

    always @ (instruction)
        opcode       <= instruction[6 : 0];
        f3           <= instruction[14 : 12];
        srcRegister1 <= instruction[19 : 15];
        srcRegister2 <= instruction[24 : 20];
        desRegister  <= instruction[11 : 7];
        imm          <= instruction[XLEN - 1 : 7];

endmodule
