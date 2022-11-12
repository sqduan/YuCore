/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : ProgramCounter.v                                               *
 * Description : This file is the test branch of the program counter            *
 * Test Steps                                                                   *
 *      Step 1 : Set input and output for DUT                                   *
 *      Step 2 : Create DUT with the io signals                                 *
 *      Step 3 : Initial signals                                                *
 *                                                                              *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/6                                                      *
 ********************************************************************************/
`timescale 1ns/10ps

module ProgramCounter_tb;
    `include "../src/Parameters.vh"
    // Input stimulus
    reg  clk, rst;
    wire [DATA_WIDTH_32 - 1 : 0] PC;

    ProgramCounter DUT (
        .PC(PC),
        .clk(clk),
        .rst(rst)
    );

    initial
    begin
        clk <= 0;
        rst <= 0;
    end

    initial
    begin
        #10
        rst <= 1;
    end

    always #5 clk = ~clk;

endmodule