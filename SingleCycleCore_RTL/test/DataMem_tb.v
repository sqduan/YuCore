/********************************************************************************
 *                                                                              *
 *                         Yu Core - Single Cycle Version                       *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : DataMem_tb.v                                                   *
 * Description : This file is the test branch of instruction memory             *
 * Test Steps                                                                   *
 *      Step 1 : Set input and output for DUT                                   *
 *      Step 2 : Create DUT with the io signals                                 *
 *      Step 3 : Initial signals                                                *
 *                                                                              *
 *      [Part 1] Data Memory Write Test                                         *
 *      Step 4 : Write all the data memory cell with magic word                 *
 *                                                                              *
 *      [Part 2] Data Memory Read Test                                          *
 *      Step 5 : Read all the data memory cell, and compare with magic word     *
 *                                                                              *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/12/24                                                     *
 ********************************************************************************/
`timescale 1ns/10ps

module DataMem_tb;
    `include "../src/utils/Assert.vh"
    `include "../src/Parameters.vh"
    // Input stimulus
    reg clk;
    reg [XLEN - 1 : 0] address;
    reg [XLEN - 1 : 0] writeData;
    reg writeEnable;
    reg readEnable;  

    wire [XLEN - 1 : 0] readData;

    integer i;
    DataMem DUT (
        .readData(readData),
        .clk(clk),
        .address(address),
        .writeData(writeData),
        .writeEnable(writeEnable),
        .readEnable(readEnable)
    );

    // Test initialization
    initial
    begin
        clk <= 0;
        writeEnable <= 0;
        readEnable  <= 0;
    end

    initial
    begin
        // First write memory cell with magic words (i)
        for (i = 0; i < DATA_MEM_SIZE * 4; i = i + 4)
        begin
            if (i == 0) #4;
            else #10;
            address   <= i;
            writeData <= i;
            writeEnable <= 1;
            readEnable  <= 0;
        end
        #2;
        writeEnable <= 0;
        readEnable  <= 1;
        // Then try to read & compare
        for (i = 0; i < DATA_MEM_SIZE * 4; i = i + 4)
        begin
            #1;
            address <= i;
            #1
            `ASSERT(readData, i)
        end
        $stop;
    end

    // Clock drive
    always #5 clk = ~clk;

endmodule