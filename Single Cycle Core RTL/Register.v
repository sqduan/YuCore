/****************************************************************
 *                                                              *
 *                 Yu Core - Single Cycle Version               *
 *                                                              *
 *--------------------------------------------------------------*
 * File Name   : Register.v                                     *
 * Description : This file gives a definition of register       *
 * Author      : Shiqi Duan                                     *
 * Date        : 2022/11/1                                      *
 ****************************************************************/

module Register (q, clk, rst, d);
    
    // IO
    input clk;
    input rst;

    parameter N = 8;
    input  [N - 1 : 0] d;
    output [N - 1 : 0] q;
    reg    [N - 1 : 0] q;

    // Asynchronous reset logic
    reg rst1, rst2;
    always @ ( posedge clk or negedge rst ) begin
        if (!rst) begin
            rst1 <= 1'b0;
            rst2 <= 1'b0;
        end
        else begin
            rst1 <= 1'b1;
            rst2 <= rst1;
        end
    end

    assign rstSync = rst2;

    // Actual logic of the register
    always @ ( posedge clk or negedge rstSync ) begin
        if ( rstSync == 1'b0 )
            q <= 0;
        else
            q <= d;    
    end

endmodule