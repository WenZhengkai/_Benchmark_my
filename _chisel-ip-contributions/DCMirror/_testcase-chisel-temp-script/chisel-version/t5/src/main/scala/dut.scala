import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  require(n > 0, "Number of output destinations must be positive")
  
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(new DecoupledIO(data.cloneType))
    val p = Vec(n, new DecoupledIO(data.cloneType))
  })
  
  // Data register to store incoming data
  val pData = RegInit(0.U.asTypeOf(data.cloneType))
  
  // Valid register to track which outputs have valid data
  val pValid = RegInit(0.U(n.W))
  
  // Concatenate all ready signals from outputs
  val pReady = Cat((0 until n).map(i => io.p(i).ready).reverse)
  
  // Determine when to accept new data
  val nxtAccept = (pValid === 0.U) || ((pValid & pReady) === pValid)
  
  // Update valid bits and data based on nxtAccept condition
  when(nxtAccept) {
    pData := io.c.bits
    pValid := Mux(io.c.valid, io.dst, 0.U)
  }.otherwise {
    pValid := pValid & ~pReady
  }
  
  // Connect input ready signal
  io.c.ready := nxtAccept
  
  // Connect each output channel
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}
