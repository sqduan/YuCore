/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : Assert.vh                                                      *
 * Description : Define assert macro for testing and debuging                   *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/6                                                      *
 ********************************************************************************/
`ifndef _ASSERT_VH_
`define _ASSERT_VH_ 

`define Assert(signal, value) \
    if (signal !== value) begin \
        $display("[Yu Core] : ASSERTION FAILED in %m: signal != value"); \
        $finish; \
    end

`endif