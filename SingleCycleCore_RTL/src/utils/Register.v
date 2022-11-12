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

module Register 
    #(parameter REGISTER_SIZE = 8)
    (q, clk, rst, d);
    
    // IO
    input clk;
    input rst;

    input      [REGISTER_SIZE - 1 : 0] d;
    output reg [REGISTER_SIZE - 1 : 0] q;

    reg lastRst;
    initial lastRst = 1;

    // Synchronous reset logic
    always @ ( posedge clk ) begin
        if (!rst)
        begin
            q <= 0;
            lastRst <= 0;
        end
        else if (!lastRst)    // Let the register hold the reset value for one more cycle
        begin
            q <= 0;
            lastRst <= 1;
        end
        else
            q <= d;
    end

endmodule