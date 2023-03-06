/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : ProgramCounter.v                                               *
 * Description : This file describes the program counter of Yu, now this PC     *
 *               is simply a plus 4 counter, it will support more functions.    *
 * TODO        : Add jmp function to jump to target instruction                 *
 *               Reset can goto a given address                                 *
 *               Figure out how to delay a clock cycle after reset?             *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/1                                                      *
 ********************************************************************************/

module ProgramCounter (PC, PCSrc, imm, clk, rst);
    `include "Parameters.vh"
    input  clk, rst;              // Clock and reset signal
    input  PCSrc;                 // Source of PC, simply increase (0) or branch target address
    input  [XLEN - 1 : 0] imm;    // Branch offset by an immediate number

    output [XLEN - 1 : 0] PC;

    wire [XLEN - 1 : 0] PCNext;   // Next PC which will be stored in register
    wire [XLEN - 1 : 0] PCOffset; // Offset of next instruction from current PC

    // Source of the PC
    // 0: Sequential execution, next PC = PC + 4
    // 1: Branch, next PC = PC + imm
    Mux2 PCSelector (PCOffset, PCSrc, 32'h4, imm);

    // Calculate next PC from offset
    Adder #(.OPERAND_WIDTH(XLEN)) PCAdder (
        .op1(PC),
        .op2(PCOffset),
        .y(PCNext)
    );

    // TODO: I still have a question, after reset, on the next clock edge, PC will become PC + 4
    // It seems that the first instruction will be executed during reset period, it's wired.
    Register #(.REGISTER_SIZE(XLEN)) PCRegister (
        .q(PC),
        .clk(clk),
        .rst(rst),
        .d(PCNext)
    );

endmodule
