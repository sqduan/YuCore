/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : PC_IMem_tb.v                                                   *
 * Description : This file is the test branch which test the conbination logic  *
 *               between PC and Instruction Mem                                 *
 * Test Steps                                                                   *
 *      Step 1 : Set input and output for DUT                                   *
 *      Step 2 : Create DUT with the io signals                                 *
 *      Step 3 : Initial signals, hold reset                                    *
 *                                                                              *
 *      Step 4 : Release, the PC start counting, and instruction memory will    *
 *               give instruction according to the PC address                   *
 *                                                                              *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/1                                                      *
 ********************************************************************************/
`timescale 1ns/10ps

module PC_IMem_tb;
    `include "../src/utils/Assert.vh"
    `include "../src/Parameters.vh"
    parameter REGISTER_SIZE = 32;
    // Input stimulus
    reg  clk, rst;

    // Output
    wire [REGISTER_SIZE - 1 : 0]  PC;
    wire [DATA_WIDTH_32 - 1 : 0]  instruction;

    ProgramCounter PC_DUT (
        .PC(PC),
        .clk(clk),
        .rst(rst)
    );

    InstructionMem IMem_DUT (
        .address(PC),
        .instruction(instruction)
    );
    // Test initialization
    initial
    begin
        #0
        clk = 0;
        rst = 0;

        // release
        #10
        rst = 1;
    end

    initial
    begin
         #20
        `ASSERT(PC, 32'h00000000)
        `ASSERT(instruction, 32'h00500113)
    end

    initial
    begin
         #30
        `ASSERT(PC, 32'h00000004)
        `ASSERT(instruction, 32'h00c00193)
    end

    initial
    begin
        #60
        `ASSERT(PC, 32'h00000010)
        `ASSERT(instruction, 32'h0041F2B3)
    end

    // Clock drive
    always #5 clk = ~clk;
endmodule