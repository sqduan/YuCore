package frontend
import chisel3.stage.ChiselGeneratorAnnotation

object PCTestMain extends App {
    (new chisel3.stage.ChiselStage).execute(Array("--target-dir", "generated/PC"), Seq(ChiselGeneratorAnnotation(() => new ProgramCounter(32))))
}
