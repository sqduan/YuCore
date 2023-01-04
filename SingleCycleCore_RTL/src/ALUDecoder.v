/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : ALUDecoder.v                                                   *
 * Description : The ALU decoder for Yu Core in controll unit, it reads the     *
 *               opcode and generate control signals to control ALU's behavior  *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2023/1/4                                                       *
 ********************************************************************************/

module ALUDecoder (ALUControl, ALUOpcode, funct3, funct7, opcode5);
    `include "Parameters.vh"
    input [1 : 0] ALUOpcode;
    input [2 : 0] funct3;
    // The ALU decoder use funct7 and opcode[5] to determine ALU control
    input funct7;
    input opcode5;

    output reg [2 : 0] ALUControl;
    reg [1 : 0] subOpcode;

    always @ (*)
    begin
        case(ALUOpcode)
            2'b00 : ALUControl <= ADD_OPCODE;
            2'b01 : ALUControl <= SUB_OPCODE;
            2'b10 : begin
                case(funct3)
                    3'b000 : begin
                        subOpcode = {opcode5, funct7};
                        if (subOpcode != 2'b11) ALUControl = ADD_OPCODE;
                        else ALUControl = SUB_OPCODE;
                    end
                    3'b010 : ALUControl <= SLT_OPCODE;
                    3'b110 : ALUControl <= OR_OPCODE;
                    3'b111 : ALUControl <= AND_OPCODE;
                endcase
            end
        endcase
    end

endmodule
