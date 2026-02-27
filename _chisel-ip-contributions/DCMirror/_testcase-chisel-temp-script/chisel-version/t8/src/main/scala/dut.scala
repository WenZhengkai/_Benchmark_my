// package chisel_tutorial

import chisel3._
import chisel3.util._

/**
 * A module that distributes tokens (data payloads) to multiple output destinations.
 *
 * @param data The type of the payload data
 * @param n    The number of output destinations
 */
class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    // Bit vector that determines which output channels should receive the data
    val dst = Input(UInt(n.W))
    
    // Input channel for the data payload
    val c = Flipped(new DecoupledIO(data.cloneType))
    
    // Array of output channels corresponding to the potential destinations
    val p = Vec(n, new DecoupledIO(data.cloneType))
  })

  // Register to store the incoming data payload
  val pData = RegInit(0.U.asTypeOf(data.cloneType))
  
  // Register to track which output channels have valid data
  val pValid = RegInit(0.U(n.W))
  
  // Vector of ready signals from all output channels
  val pReady = Cat(io.p.map(_.ready).reverse)
  
  // Determines when the module is ready to accept new data
  val nxtAccept = (pValid === 0.U) || ((pValid & pReady) === pValid)
  
  // Signal to input channel if we're ready to accept new data
  io.c.ready := nxtAccept
  
  // Update valid bits and data register based on next accept condition
  when(nxtAccept) {
    // Update data register with incoming data (regardless of validity)
    pData := io.c.bits
    
    // Update valid bits based on dst and incoming data validity
    when(io.c.valid) {
      pValid := io.dst
    }.otherwise {
      pValid := 0.U
    }
  }.otherwise {
    // Clear bits for outputs that are ready, keep others
    pValid := pValid & ~pReady
  }
  
  // Connect each output channel
  for (i <- 0 until n) {
    // Output is valid if corresponding bit in pValid is set
    io.p(i).valid := pValid(i)
    
    // All active outputs receive the same data payload
    io.p(i).bits := pData
  }
}
