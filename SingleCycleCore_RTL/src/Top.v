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

    // Between datapath and data memory
    wire [XLEN - 1 : 0] dataAddr;
    wire [XLEN - 1 : 0] readData;
    wire [XLEN - 1 : 0] writeData;

    /* Module definitions */
    DataPath dataPath (
        .PC(PC),
        .ALUResult(dataAddr),
        .instruction(instruction)
    )

    InstructionMem #(.INSTRUCTION_FILE_NAME(INSTRUCTION_FILE_NAME)) iMem (
        .instruction(instruction),
        .address(PC)
    );

    DataMem dataMem (
        .readData(readData),
        .clk(clk),
        .address(ALUResult),
        .writeData(writeData),
        .writeEnable(TRUE),
        .readEnable(TRUE)
    );

endmodule
