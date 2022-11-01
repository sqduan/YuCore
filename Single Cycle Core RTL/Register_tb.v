/****************************************************************
 *                                                              *
 *                 Yu Core - Single Cycle Version               *
 *                                                              *
 *--------------------------------------------------------------*
 * File Name   : Register_tb.v                                  *
 * Description : This file is the test branch of Register       *
 * Test Steps                                                   *
 *      Step 1 : Set input and output for DUT                   *
 *      Step 2 : Create DUT with the io signals                 *
 *      Step 3 : Initial signals                                *
 *
 * Author      : Shiqi Duan                                     *
 * Date        : 2022/11/1                                      *
 ****************************************************************/

`timescale 1ns/10ps

module Register_tb;

    // Input stimulus
    reg clkIn;
    reg rstIn;
    parameter REG_WIDTH = 8;
    reg [REG_WIDTH - 1 : 0]dIn;

    wire [REG_WIDTH - 1 : 0]qOut;

    Register DUT (.q(qOut), 
                  .clk(clkIn),
                  .rst(rstIn),
                  .d(dIn));
    initial
    begin
        clkIn <= 0;
        rstIn <= 1;
        dIn   <= 0;
        #1
        rstIn <= 0;
        dIn   <= 1;
        #20
        rstIn <= 1;
        #10
        dIn   <= 8'h10;
        #60
        rstIn <= 0;
    end

    always #10 clkIn = ~clkIn;
endmodule