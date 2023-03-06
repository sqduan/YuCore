/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : MainDecoder.v                                                  *
 * Description : The Main decoder for Yu Core in controll unit, it reads the    *
 *               opcode and generate control signals according to the opcode    *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/12/11                                                     *
 ********************************************************************************/

/*
 * Module  : MainDecoder
 * Inputs  : opcode -- Operation code of the instruction
 *
 * Outputs : 
 *           branch    -- Is the instruction a branch?
 *           resultSrc -- Result from ALU (0) or data memory (1)
 *           memWrite  -- Write data memory?
 *           ALUSrc    -- ALU's operand B from register file or immediate number
 *           immSrc    -- Immediate number source, 0 for lw, 1 for sw
 *           regWrite  -- Write register file?
 *           ALUOpcode -- Operation code for ALU
 *
 * TODO    : Generalization this module, replase magic number with pre-defined macros
 */
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

    // This always block is the implement of the main decoder's truth table,
    // give opcode, generate control signals for different modules on datapath
    always @ (*)
    begin
        case(opcode)
            LW_INSTR : begin
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
            I_TYPE_ALU_INSTR : begin
                regWrite  <= 1'b1;
                immSrc    <= 2'b00;
                ALUSrc    <= 1'b1;
                memWrite  <= 1'b0;
                resultSrc <= 1'b0;
                branch    <= 1'b0;
                ALUOpcode <= 2'b10;
            end
        endcase
    end

endmodule
