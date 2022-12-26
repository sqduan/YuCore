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
    #(parameter INSTRUCTION_FILE_NAME = "default_instr_file")
    (clk, rst);
    `include "Parameters.vh"

    input clk;
    input rst;

    /* Signal wires between different modules */
    // Program counter to instruction memory
    wire [XLEN - 1 : 0] PC;

    // Instruction memory to decoder
    wire [XLEN - 1 : 0] instruction;

    // Decoder to register file & extender
    wire [4 : 0] srcRegister1 = instruction[19 : 15];
    wire [4 : 0] srcRegister2 = instruction[24 : 20];
    wire [4 : 0] desRegister  = instruction[11 : 7];

    wire [6 : 0] opcode;
    wire [2 : 0] f3;

    wire [24 : 0] imm;

    // Register file to ALU
    wire [XLEN - 1 : 0] A;
    wire [XLEN - 1 : 0] B;
    wire [XLEN - 1 : 0] extendedImm;

    // ALU to data memory
    wire [XLEN - 1 : 0] ALUResult;

    // Data memory to Register file
    wire [XLEN - 1 : 0] readData;

    //----------------------------------------------------------------
    // Instruction Fetch Unit
    //----------------------------------------------------------------
    ProgramCounter pc (
        .PC(PC),
        .clk(clk),
        .rst(rst)
    );

    InstructionMem #(.INSTRUCTION_FILE_NAME(INSTRUCTION_FILE_NAME)) iMem (
        .instruction(instruction),
        .address(PC)
    );

    //----------------------------------------------------------------
    // Instruction Decode Unit
    //----------------------------------------------------------------
    Decoder decoder (
        .srcRegister1(srcRegister1),
        .srcRegister2(srcRegister2),
        .desRegister(desRegister),
        .f3(f3),
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

    //----------------------------------------------------------------
    // Instruction Memory Unit
    //----------------------------------------------------------------
    DataMem dataMem (
        .readData(readData),
        .clk(clk),
        .address(ALUResult),
        .writeData(0),
        .writeEnable(FALSE),
        .readEnable(TRUE)
    );
endmodule
