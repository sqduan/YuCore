/********************************************************************************
 *                                                                              *
 *                         Yu Core - Single Cycle Version                       *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : Top_tb.v                                                       *
 * Description : This file is the test branch of the entire core                *
 * Test Steps                                                                   *
 *      Step 1 : Set input and output for DUT                                   *
 *      Step 2 : Create DUT with the io signals                                 *
 *      Step 3 : Initial signals                                                *
 *                                                                              *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2023/3/6                                                       *
 ********************************************************************************/
`timescale 1ns/10ps

module Top_tb;
    `include "../src/utils/Assert.vh"
    `include "../src/Parameters.vh"
    // Input stimulus
    parameter INSTRUCTION_FILE_NAME = "./test/datapath_tb1.ASM";
    reg  clk, rst;

    Top #(.INSTRUCTION_FILE_NAME(INSTRUCTION_FILE_NAME)) top (
        .clk(clk),
        .rst(rst)
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

    // Clock drive
    always #5 clk = ~clk;

endmodule