/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : Memory.v                                                       *
 * Description : This file gives a definition of memory                         *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/2                                                      *
 ********************************************************************************/

module Memory
    #(parameter DEFAULT_MEMORY_ADDR_WIDTH = 32,
      parameter DEFAULT_MEMORY_DATA_WIDTH = 32
    )
    (addr, data);
    
    input  [DEFAULT_MEMORY_ADDR_WIDTH - 1 : 0] addr;
    output [DEFAULT_MEMORY_DATA_WIDTH - 1 : 0] data;

endmodule