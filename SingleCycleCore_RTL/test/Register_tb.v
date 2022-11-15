/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : Register_tb.v                                                  *
 * Description : This file is the test branch of Register                       *
 * Test Steps                                                                   *
 *      Step 1 : Set input and output for DUT                                   *
 *      Step 2 : Create DUT with the io signals                                 *
 *      Step 3 : Initial signals, disable reset                                 *
 *                                                                              *
 *      [Part 1] Basic Function Test                                            *
 *      Step 4 : Test basic function, in #1, give d a specific value,           *
 *               check in the next positive clk edge, q == d                    * 
 *                                                                              *
 *      Step 5 : Hold the value of d in next clk cycle, the q should remain     *
 *                                                                              *
 *      Step 6 : During the cycle above, change d when clk is high,             *
 *               and q will change in posedge                                   *
 *                                                                              *
 *      [Part 2] Reset Test                                                     *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/1                                                      *
 ********************************************************************************/
`timescale 1ns/10ps

module Register_tb;
    `include "../src/utils/Assert.vh"
    // Input stimulus
    reg clk;
    reg rst;
    parameter REGISTER_SIZE = 32;
    reg [REGISTER_SIZE - 1 : 0]d;

    wire [REGISTER_SIZE - 1 : 0]q;

    Register #(.REGISTER_SIZE(REGISTER_SIZE)) DUT (
        .q(q), 
        .clk(clk),
        .rst(rst),
        .d(d));

    // Test initialization
    initial
    begin
        clk  <= 0;
        rst  <= 1;
        d    <= 0;
    end

    // Part 1 : Basic function test
    initial #1   d   <= 32'hbabababa;
    initial #6   `ASSERT(q, 32'hbabababa)    // Step 4 : q == d

    initial #12  `ASSERT(q, 32'hbabababa)    // Step 5 : q doesn't change
    initial begin 
        #16
        d <= 32'hcacacaca;                    // Step 6 : change d when clk is high
        `ASSERT(q, 32'hbabababa)
    end

    initial #22 `ASSERT(q, 32'hbabababa)     // q doesn't change in neg edge
    initial #26 `ASSERT(q, 32'hcacacaca)     // q change in pos edge

    // Clock drive
    always #5 clk = ~clk;
endmodule