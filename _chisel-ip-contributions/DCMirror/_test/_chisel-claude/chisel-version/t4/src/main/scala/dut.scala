import chisel3._
import chisel3.util._

/** Token distribution module
  *
  * This module distributes tokens (data payloads) to multiple output destinations based on 
  * a bit vector input. It implements flow control through ready/valid handshake protocol.
  *
  * @param data The type of payload data
  * @param n The number of output destinations
  */
class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    // Destination bit vector indicating active output channels
    val dst = Input(UInt(n.W))
    // Input channel for data payload
    val c = Flipped(new DecoupledIO(data.cloneType))
    // Array of output channels
    val p = Vec(n, new DecoupledIO(data.cloneType))
  })

  // Register to store the data payload (not reset)
  val pData = RegInit(0.U.asTypeOf(data.cloneType))
  
  // Register to track which output channels hold valid data
  val pValid = RegInit(0.U(n.W))
  
  // Vector of ready signals from all output channels
  val pReady = Cat(io.p.map(_.ready).reverse)
  
  // Determine when the module is ready to accept new data
  val nxtAccept = (pValid === 0.U) || ((pValid & ~pReady) === 0.U)
  
  // Set input ready signal based on nxtAccept
  io.c.ready := nxtAccept
  
  // Update data register and valid bits
  when(nxtAccept) {
    // Update data register whenever module can accept new data
    pData := io.c.bits
    
    // Update valid register based on incoming valid signal and dst
    when(io.c.valid) {
      pValid := io.dst
    }.otherwise {
      pValid := 0.U
    }
  }.otherwise {
    // Keep only bits that haven't been accepted yet
    pValid := pValid & ~pReady
  }
  
  // Connect output channels
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}
