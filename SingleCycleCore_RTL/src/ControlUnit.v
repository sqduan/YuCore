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
 *
 * TODO    : Generalization this module, replase magic number with pre-defined macros
 */
module ControlUnit
    (PCSrc, resultSrc, memWrite, ALUControl, ALUSrc, immSrc, regWrite, opcode, funct3, funct7, zero);
    `include "Parameters.vh"

    input [6 : 0] opcode;       // Operation code of an instruction
    input [2 : 0] funct3;       // function 3 opcode
    input funct7;               // function 7 opcode, for RV32I, only bit 5 of funct7 is used
    input zero;                 // Zero flag for branch instructions

    output PCSrc;               // Source of next PC, +4 or jump
    output resultSrc;           // Source of result to write-back to register file, from ALU or data memory
    output memWrite;            // Write memory?
    output [2 : 0] ALUControl;  // ALU control code
    output ALUSrc;              // Source of ALU operand B, srcRegister2 or immediate number
    output [1 : 0] immSrc;      // Source of immediate number
    output regWrite;            // Write register file?

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
