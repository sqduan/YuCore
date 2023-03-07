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
 *
 * TODO    : Generalization this module, replase magic number with pre-defined macros
 */
module DataPath
    (PC, ALUResult, writeData, zero,
     srcRegister1, srcRegister2, desRegister, imm, readData, clk, rst,
     PCSrc, regWrite, immSrc, ALUSrc, ALUControl, memWrite, resultSrc);
    `include "Parameters.vh"

    input clk;
    input rst;

    // IO between datapath and instruction/data memory
    input [XLEN - 1 : 0] readData;       // Read from data memory
    input [4 : 0] srcRegister1;
    input [4 : 0] srcRegister2;
    input [4 : 0] desRegister;
    input [24 : 0] imm;

    output [XLEN - 1 : 0] PC;            // To instruction memory
    output [XLEN - 1 : 0] ALUResult;     // To data memory as data address
    output [XLEN - 1 : 0] writeData;     // Data which is write to data memory
    output zero;                         // To control unit, is the ALU result zero?

    /* Control signals from the Control Unit */
    // Please refer to Control Unit of Yu Core for the meaning of these control signals
    input PCSrc;
    input regWrite;
    input [1 : 0] immSrc;
    input ALUSrc;
    input [2 : 0] ALUControl;
    input memWrite;
    input resultSrc;

    /* Signal wires between different modules */
    // Decoder to register file
    wire [6 : 0] opcode;
    wire [2 : 0] funct3;
    wire funct7;

    wire [XLEN - 1 : 0] result;        // result write to register file

    // Register file to ALU
    wire [XLEN - 1 : 0] srcA;          // srcRegister1's value, use as ALU oprand A
    wire [XLEN - 1 : 0] srcB;
    wire [XLEN - 1 : 0] readData2;     // srcRegister2's value, to be muxed with immediate number and used as oprand B
    wire [XLEN - 1 : 0] extendedImm;

    //----------------------------------------------------------------
    // Instruction Fetch Unit
    //----------------------------------------------------------------
    ProgramCounter pc (
        .PC(PC),
        .PCSrc(PCSrc),
        .imm(extendedImm),
        .clk(clk),
        .rst(rst)
    );

    //----------------------------------------------------------------
    // Register File Unit
    //----------------------------------------------------------------
    RegisterFile regFile (
        .readData1(srcA),
        .readData2(readData2),
        .clk(clk),
        .srcRegister1(srcRegister1),
        .srcRegister2(srcRegister2),
        .writeEnable(regWrite),
        .desRegister(desRegister),
        .writeData(result)
    );

    Extender extender (
        .extendedImm(extendedImm),
        .imm(imm),
        .immSrc(immSrc)
    );

    //----------------------------------------------------------------
    // Instruction Execute Unit
    //----------------------------------------------------------------

    // The mux to select input source of second operand of ALU,
    // from register file (a) or immediate extender (b)
    Mux2 ALUSrcMux (
        .out(srcB),
        .select(ALUSrc),
        .a(readData2),
        .b(extendedImm)
    );

    ALU alu (
        .result(ALUResult),
        .zero(zero),
        .A(srcA),
        .B(srcB),
        .control(ALUControl)
    );

    // The mux to select data which will be feedback to register file,
    // from ALU calculated result (a) or data memory (b)
    Mux2 resultMux (
        .out(result),
        .select(resultSrc),
        .a(ALUResult),
        .b(readData)
    );
    
endmodule
