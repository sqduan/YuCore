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

module YuCore ( clk, rst );
    `include "Parameters.vh"
    
    input clk;
    input rst;

    // Instruction Fetch Unit
    ProgramCounter pc (
        .PC(PC),
        .clk(clk),
        .rst(rst)
    );
endmodule
