/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : InstructionDecoder.v                                           *
 * Description : An initial instruction decoder for Yu Core, this decoder will  *
 *               split the instruction and pass the instruction slice to Main & *
 *               ALU decoder and register file                                  *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/12/11                                                     *
 ********************************************************************************/

module InstructionDecoder (srcRegister1, srcRegister2, desRegister, funct3, funct7, opcode, imm, instruction);
    `include "Parameters.vh"
    input  [XLEN - 1 : 0] instruction;

    output reg [4 : 0] srcRegister1;
    output reg [4 : 0] srcRegister2;
    output reg [4 : 0] desRegister;

    output reg [6 : 0] opcode;
    output reg [2 : 0] funct3;
    output reg funct7;

    output reg [24 : 0]imm;

    always @ (instruction)
    begin
        opcode       <= instruction[6 : 0];
        funct3       <= instruction[14 : 12];
        funct7       <= instruction[30];
        srcRegister1 <= instruction[19 : 15];
        srcRegister2 <= instruction[24 : 20];
        desRegister  <= instruction[11 : 7];
        imm          <= instruction[XLEN - 1 : 7];
    end

endmodule
