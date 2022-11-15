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

    initial
    begin
        // Part 1 : Read the initial value of the register
        // This part reads the initial value of register file from x0 to x32 as the src register
        for (i = 0 ; i < REGISTER_NUM; i = i + 1)
        begin
            if (i == 0)
                #4;
            else
                #8;
            srcRegister1 <= i;            // src is x[i]
            srcRegister2 <= i;
            #2
            `ASSERT(readData1, 32'h0)
            `ASSERT(readData2, 32'h0)
        end

        // Part 2 : Write some raw data into des register, then read them at 1ns after the neg edge
        // Check if write data equals read data (except for the x0 register which is always zero)
        for (i = 0 ; i < REGISTER_NUM; i = i + 1)
        begin
            #3
            desRegister <= i;            // des is x[i]
            srcRegister1 <= i;           // src is x[i]
            srcRegister2 <= i;
            writeEnable <= 1;
            writeData <= i + 1;
            #2
            writeEnable <= 0;
            #5
            if (i == 0) begin
                `ASSERT(readData1, 32'h0)
                `ASSERT(readData2, 32'h0)
            end else begin
                `ASSERT(readData1, i + 1)
                `ASSERT(readData2, i + 1)
                
            end

        end
        $stop;
    end

    // Clock drive
    always #5 clk = ~clk;
endmodule