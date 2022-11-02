/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : PC.v                                                           *
 * Description : This file describes the program counter of Yu                  *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/1                                                      *
 *******************************************************************************/

module PC ( PC, clk, rst, PCNext );
    `include "Parameters.vh"
    input  [ADDR_WIDTH_32 - 1 : 0]PCNext;
    input  clk;
    input  rst;
    output [ADDR_WIDTH_32 - 1 : 0]PC;

    Register #(ADDR_WIDTH_32) PCRegister (PC, clk, rst, PCNext);
endmodule
