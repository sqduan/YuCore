/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : ROM.v                                                          *
 * Description : A general ROM for Yu Core                                      *
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

    // The array of ROM, the layout of ROM is:
    // ----------------------------------------------------------
    // |  Addr     |  ROM cells                                 |
    // ----------------------------------------------------------
    // |  0x0      |  [  |  |  |...|  |  |  ] ROM[0]            |
    // |  0x1      |  [  |  |  |...|  |  |  ] ROM[1]            |
    // |  ...      |                                            |
    // |  ROM_SIZE |  [  |  |  |...|  |  |  ] ROM[ROM_SIZE - 1] |
    // ----------------------------------------------------------
    reg [ROM_DATA_WIDTH - 1 : 0] ROMArray [ROM_SIZE - 1 : 0];

    initial
        $readmemh(ROM_FILE_NAME, ROMArray);

    // with 4 bytes aligned
    assign data = ROMArray[addr[ROM_ADDR_WIDTH - 1 : 2]];

endmodule