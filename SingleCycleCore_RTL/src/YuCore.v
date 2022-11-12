/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : YuCore.v                                                       *
 * Description : This is YuCore, the top level file assemblies all the          *
 *               essential parts of Yu and make a useable RISC-V Core, enjoy.   *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/6                                                      *
 ********************************************************************************/

module RegisterFile ( PC, clk, rst, PCNext );
    `include "Parameters.vh"
    input  [DATA_WIDTH_32 - 1 : 0] PCNext;
    input  clk;
    input  rst;
    output [DATA_WIDTH_32 - 1 : 0] PC;

    Register #(.REGISTER_SIZE(DATA_WIDTH_32)) PCRegister (
        .q(PC),
        .clk(clk),
        .rst(rst),
        .d(PCNext));
endmodule
