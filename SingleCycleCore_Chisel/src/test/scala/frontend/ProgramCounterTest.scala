package frontend

import org.scalatest.flatspec.AnyFlatSpec
import chiseltest._
import chisel3._
import scala.util._
import config._

class ProgramCounterTest extends AnyFlatSpec with ChiselScalatestTester {
    behavior of "ProgramCounter"
    val conf = YuConfig()
    it should "count 4 in positive edge of clock signal" in {
        test (new ProgramCounter(conf.frontend)) { pc =>
            // test body here
            for (i <- 0 until 10) {
                pc.io.PC.expect((i * 4).U)
                pc.clock.step(1)
            }
        }
    }
}

//import chisel3.stage.ChiselGeneratorAnnotation

//object PCTestMain extends App {
//    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated/PC"), Seq(ChiselGeneratorAnnotation(() => new ProgramCounter(32))))
//}
