import chisel3._
import chisel3.util._

class dut(val numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in  = Vec(numChannels, Flipped(Decoupled(UInt(8.W))))
    val out = Decoupled(UInt(8.W))
  })

  // Task 1: Implement Output Validity Logic
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Implement Priority Selection using PriorityMux
  val priorityIdx = PriorityMux(io.in.map(_.valid), VecInit(Seq.tabulate(numChannels)(_.U)))

  // Task 3: Implement Data Routing
  io.out.bits := Mux1H(io.in.map(_.valid), io.in.map(_.bits))

  // Task 4: Implement Input Readiness Logic
  for (i <- 0 until numChannels) {
    io.in(i).ready := io.out.ready && (priorityIdx === i.U) && io.in(i).valid
  }
}


