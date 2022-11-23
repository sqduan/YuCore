/********************************************************************************
 *                                                                              *
 *                         Yu Core - Single Cycle Version                       *
 *                                                                              *
 *------------------------------------------------------------------------------*
 * File Name   : ProgramCounterTest.scala                                       *
 * Description : This file is the test branch of the program counter            *
 * Test Steps                                                                   *
 *      Step 1 : Create test class for program counter                          *
 *                                                                              *
 * Author      : Shiqi Duan                                                     *
 * Date        : 2022/11/3                                                      *
 ********************************************************************************/
package frontend

import org.scalatest.flatspec.AnyFlatSpec
import chiseltest._
import chisel3._
import scala.util._
import config._

class ProgramCounterTest extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "ProgramCounter"
    val conf = YuConfig()        // Read config object
    it should "count 4 in positive edge of clock signal" in {
        test (new ProgramCounter(conf.frontend)) { pc =>
            for (i <- 0 until 10) {
                pc.io.PC.expect((i * 4).U)
                pc.clock.step(1)
            }
        }
    }
}

// Generate verilog file for program counter
object PCTestMain extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated/PC"), Seq(ChiselGeneratorAnnotation(() => new ProgramCounter(32))))
}
