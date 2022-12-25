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
        // Currently our memory cell is 4Bytes, in next generation of Yu,
        // I will support 1Byte memory cell and flexible length types
        if (writeEnable) RAMArray[address[RAM_ADDR_WIDTH - 1 : 2]] <= writeData;
    end

    // The Ram can get output at any time
    always @ (*)
    begin
        tempData = RAMArray[address[RAM_ADDR_WIDTH - 1 : 2]];
    end
    assign readData = (readEnable & !writeEnable) ? tempData : 'hz;
endmodule