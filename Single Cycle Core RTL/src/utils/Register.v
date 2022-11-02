/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : Register.v                                                     *
 * Description : This file gives a definition of synchronous register           *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/1                                                      *
 ********************************************************************************/

module Register (q, clk, rst, d);
    
    // IO
    input clk;
    input rst;

    parameter N = 8;
    input  [N - 1 : 0] d;
    output [N - 1 : 0] q;
    reg    [N - 1 : 0] q;

    // Synchronous reset logic
    always @ ( posedge clk or negedge rst ) begin
        if (!rst) 
            q <= 0;
        else
            q <= d;
    end

endmodule