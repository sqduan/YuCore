/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : RegisterFile.v                                                 *
 * Description : This file describes the register file of Yu                    *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/6                                                      *
 ********************************************************************************/

/*
 * Module  : RegisterFile
 * Inputs  :
 *           clk -- Clock signal
 *
 *           srcRegister1 -- 5 bit address of source register 1 to read data from
 *           srcRegister2 -- 5 bit address of source register 2 to read data from
 *
 *           writeEnable  -- Enable register write
 *           desRegister  -- 5 bit address of destination register to write data to
 *           writeData    -- Data writed to destination register
 *
 * Outputs : 
 *           readData1 -- Data in source register 1
 *           readData1 -- Data in source register 2
 *
 * TODO    : Generalization this module, replase magic number with pre-defined macros
 */
module RegisterFile (readData1, readData2,
                     clk,
                     srcRegister1, srcRegister2,
                     writeEnable, desRegister, writeData);
    `include "Parameters.vh"
    input clk;
    input [4 : 0] srcRegister1;
    input [4 : 0] srcRegister2;

    input writeEnable;
    input [4 : 0] desRegister;
    input [DATA_WIDTH_32 - 1 : 0]writeData;

    // Read register values
    output reg [DATA_WIDTH_32 - 1 : 0] readData1;
    output reg [DATA_WIDTH_32 - 1 : 0] readData2;

    // Main body of register files, basically an SRAM
    reg [DATA_WIDTH_32 - 1 : 0] registers [REGISTER_NUM - 1 : 0];

    integer i;

    // Initialize all the register to zero
    initial
    begin
        for (i = 0; i < REGISTER_NUM; i = i + 1)
            registers[i] <= 32'h00000000;
    end

    // Register read logic, register output the value at clock's negitive edge
    always @ (negedge clk)
    begin
        readData1 <= registers[srcRegister1];
        readData2 <= registers[srcRegister2];
    end

    always @ (posedge clk)
    begin
        // x0 is hardwared to 0 and should not write according RISC-V spec
        if ( writeEnable && desRegister != 5'h0 )
        begin
            registers[desRegister] <= writeData;
        end
    end

endmodule
