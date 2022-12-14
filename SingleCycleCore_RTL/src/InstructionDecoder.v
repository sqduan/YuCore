/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : InstructionDecoder.v                                           *
 * Description : Instruction decoder for Yu Core, this decoder do a initial     *
 *               decode operation                                               *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/12/11                                                     *
 ********************************************************************************/

module InstructionDecoder (srcRegister1, srcRegister2, desRegister, f3, opcode, imm, instruction);
    `include "Parameters.vh"
    input  [XLEN - 1 : 0] instruction;

    output reg [4 : 0] srcRegister1;
    output reg [4 : 0] srcRegister2;
    output reg [4 : 0] desRegister;

    output reg [6 : 0] opcode;
    output reg [2 : 0] f3;

    output reg [24 : 0]imm;

    always @ (instruction)
    begin
        opcode       <= instruction[6 : 0];
        f3           <= instruction[14 : 12];
        srcRegister1 <= instruction[19 : 15];
        srcRegister2 <= instruction[24 : 20];
        desRegister  <= instruction[11 : 7];
        imm          <= instruction[XLEN - 1 : 7];
    end

endmodule
