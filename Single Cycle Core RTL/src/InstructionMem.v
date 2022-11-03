/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : InstructionMem.v                                               *
 * Description : This file describes the Instruction memory (ROM) of Yu         *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/2                                                      *
 ********************************************************************************/

module InstructionMem (addr, instruction);
    `include "Parameters.vh"
    input  [ADDR_WIDTH_32 - 1 : 0] addr;
    output [DATA_WIDTH_32 - 1 : 0] instruction;

    ROM #(.ROM_ADDR_WIDTH(ADDR_WIDTH_32),
          .ROM_DATA_WIDTH(DATA_WIDTH_32),
          .ROM_SIZE(INSTRUCTION_MEM_SIZE),
          .ROM_FILE_NAME(INSTRUCTION_FILE_NAME)
    ) instructionMem (
        .addr(addr),
        .data(instruction));

endmodule
    