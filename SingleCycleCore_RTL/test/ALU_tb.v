/********************************************************************************
 *                                                                              *
 *                         Yu Core - Single Cycle Version                       *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : ALU_tb.v                                                       *
 * Description : This file is the test branch of arithmetic logic unit (ALU)    *
 * Test Steps                                                                   *
 *      Step 1 : Set input and output for DUT                                   *
 *      Step 2 : Create DUT with the io signals                                 *
 *      Step 3 : Initial signals                                                *
 *                                                                              *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/3                                                      *
 ********************************************************************************/
`timescale 1ns/10ps

module ALU_tb;
    `include "../src/utils/Assert.vh"
    `include "../src/Parameters.vh"
    // Input stimulus
    reg  [XLEN - 1 : 0] A;
    reg  [XLEN - 1 : 0] B;
    reg  [2 : 0] control;

    // Output
    wire [XLEN - 1 : 0] result;

    ALU DUT (
        .result(result),
        .A(A),
        .B(B),
        .control(control)
    );
    
    initial
    begin
        // Group 1 : A = 0, B = -1
        #1
        $display("Test Group1\n");
        control <= ADD_OPCODE;
        A <= 32'h00000000;
        B <= 32'hFFFFFFFF;
        #1
        `ASSERT(result, 32'hFFFFFFFF)    // A + B

        #1
        control <= SUB_OPCODE;
        #1
        `ASSERT(result, 32'h00000001)    // A - B

        #1
        control <= AND_OPCODE;
        #1
        `ASSERT(result, 32'h00000000)    // A & B

        #1
        control <= OR_OPCODE;
        #1
        `ASSERT(result, 32'hFFFFFFFF)    // A | B

        $stop;
    end

endmodule