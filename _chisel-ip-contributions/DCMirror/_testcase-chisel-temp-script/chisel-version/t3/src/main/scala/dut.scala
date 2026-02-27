import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(new DecoupledIO(data.cloneType))
    val p = Vec(n, new DecoupledIO(data.cloneType))
  })

  // Data register for storing incoming payload
  val pData = RegInit(0.U.asTypeOf(data.cloneType))
  
  // Valid register to track which output channels have valid data
  val pValid = RegInit(0.U(n.W))
  
  // Concatenate ready signals from all output channels
  val pReady = Cat((0 until n).map(i => io.p(i).ready).reverse)
  
  // Determine when the module can accept new data
  val nxtAccept = (pValid === 0.U) || ((pValid & ~pReady) === 0.U)
  
  // Data flow control
  when(nxtAccept) {
    // Store the incoming data payload, regardless of validity
    pData := io.c.bits
    
    // Update valid bits based on dst and incoming validity
    when(io.c.valid) {
      pValid := io.dst
    }.otherwise {
      pValid := 0.U
    }
  }.otherwise {
    // Maintain only the valid bits that aren't ready yet
    pValid := pValid & ~pReady
  }
  
  // Input is ready when we can accept new data
  io.c.ready := nxtAccept
  
  // Connect outputs
  for (i <- 0 until n) {
    // Set valid signal for each output channel
    io.p(i).valid := pValid(i)
    
    // All active outputs receive the same data payload
    io.p(i).bits := pData
  }
}
