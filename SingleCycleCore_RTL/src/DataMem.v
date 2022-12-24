/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : DataMem.v                                                      *
 * Description : Data memory for Yu Core                                        *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/2                                                      *
 ********************************************************************************/

module DataMem (readData, clk, address, writeData, writeEnable, readEnable);
    `include "Parameters.vh"
    input clk;
    input [XLEN - 1 : 0] address;
    input [XLEN - 1 : 0] writeData;
    input writeEnable;
    input readEnable;

    output [XLEN - 1 : 0] readData;

    RAM #(.RAM_ADDR_WIDTH(XLEN),
          .RAM_DATA_WIDTH(XLEN),
          .RAM_SIZE(DATA_MEM_SIZE)
    ) dataMem (
        .readData(readData),
        .clk(clk),
        .address(address),
        .writeData(writeData),
        .writeEnable(writeEnable),
        .readEnable(readEnable)
    );

endmodule