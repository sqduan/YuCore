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

module ProgramCounter ( PC, clk, rst );
    `include "Parameters.vh"
    input  clk, rst;
    output [XLEN - 1 : 0] PC;

    reg  [XLEN - 1 : 0] PCNext;    // As the input of PCRegister, PCNext needs to hold the value
    wire [XLEN - 1 : 0] PCAdd4;

    // TODO: I still have a question, after reset, on the next clock edge, PC will become PC + 4
    // It seems that the first instruction will be executed during reset period, it's wired.
    Register #(.REGISTER_SIZE(XLEN)) PCRegister (
        .q(PC),
        .clk(clk),
        .rst(rst),
        .d(PCNext)
    );

    Adder #(.OPERAND_WIDTH(XLEN)) PCAdder (
        .op1(PC),
        .op2(32'h4),
        .y(PCAdd4)
    );

    // Currently just simply add PC with 4
    always@(PCAdd4)
    begin
        PCNext = PCAdd4;
    end 
endmodule
