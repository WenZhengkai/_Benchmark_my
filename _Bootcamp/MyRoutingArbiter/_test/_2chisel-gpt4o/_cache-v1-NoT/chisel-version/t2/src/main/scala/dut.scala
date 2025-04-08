import chisel3._
import chisel3.util._

class dut(numChannels: Int) extends Module {
  val io = IO(new Bundle {
    val in = Input(Vec(numChannels, Flipped(Decoupled(UInt(8.W)))))
    val out = Decoupled(UInt(8.W))
  })

  // Task 1: Implement Output Validity Logic
  io.out.valid := io.in.map(_.valid).reduce(_ || _)

  // Task 2: Implement Priority Selection using PriorityMux
  val validSignals = io.in.zipWithIndex.map { case (ch, idx) => ch.valid -> idx.U }
  val selectedIndex = PriorityMux(validSignals)

  // Task 3: Implement Data Routing
  io.out.bits := io.in(selectedIndex).bits

  // Task 4: Implement Input Readiness Logic
  io.in.zipWithIndex.foreach { case (ch, idx) =>
    ch.ready := (io.out.ready && (selectedIndex === idx.U))
  }
}

