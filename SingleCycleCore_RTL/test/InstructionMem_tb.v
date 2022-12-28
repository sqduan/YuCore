/********************************************************************************
 *                                                                              *
 *                         Yu Core - Single Cycle Version                       *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : InstructionMem_tb.v                                            *
 * Description : This file is the test branch of instruction memory             *
 * Test Steps                                                                   *
 *      Step 1 : Set input and output for DUT                                   *
 *      Step 2 : Create DUT with the io signals                                 *
 *      Step 3 : Initial signals                                                *
 *                                                                              *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/3                                                      *
 ********************************************************************************/
`timescale 1ns/10ps

module InstructionMem_tb;
    `include "../src/Parameters.vh"
    // Input stimulus
    reg  [ADDR_WIDTH_32 - 1 : 0] address;
    wire [DATA_WIDTH_32 - 1 : 0] instruction;

    InstructionMem DUT (
        .address(address),
        .instruction(instruction)
    );
    
    initial
    begin
        $display("The test instruction file name is: %s",
            INSTRUCTION_FILE_NAME);
        address <= 0;
        #10
        address <= 4;
        #10
        address <= 8;
        #10
        address <= 4;
        #10
        address <= 11;
    end

endmodule