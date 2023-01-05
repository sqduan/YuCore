/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : ControlUnit.v                                                  *
 * Description : The control unit of Yu Core                                    *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/12/28                                                     *
 ********************************************************************************/

/*
 * Module  : ControlUnit
 * Inputs  :
 *           opcode -- Operation code of an instruction
 *           f3     -- function 3 opcode
 *           f7     -- function 7 opcode, for RV32I, only bit 5 of funct7 is used
 *           zero   -- zero flag for branch instructions
 *
 * Outputs :
 *           PCSrc     -- Source of PC
 *           resultSrc -- Source of result to write-back to register file
 *
 * TODO    : Generalization this module, replase magic number with pre-defined macros
 */
module ControlUnit
    (PCSrc, resultSrc, memWrite, ALUControl, ALUSrc, immSrc, regWrite, opcode, funct3, funct7, zero);
    `include "Parameters.vh"

    input [6 : 0] opcode;
    input [2 : 0] funct3;
    input funct7;
    input zero;

    output PCSrc;
    output resultSrc;
    output memWrite;
    output [2 : 0] ALUControl;
    output ALUSrc;
    output [1 : 0] immSrc;
    output regWrite;

    wire branch;
    wire [1 : 0] ALUOpcode;
    MainDecoder mainDecoder (
        .branch(branch),
        .resultSrc(resultSrc),
        .memWrite(memWrite),
        .ALUSrc(ALUSrc),
        .immSrc(immSrc),
        .regWrite(regWrite),
        .ALUOpcode(ALUOpcode),
        .opcode(opcode)
    );

    ALUDecoder aluDecoder (
        .ALUControl(ALUControl),
        .ALUOpcode(ALUOpcode),
        .funct3(funct3),
        .funct7(funct7),
        .opcode5(opcode[5])
    );

    assign PCSrc = zero & branch;
endmodule
