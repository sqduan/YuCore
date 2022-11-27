/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : Parameters.vh                                                  *
 * Description : This file describes the parameters used in Yu Core             *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/2                                                      *
*********************************************************************************/
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

// Types of immediate number
parameter ITypeImm      = 2'b00;

`endif