/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : Parameters.vh                                                  *
 * Description : This file describes the parameters used in Yu Core             *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/2                                                      *
 ********************************************************************************/
`ifndef _PARAMETERS_VH_
`define _PARAMETERS_VH_

parameter IS_RV32       = 1;

parameter TRUE          = 0'b1;
parameter FALSE         = 0'b0;

// Width of address line
parameter ADDR_WIDTH_32 = 32;
parameter ADDR_WIDTH_64 = 64;

// Width of memory output data
parameter DATA_WIDTH_32 = 32;
parameter DATA_WIDTH_64 = 64;

// Parameters of registers
parameter REGISTER_NUM  = 32;
parameter XLEN = 32;              // The 32 x registers are 32 bits wide

// Parameters of instruction memory
parameter INSTRUCTION_MEM_SIZE = 1024;
parameter EXECUTE_FILE_NAME    = "inst.txt";    // The machine code file

parameter DATA_MEM_SIZE = 1024;

//----------------------------------------------------------------
// Parameters of Instruction
//----------------------------------------------------------------
parameter I_TYPE_INSTR = 7'b000_0011;
parameter S_TYPE_INSTR = 7'b010_0011;
parameter R_TYPE_INSTR = 7'b011_0011;

//----------------------------------------------------------------
// Parameters of Arithmetic Logic Unit (ALU)
//----------------------------------------------------------------
// ALU operations
parameter ADD_OPCODE    = 3'b000;
parameter SUB_OPCODE    = 3'b001;
parameter AND_OPCODE    = 3'b010;
parameter OR_OPCODE     = 3'b011;

`endif