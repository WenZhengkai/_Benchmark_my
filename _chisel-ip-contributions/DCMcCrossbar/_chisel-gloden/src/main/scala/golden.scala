import chisel.lib.dclib._


import chisel3._
import chisel3.util._

/*
Implements a multi-destination crossbar, which allows a source to send to multiple
destinations. This supports partial completions, so two sources talking to the same
group of output ports will not deadlock, but does not guarantee that all words from
one source port will complete before another.
Implemented using DCMirror and DCArbiter

*/

class DcMcCrossbar[D <: Data](data: D, inputs: Int, outputs: Int) extends Module {
  val io = IO(new Bundle {
    val sel = Input(Vec(inputs, UInt(outputs.W)))
    val c = Vec(inputs, Flipped(new DecoupledIO(data.cloneType)))
    val p = Vec(outputs, new DecoupledIO(data.cloneType))
  })

  override def desiredName: String = "DcMcCrossbar" + data.toString + "_M" + inputs + "N" + outputs

  if ((inputs == 1) && (outputs == 1)) {
    io.p(0) <> io.c(0)
  } else {
    val demuxList = for (i <- 0 until inputs) yield Module(new DCMirror(data, outputs))
    val arbList = for (i <- 0 until outputs) yield Module(new DCArbiter(data, inputs, false))
    for (i <- 0 until inputs) {
      demuxList(i).io.c <> io.c(i)
      demuxList(i).io.dst := io.sel(i)

      for (j <- 0 until outputs) {
        demuxList(i).io.p(j) <> arbList(j).io.c(i)
      }
    }
    for (i <- 0 until outputs) {
      arbList(i).io.p <> io.p(i)
    }
  }
}




object Driver extends App {
  println("Generating the DCCrossbar hardware")
  emitVerilog(new DcMcCrossbar(UInt(8.W),2,2), Array("--target-dir", "generated"))
}