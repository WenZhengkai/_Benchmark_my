import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(new DecoupledIO(data.cloneType))
    val p = Vec(n, new DecoupledIO(data.cloneType))
  })

  // Internal Registers
  val pData = Reg(data.cloneType)
  val pValid = RegInit(0.U(n.W))

  // Ready Vector
  val pReady = VecInit(io.p.map(_.ready)).asUInt

  // Next Accept Signal
  val nxtAccept = (pValid === 0.U) || (pValid & pReady).andR

  // Data Flow Control
  when(nxtAccept) {
    // Update data payload regardless of incoming data validity
    pData := io.c.bits
    // Update pValid based on dst and incoming data validity
    pValid := Mux(io.c.valid, io.dst, 0.U)
  }.otherwise {
    // Retain only bits of outputs that aren't ready
    pValid := pValid & ~pReady
  }

  // Output Assignment
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }

  // Control the ready signal of the input channel
  io.c.ready := nxtAccept
}

// Example usage
/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut(UInt(8.W), 4))
}
*/
