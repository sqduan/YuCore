/********************************************************************************
 *                                                                              *
 *                         Yu Core - Single Cycle Version                       *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : ControlUnit_tb.v                                               *
 * Description : This file is the test branch of control unit                   *
 * Test Steps                                                                   *
 *      Step 1 : Set input and output for DUT                                   *
 *      Step 2 : Create DUT with the io signals                                 *
 *      Step 3 : Initial signals                                                *
 *                                                                              *
 *      Step 4 : Give different opcodes, and check whether the control signals  *
 *               are expected.                                                  *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2023/1/5                                                       *
 ********************************************************************************/
`timescale 1ns/10ps

module ControlUnit_tb;
    `include "../src/utils/Assert.vh"
    `include "../src/Parameters.vh"
    // Input stimulus
    reg [6 : 0] opcode;
    reg [2 : 0] funct3;
    reg funct7;
    reg zero;

    // Output
    wire PCSrc;
    wire resultSrc;
    wire memWrite;
    wire [2 : 0] ALUControl;
    wire ALUSrc;
    wire [1 : 0] immSrc;
    wire regWrite;

    ControlUnit DUT (
        .PCSrc(PCSrc),
        .resultSrc(resultSrc),
        .memWrite(memWrite),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .immSrc(immSrc),
        .regWrite(regWrite),
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .zero(zero)
    );
    
    initial
    begin
        // Group 1 : opcode = 11
        $display("Test Group1\n");
        zero <= 1'b0;
        opcode <= 7'b0000011;
        funct3 <= 3'b111;
        funct7 <= 1'b1;
        #1
        `ASSERT(regWrite, 1'b1)
        `ASSERT(immSrc,   2'b00)
        `ASSERT(ALUSrc,   1'b1)
        `ASSERT(memWrite, 1'b0)
        `ASSERT(resultSrc, 1'b1)
        `ASSERT(PCSrc, 1'b0)

        // Group 2 : opcode = 0100011
        #1
        $display("Test Group2\n");
        zero <= 1'b1;
        opcode <= 7'b0100011;
        funct3 <= 3'b111;
        funct7 <= 1'b1;
        #1
        `ASSERT(regWrite, 1'b0)
        `ASSERT(immSrc,   2'b01)
        `ASSERT(ALUSrc,   1'b1)
        `ASSERT(memWrite, 1'b1)
        `ASSERT(resultSrc, 1'bx)
        `ASSERT(PCSrc, 1'b0)

        // Group 3 : opcode = 0110011
        #1
        $display("Test Group3\n");
        zero <= 1'b1;
        opcode <= 7'b0110011;
        funct3 <= 3'b111;
        funct7 <= 1'b1;
        #1
        `ASSERT(regWrite, 1'b1)
        `ASSERT(immSrc,   2'bxx)
        `ASSERT(ALUSrc,   1'b0)
        `ASSERT(memWrite, 1'b0)
        `ASSERT(resultSrc, 1'b0)
        `ASSERT(PCSrc, 1'b0)

        // Group 4 : opcode = 1100011
        #1
        $display("Test Group4\n");
        zero <= 1'b1;
        opcode <= 7'b1100011;
        funct3 <= 3'b111;
        funct7 <= 1'b1;
        #1
        `ASSERT(regWrite, 1'b0)
        `ASSERT(immSrc,   2'b10)
        `ASSERT(ALUSrc,   1'b0)
        `ASSERT(memWrite, 1'b0)
        `ASSERT(resultSrc, 1'bx)
        `ASSERT(PCSrc, 1'b1)
        $stop;
    end

endmodule