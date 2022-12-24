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
parameter INSTRUCTION_MEM_SIZE   = 1024;
parameter INSTRUCTION_FILE_NAME  = "inst.txt";    // The machine code file

parameter DATA_MEM_SIZE = 1024;

// Types of immediate number
parameter I_TYPE_IMM    = 2'b00;

//----------------------------------------------------------------
// Parameters of Arithmetic Logic Unit (ALU)
//----------------------------------------------------------------
// ALU operations
parameter ADD_OPCODE    = 3'b000;
parameter SUB_OPCODE    = 3'b001;
parameter AND_OPCODE    = 3'b010;
parameter OR_OPCODE     = 3'b011;

`endif