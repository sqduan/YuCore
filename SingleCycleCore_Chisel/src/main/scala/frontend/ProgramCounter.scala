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
import config._

class ProgramCounter(val conf : FrontendConfig) extends Module {
    val io = IO (new Bundle {
        val PC = Output(UInt(conf.xlen.W))
    })

    val PCRegister = RegInit(0.U(conf.xlen.W))
    when (RegNext(RegNext(reset.asBool) && !reset.asBool)) {
        PCRegister := 0
    }

    // Next program counter logic
    val PCPlus = PCRegister + 4.U        // No jump, go to next
    
    PCRegister := PCPlus
    
    io.PC := PCRegister
}
