import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(new DecoupledIO(data.cloneType))
    val p = Vec(n, new DecoupledIO(data.cloneType))
  })

  // Data register to store the incoming data payload
  val pData = RegInit(0.U.asTypeOf(data.cloneType))
  
  // Valid register to track which output channels have valid data
  val pValid = RegInit(0.U(n.W))
  
  // Concatenate ready signals from all output channels
  val pReady = Cat((0 until n).map(i => io.p(i).ready).reverse)
  
  // Determine when the module is ready to accept new data
  val nxtAccept = (pValid === 0.U) || ((pValid & pReady) === pValid)
  
  // Update data and valid registers based on flow control conditions
  when(nxtAccept) {
    pData := io.c.bits
    when(io.c.valid) {
      pValid := io.dst
    }.otherwise {
      pValid := 0.U
    }
  }.otherwise {
    pValid := pValid & ~pReady
  }
  
  // Connect input ready signal
  io.c.ready := nxtAccept
  
  // Connect outputs
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}
