/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : ALU.v                                                          *
 * Description : This file describes the Arithmetic Logic Unit (ALU) for Yu.    *
 *               Currently Yu support the following arithmetic operations:      *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/1                                                      *
 ********************************************************************************/

module ALU (result, zero, A, B, control);
    `include "Parameters.vh"
    input [XLEN - 1 : 0] A;    // Operand A
    input [XLEN - 1 : 0] B;    // Operand B
    input [2 : 0] control;

    output zero;
    output reg [XLEN - 1 : 0] result;

    // ALU Operations
    always @ (*)
    begin
        case(control)
            ADD_OPCODE : result = A + B;
            SUB_OPCODE : result = A - B;
            AND_OPCODE : result = A & B;
            OR_OPCODE  : result = A | B;
            SLT_OPCODE : result = A < B;
        endcase
    end

    assign zero = (result == 32'b0) ? 1'b1 : 1'b0;
endmodule
