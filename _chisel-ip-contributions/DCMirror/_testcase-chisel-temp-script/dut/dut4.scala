

import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(Decoupled(data.cloneType))
    val p = Vec(n, Decoupled(data.cloneType))
  })

  // Internal data register to store the payload
  val pData = Reg(data.cloneType)
  
  // Internal register to track valid output channels
  val pValid = RegInit(0.U(n.W))

  // Concatenate ready signals of all output destinations into a single vector
  val pReady = VecInit(io.p.map(_.ready)).asUInt()

  // Compute next accept signal
  val nxtAccept = (pValid === 0.U) || (pValid & pReady) === pValid

  // Data flow control logic
  when(nxtAccept) {
    when(io.c.valid) { 
      pData := io.c.bits 
    }
    pValid := Mux(io.c.valid, io.dst, 0.U)
  }.otherwise {
    pValid := pValid & ~pReady
  }

  // Define input ready signal
  io.c.ready := nxtAccept

  // Output assignment logic
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}
