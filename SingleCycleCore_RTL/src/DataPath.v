/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : DataPath.v                                                     *
 * Description : The data path of Yu Core                                       *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/12/11                                                     *
 ********************************************************************************/

/*
 * Module  : DataPath
 * Inputs  :
 *           clk -- Clock signal
 *           rst -- Reset signal
 *
 * Outputs : 
 *
 * TODO    : Generalization this module, replase magic number with pre-defined macros
 */
module DataPath
    (PC, ALUResult, writeData, srcRegister1, srcRegister2, desRegister, readData, clk, rst);
    `include "Parameters.vh"

    input clk;
    input rst;

    // IO between datapath and instruction/data memory
    input [XLEN - 1 : 0] readData;       // Read from data memory
    input [4 : 0] srcRegister1;
    input [4 : 0] srcRegister2;
    input [4 : 0] desRegister;

    output [XLEN - 1 : 0] PC;            // To instruction memory
    output [XLEN - 1 : 0] ALUResult;     // To data memory as data address
    output [XLEN - 1 : 0] writeData;     // Data write to data memory

    /* Signal wires between different modules */
    // Decoder to register file & extender
    

    wire [6 : 0] opcode;
    wire [2 : 0] f3;

    wire [24 : 0] imm;

    // Register file to ALU
    wire [XLEN - 1 : 0] A;
    wire [XLEN - 1 : 0] B;
    wire [XLEN - 1 : 0] extendedImm;

    //----------------------------------------------------------------
    // Instruction Fetch Unit
    //----------------------------------------------------------------
    ProgramCounter pc (
        .PC(PC),
        .clk(clk),
        .rst(rst)
    );

    //----------------------------------------------------------------
    // Instruction Decode Unit
    //----------------------------------------------------------------
    InstructionDecoder decoder (
        .srcRegister1(srcRegister1),
        .srcRegister2(srcRegister2),
        .desRegister(desRegister),
        .funct3(funct3),
        .opcode(opcode),
        .imm(imm),
        .instruction(instruction)
    );

    RegisterFile regFile (
        .readData1(A),
        .readData2(B),
        .clk(clk),
        .srcRegister1(srcRegister1),
        .srcRegister2(srcRegister2),
        .writeEnable(TRUE),
        .desRegister(desRegister),
        .writeData(readData)
    );

    Extender extender (
        .extendedImm(extendedImm),
        .imm(imm),
        .opcode(opcode)
    );

    //----------------------------------------------------------------
    // Instruction Execute Unit
    //----------------------------------------------------------------
    ALU alu (
        .result(ALUResult),
        .A(A),
        .B(extendedImm),
        .control(3'b000)
    );
    
endmodule
