import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(Decoupled(data.cloneType))
    val p = Vec(n, Decoupled(data.cloneType))
  })

  // Registers to hold data and valid signals
  val pData = Reg(data.cloneType)
  val pValid = RegInit(0.U(n.W))  // Initialized to zero, means no output has valid data yet.

  // Concatenation of ready signals from all output channels
  val pReady = VecInit(io.p.map(_.ready)).asUInt
  
  // Logic to determine if the module is ready to accept new data
  val nxtAccept = (pValid === 0.U) || (pReady & pValid) === pValid

  // Data Flow Control
  when(nxtAccept) {
    when(io.c.valid) {
      pData := io.c.bits          // Update data register with new input data
      pValid := io.dst            // Update valid register based on dst input
    }
  }.otherwise {
    pValid := pValid & ~pReady    // Retain only the valid bits where the output is not ready
  }

  // Assign ready signal
  io.c.ready := nxtAccept

  // Output Assignment
  io.p.zipWithIndex.foreach { case (out, i) =>
    out.valid := pValid(i)
    out.bits := pData
  }
}


