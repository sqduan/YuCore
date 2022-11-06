/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : RegisterFile.v                                                 *
 * Description : This file describes the register file of Yu                    *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/6                                                      *
 ********************************************************************************/

module RegisterFile ( rd1, rd2, clk, a1, a2, a3);
    input clk, a1, a2, a3;
    output reg rd1, rd2;
endmodule
