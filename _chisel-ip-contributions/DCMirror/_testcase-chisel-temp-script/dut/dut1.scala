import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(Decoupled(data.cloneType))
    val p = Vec(n, Decoupled(data.cloneType))
  })

  // Data register - holds the current data payload
  val pData = RegInit(0.U.asTypeOf(data.cloneType))
  
  // Valid register - tracks which outputs have valid data
  val pValid = RegInit(0.U(n.W))
  
  // Concatenation of ready signals from all outputs
  val pReady = Cat(io.p.map(_.ready).reverse)
  
  // Next accept logic - determine when to accept new data
  val nxtAccept = (pValid === 0.U) || ((pValid & ~pReady) === 0.U)
  
  // Control logic for accepting new data
  when(nxtAccept) {
    pData := io.c.bits
    when(io.c.valid) {
      pValid := io.dst
    }.otherwise {
      pValid := 0.U
    }
  }.otherwise {
    // Maintain valid bits only for outputs that aren't ready
    pValid := pValid & ~pReady
  }
  
  // Input ready signal - indicates readiness to accept new data
  io.c.ready := nxtAccept
  
  // Connect each output
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}
