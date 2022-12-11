/********************************************************************************
 *                                                                              *
 *                         Yu Core - Single Cycle Version                       *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : Extender_tb.v                                                  *
 * Description : This file is the test branch of immediate extender             *
 * Test Steps                                                                   *
 *      Step 1 : Set input and output for DUT                                   *
 *      Step 2 : Create DUT with the io signals                                 *
 *      Step 3 : Initial signals                                                *
 *                                                                              *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/3                                                      *
 ********************************************************************************/
`timescale 1ns/10ps

module Extender_tb;
    `include "../src/utils/Assert.vh"
    `include "../src/Parameters.vh"
    // Input stimulus
    reg  [XLEN - 1 : 0] instruction;
    reg  [1 : 0] immType;

    // Output
    wire [XLEN - 1 : 0] extendedImm;

    Extender DUT (
        .extendedImm(extendedImm),
        .instruction(instruction[XLEN - 1 : 7]),
        .immType(immType));
    
    initial
    begin
        // Part 1 : Test I-type immediate expender, expend 11 bits to XLEN bits
        #1
        $display("Test the I-type immediate expender\n");
        immType <= I_TYPE_IMM;
        instruction <= 32'b0000_0000_0000_01001_010_00110_0000011;
        #1
        `ASSERT(extendedImm, 32'h00000000)

        #1
        immType <= I_TYPE_IMM;
        instruction <= 32'b1010_0101_0100_10011_010_00110_0000011;
        #1
        `ASSERT(extendedImm, 32'hFFFFFA54)

        #1
        immType <= I_TYPE_IMM;
        instruction <= 32'b1111_1111_1111_01001_010_00110_0000011;
        #1
        `ASSERT(extendedImm, 32'hFFFFFFFF)

        $stop;
    end

endmodule