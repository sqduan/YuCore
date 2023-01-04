/********************************************************************************
 *                                                                              *
 *                         Yu Core - Single Cycle Version                       *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : ALUDecoder_tb.v                                                *
 * Description : This file is the test branch of ALU decoder in control unit    *
 * Test Steps                                                                   *
 *      Step 1 : Set input and output for DUT                                   *
 *      Step 2 : Create DUT with the io signals                                 *
 *      Step 3 : Initial signals                                                *
 *                                                                              *
 *      Step 4 : Give different ALU opcodes, and check whether the ALU control  *
 *               is expected.                                                   *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2023/1/4                                                       *
 ********************************************************************************/
`timescale 1ns/10ps

module ALUDecoder_tb;
    `include "../src/utils/Assert.vh"
    `include "../src/Parameters.vh"
    // Input stimulus
    reg  [1 : 0] ALUOpcode;
    reg  [2 : 0] funct3;
    reg  funct7;
    reg  opcode5;

    // Output
    wire [2 : 0] ALUControl;

    ALUDecoder DUT (
        .ALUControl(ALUControl),
        .ALUOpcode(ALUOpcode),
        .funct3(funct3),
        .funct7(funct7),
        .opcode5(opcode5)
    );
    
    initial
    begin
        // Group 1 : ALU opcode = 00, ALU Control = 000
        $display("Test Group1\n");
        ALUOpcode <= 2'b00;
        funct3 <= 3'b111;
        funct7 <= 1'b1;
        opcode5 <= 1'b1;
        #1
        `ASSERT(ALUControl, 3'b000)

        #1
        funct3 <= 3'b000;
        funct7 <= 1'b0;
        opcode5 <= 1'b0;
        #1
        `ASSERT(ALUControl, 3'b000)

        // Group 2 : ALU opcode = 01, ALU Control = 001
        #1
        $display("Test Group2\n");
        ALUOpcode <= 2'b01;
        funct3 <= 3'b111;
        funct7 <= 1'b1;
        opcode5 <= 1'b1;
        #1
        `ASSERT(ALUControl, 3'b001)

        // Group 3 : ALU opcode = 10, funct3 = 000, {op5, funct7} != 11
        // ALU Control = 001
        #1
        $display("Test Group3\n");
        ALUOpcode <= 2'b10;
        funct3 <= 3'b000;
        funct7 <= 1'b0;
        opcode5 <= 1'b0;
        #1
        `ASSERT(ALUControl, 3'b000)

        #1
        ALUOpcode <= 2'b10;
        funct3 <= 3'b000;
        funct7 <= 1'b0;
        opcode5 <= 1'b1;
        #1
        `ASSERT(ALUControl, 3'b000)

        #1
        ALUOpcode <= 2'b10;
        funct3 <= 3'b000;
        funct7 <= 1'b1;
        opcode5 <= 1'b0;
        #1
        `ASSERT(ALUControl, 3'b000)

        #1
        ALUOpcode <= 2'b10;
        funct3 <= 3'b000;
        funct7 <= 1'b1;
        opcode5 <= 1'b1;
        #1
        `ASSERT(ALUControl, 3'b001)

        // Group 4 : ALU opcode = 10, funct3 = 010 ALU Control = 101
        #1
        ALUOpcode <= 2'b10;
        funct3 <= 3'b010;
        funct7 <= 1'b1;
        opcode5 <= 1'b1;
        #1
        `ASSERT(ALUControl, 3'b101)

        // Group 5 : ALU opcode = 10, funct3 = 110 ALU Control = 011
        #1
        ALUOpcode <= 2'b10;
        funct3 <= 3'b110;
        funct7 <= 1'b1;
        opcode5 <= 1'b1;
        #1
        `ASSERT(ALUControl, 3'b011)

        // Group 6 : ALU opcode = 10, funct3 = 111 ALU Control = 010
        #1
        ALUOpcode <= 2'b10;
        funct3 <= 3'b111;
        funct7 <= 1'b1;
        opcode5 <= 1'b1;
        #1
        `ASSERT(ALUControl, 3'b010)

        $stop;
    end

endmodule