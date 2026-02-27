// package dut

import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  require(n > 0, "Number of output destinations must be positive")

  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(new DecoupledIO(data.cloneType))
    val p = Vec(n, new DecoupledIO(data.cloneType))
  })

  // Data register to store the input payload
  val pData = RegInit(0.U.asTypeOf(data.cloneType))
  
  // Valid register to track which outputs are holding valid data
  val pValid = RegInit(0.U(n.W))
  
  // Concatenation of ready signals from all outputs
  val pReady = Cat(io.p.map(_.ready).reverse)
  
  // Determine when to accept new data:
  // - When no outputs are currently valid, OR
  // - When all currently valid outputs have accepted their data
  val nxtAccept = (pValid === 0.U) || ((pValid & ~pReady) === 0.U)
  
  // Set the input channel's ready signal based on nxtAccept
  io.c.ready := nxtAccept
  
  // Update pData and pValid based on current state
  when(nxtAccept) {
    // Update data register with new input data
    pData := io.c.bits
    
    // Update valid bits based on dst and input validity
    when(io.c.valid) {
      pValid := io.dst
    }.otherwise {
      pValid := 0.U
    }
  }.otherwise {
    // Keep only the valid bits for outputs that aren't ready yet
    pValid := pValid & ~pReady
  }
  
  // Connect outputs
  for (i <- 0 until n) {
    // Set valid signal for each output based on corresponding bit in pValid
    io.p(i).valid := pValid(i)
    
    // Forward stored data to all outputs
    io.p(i).bits := pData
  }
}
