/********************************************************************************
 *                                                                              *
 *                         Yu Core - Single Cycle Version                       *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : DataPath_tb.v                                                  *
 * Description : This file is the test branch of Yu Core's data path            *
 * Test Steps                                                                   *
 *      Step 1 : Set input and output for DUT                                   *
 *      Step 2 : Create DUT with the io signals                                 *
 *      Step 3 : Initial signals                                                *
 *                                                                              *
 *      [Part 1] I-type instruction test                                        *
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
    DataPath DUT (

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
        $stop;
    end

    // Clock drive
    always #5 clk = ~clk;

endmodule