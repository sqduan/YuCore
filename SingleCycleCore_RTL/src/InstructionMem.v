/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : InstructionMem.v                                               *
 * Description : Instruction memory for Yu                                      *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/2                                                      *
 ********************************************************************************/

module InstructionMem
    #(parameter INSTRUCTION_FILE_NAME = "default_instr_file")
    (instruction, address);
    `include "Parameters.vh"
    input  [XLEN - 1 : 0] address;
    output [XLEN - 1 : 0] instruction;

    ROM #(.ROM_ADDR_WIDTH(XLEN),
          .ROM_DATA_WIDTH(XLEN),
          .ROM_SIZE(INSTRUCTION_MEM_SIZE),
          .ROM_FILE_NAME(INSTRUCTION_FILE_NAME)
    ) instructionMem (
        .address(address),
        .data(instruction)
    );

endmodule