/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : RAM.v                                                          *
 * Description : A general RAM for Yu Core                                      *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/2                                                      *
 ********************************************************************************/

module RAM
    #(parameter RAM_ADDR_WIDTH = 32,
      parameter RAM_DATA_WIDTH = 32,
      parameter RAM_SIZE       = 1024
    ) (readData, clk, address, writeData, writeEnable, readEnable);

    input  clk;
    input  [RAM_ADDR_WIDTH - 1 : 0] address;
    input  [RAM_DATA_WIDTH - 1 : 0] writeData;
    input  writeEnable;
    input  readEnable;

    output [RAM_DATA_WIDTH - 1 : 0] readData;

    reg [RAM_DATA_WIDTH - 1 : 0] tempData;
    reg [RAM_DATA_WIDTH - 1 : 0] RAMArray [RAM_SIZE - 1 : 0];

    always @ (posedge clk)
    begin
        if (writeEnable) RAMArray[address] <= writeData;
        else tempData <= RAMArray[address];
    end

    assign readData = (readEnable & !writeEnable) ? tempData : 'hz;
endmodule