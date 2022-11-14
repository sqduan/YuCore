/********************************************************************************
 *                                                                              *
 *                          Yu Core - Single Cycle Version                      *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : ProgramCounter.scala                                           *
 * Description : Description of the program counter (PC) for Yu Core            *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/12                                                     *
 ********************************************************************************/
package frontend
import chisel3._
import chisel3.util._

class ProgramCounter(size: Int) extends Module {
    val io = IO (new Bundle {
        val PC = Output(UInt(size.W))
    })

    val PCRegister = RegInit(0.U(size.W))

    // Next program counter logic
    val PCPlus = PCRegister + 4.U        // No jump, go to next
    
    PCRegister := PCPlus
    
    io.PC := PCRegister
}
