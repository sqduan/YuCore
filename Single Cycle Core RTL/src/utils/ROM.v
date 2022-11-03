/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : ROM.v                                                          *
 * Description : This file gives a definition of ROM                            *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/2                                                      *
 ********************************************************************************/

module ROM
    #(parameter ROM_ADDR_WIDTH = 32,
      parameter ROM_DATA_WIDTH = 32,
      parameter ROM_SIZE       = 64,
      parameter ROM_FILE_NAME  = "default_rom_file"
    ) (addr, data);

    input  [ROM_ADDR_WIDTH - 1 : 0] addr;
    output [ROM_DATA_WIDTH - 1 : 0] data;

    reg [ROM_DATA_WIDTH - 1 : 0]  ROMArray[ROM_SIZE - 1 : 0];

    initial
        $readmemh(ROM_FILE_NAME, ROMArray);

    assign data = ROMArray[addr[ROM_ADDR_WIDTH - 1 : 2]];

endmodule