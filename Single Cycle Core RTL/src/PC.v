/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : PC.v                                                           *
 * Description : This file describes the program counter of Yu                  *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/1                                                      *
 ********************************************************************************/

module PC ( PC, clk, rst, PCNext );
    `include "Parameters.vh"
    input  [Parameters.g_dataWidth - 1 : 0]PCNext;
    input  clk;
    input  rst;
    output [Parameters.g_dataWidth - 1 : 0]PC;

    Register #(.REGISTER_SIZE(Parameters.g_dataWidth)) PCRegister (
        .q(PC),
        .clk(clk),
        .rst(rst),
        .d(PCNext));
endmodule
