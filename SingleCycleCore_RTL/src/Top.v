/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : Top.v                                                          *
 * Description : This is the top file which combines Yu Core with external      *
 *               memories and assemblies a whole machine                        *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/6                                                      *
 ********************************************************************************/

module Top
    #(parameter INSTRUCTION_FILE_NAME = "default_instr_file")
    (clk, rst);
    `include "Parameters.vh"
    
    input clk;
    input rst;

    /* Signal wires between different modules */
    // Between datapath and instruction memory
    wire [XLEN - 1 : 0] PC;
    wire [XLEN - 1 : 0] instruction;

    // Between instruction decoder to datapath and control unit
    wire [6 : 0] opcode;
    wire [2 : 0] funct3;
    wire funct7;

    wire [4 : 0] srcRegister1;
    wire [4 : 0] srcRegister2;
    wire [4 : 0] desRegister;

    wire [24 : 0]imm;

    // Between control unit and datapath
    wire PCSrc;
    wire resultSrc;
    wire memWrite;
    wire [2 : 0] ALUControl;
    wire ALUSrc;
    wire [1 : 0] immSrc;
    wire regWrite;

    // Between datapath and data memory
    wire [XLEN - 1 : 0] ALUResult;
    wire [XLEN - 1 : 0] readData;
    wire [XLEN - 1 : 0] writeData;

    /* Module definitions */
    //----------------------------------------------------------------
    // Instruction Memory
    //----------------------------------------------------------------
    InstructionMem #(.INSTRUCTION_FILE_NAME(INSTRUCTION_FILE_NAME)) iMem (
        .instruction(instruction),
        .address(PC)
    );

    //----------------------------------------------------------------
    // Instruction Decode Unit
    //----------------------------------------------------------------
    // The instruction decoder gets instruction from instruction 
    // memory and decode it, then pass instruction segments to data
    // path & control path
    //----------------------------------------------------------------
    InstructionDecoder instDecoder (
        .instruction(instruction),

        // To control unit
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),

        // To register file
        .srcRegister1(srcRegister1),
        .srcRegister2(srcRegister2),
        .desRegister(desRegister),

        .imm(imm)
    );

    //----------------------------------------------------------------
    // Control Unit
    //----------------------------------------------------------------
    ControlUnit controlUnit (
        // Control signals to datapath
        .PCSrc(PCSrc),
        .resultSrc(resultSrc),
        .memWrite(memWrite),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .immSrc(immSrc),
        .regWrite(regWrite),

        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .zero(zero)
    );

    //----------------------------------------------------------------
    // Data Path
    //----------------------------------------------------------------
    DataPath dataPath (
        .PC(PC),
        .ALUResult(ALUResult),
        .writeData(writeData),

        .srcRegister1(srcRegister1),
        .srcRegister2(srcRegister2),
        .desRegister(desRegister),
        .readData(readData),
        .imm(imm),

        .clk(clk),
        .rst(rst),

        .PCSrc(PCSrc),
        .regWrite(regWrite),
        .immSrc(immSrc),
        .ALUSrc(ALUSrc),
        .ALUControl(ALUControl),
        .memWrite(memWrite),
        .resultSrc(resultSrc)
    );

    //----------------------------------------------------------------
    // Data Memory
    //----------------------------------------------------------------
    DataMem dataMem (
        .readData(readData),
        .clk(clk),
        .address(ALUResult),
        .writeData(writeData),
        .writeEnable(memWrite),
        .readEnable(1'b1)
    );

endmodule
