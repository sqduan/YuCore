/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : YuCore.v                                                       *
 * Description : This is YuCore, the top level file assemblies all the          *
 *               essential parts of Yu and make a useable RISC-V Core, enjoy.   *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/6                                                      *
 ********************************************************************************/

module YuCore (clk, rst);
    `include "Parameters.vh"
    
    input clk;
    input rst;

    wire [XLEN - 1 : 0] PC;
    wire [XLEN - 1 : 0] instruction;
    wire [4 : 0] srcRegister1;
    wire [4 : 0] srcRegister2;
    wire [4 : 0] desRegister;

    // Instruction Fetch Unit
    ProgramCounter pc (
        .PC(PC),
        .clk(clk),
        .rst(rst)
    );

    InstructionMem iMem (
        .instruction(instruction),
        .address(PC)
    );

    // Instruction Decode Unit
    wire [XLEN - 1 : 0] A;
    wire [XLEN - 1 : 0] B;
    RegisterFile regFile (
        .readData1(A),
        .readData2(B),
        .clk(clk),
        .srcRegister1(srcRegister1),
        .srcRegister2(srcRegister2),
        .writeEnable(0),
        .desRegister(desRegister),
        .writeData(0)
    );

    // Instruction Execute Unit
    wire [XLEN - 1 : 0] ALUResult;
    ALU alu (
        .result(ALUResult),
        .A(A),
        .B(B),
        .control(ALUControl)
    );
endmodule
