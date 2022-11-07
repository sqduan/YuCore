/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : RegisterFile_tb.v                                              *
 * Description : This file is the test branch of Register                       *
 * Test Steps                                                                   *
 *      Step 1 : Set input and output for DUT                                   *
 *      Step 2 : Create DUT with the io signals                                 *
 *      Step 3 : Initial signals, disable reset                                 *
 *                                                                              *
 *      [Part 1] Initialization Test                                            *
 *      Step 4 : Read all the registers, the values should all be zero          *
 *                                                                              *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/7                                                      *
 ********************************************************************************/
`timescale 1ns/10ps

module RegisterFile_tb;
    `include "../src/utils/Assert.vh"
    `include "../src/Parameters.vh"
    // Input stimulus
    reg clk;

    reg [4 : 0] srcRegister1;
    reg [4 : 0] srcRegister2;

    reg writeEnable;
    reg [4 : 0] desRegister;
    reg [DATA_WIDTH_32 - 1 : 0] writeData;

    // Outputs
    wire [DATA_WIDTH_32 - 1 : 0] readData1;
    wire [DATA_WIDTH_32 - 1 : 0] readData2;

    integer i;
    RegisterFile DUT (
        .readData1(readData1),
        .readData2(readData2),
        .clk(clk),
        .srcRegister1(srcRegister1),
        .srcRegister2(srcRegister2),
        .writeEnable(writeEnable),
        .desRegister(desRegister),
        .writeData(writeData));

    // Test initialization
    initial
    begin
        clk  <= 1;
        writeEnable <= 0;
    end

    // Part 1 : read the initial value of the register
    initial
    begin
        #4
        srcRegister1 = 32'h0;
        srcRegister2 = 32'h0;
        #2
        `Assert(readData1, 32'h0)
        `Assert(readData2, 32'h0)
    end

    // Clock drive
    always #5 clk = ~clk;
endmodule