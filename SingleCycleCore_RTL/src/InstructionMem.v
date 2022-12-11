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

module InstructionMem (instruction, addr);
    `include "Parameters.vh"
    input  [XLEN - 1 : 0] addr;
    output [XLEN - 1 : 0] instruction;

    ROM #(.ROM_ADDR_WIDTH(XLEN),
          .ROM_DATA_WIDTH(XLEN),
          .ROM_SIZE(INSTRUCTION_MEM_SIZE),
          .ROM_FILE_NAME(INSTRUCTION_FILE_NAME)
    ) instructionMem (
        .addr(addr),
        .data(instruction)
    );

endmodule