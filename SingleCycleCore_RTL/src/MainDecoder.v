/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : MainDecoder.v                                                  *
 * Description : The Main decoder for Yu Core in controll unit, it reads the    *
 *               opcode and generate control signals                            *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/12/11                                                     *
 ********************************************************************************/

module MainDecoder (branch, resultSrc, memWrite, ALUSrc, immSrc, regWrite, ALUOpcode, opcode);
    `include "Parameters.vh"
    input [6 : 0] opcode;

    output reg branch;
    output reg resultSrc;
    output reg memWrite;
    output reg ALUSrc;
    output reg [1 : 0] immSrc;
    output reg regWrite;
    output reg [1 : 0] ALUOpcode;

    always @ (opcode)
    begin
        case(opcode)
            I_TYPE_INSTR : begin
                regWrite  <= 1'b1;
                immSrc    <= 2'b00;
                ALUSrc    <= 1'b1;
                memWrite  <= 1'b0;
                resultSrc <= 1'b1;
                branch    <= 1'b0;
                ALUOpcode <= 2'b00;
            end
            S_TYPE_INSTR : begin
                regWrite  <= 1'b0;
                immSrc    <= 2'b01;
                ALUSrc    <= 1'b1;
                memWrite  <= 1'b1;
                resultSrc <= 1'bx;
                branch    <= 1'b0;
                ALUOpcode <= 2'b00;
            end
            R_TYPE_INSTR : begin
                regWrite  <= 1'b1;
                immSrc    <= 2'bxx;
                ALUSrc    <= 1'b0;
                memWrite  <= 1'b0;
                resultSrc <= 1'b0;
                branch    <= 1'b0;
                ALUOpcode <= 2'b10;
            end
            B_TYPE_INSTR : begin
                regWrite  <= 1'b0;
                immSrc    <= 2'b10;
                ALUSrc    <= 1'b0;
                memWrite  <= 1'b0;
                resultSrc <= 1'bx;
                branch    <= 1'b1;
                ALUOpcode <= 2'b01;
            end
        endcase
    end

endmodule
