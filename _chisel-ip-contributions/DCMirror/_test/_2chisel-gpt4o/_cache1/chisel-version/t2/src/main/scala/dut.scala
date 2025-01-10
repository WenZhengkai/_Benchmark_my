

import chisel3._
import chisel3.util._

/** 
 * DCMirror Module 
 * 
 * @param data The type of the payload data being mirrored to outputs.
 * @param n Number of output destinations (width of the `dst` bit vector).
 */
class dut[D <: Data](data: D, n: Int) extends Module {
  require(n > 0, "Number of outputs (n) must be greater than zero")
  
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))                  // Bit vector input specifying active output channels
    val c   = Flipped(Decoupled(data.cloneType)) // Input channel for the data payload
    val p   = Vec(n, Decoupled(data.cloneType)) // Output channels for the data payload
  })

  // Register to store the data payload when accepted
  val pData = RegInit(0.U.asTypeOf(data))

  // Register to track which output channels are currently holding valid data
  val pValid = RegInit(0.U(n.W))

  // Concatenate all the `ready` signals from output channels into a single vector
  val pReady = VecInit(io.p.map(_.ready)).asUInt

  // Signal to determine when to accept new data
  // Accept new data if no current data is valid or if all valid data has been accepted
  val nxtAccept = (pValid === 0.U) || ((pValid & ~pReady) === 0.U)

  // When nxtAccept is true, update pValid based on active bits in dst and c.valid; else retain unaccepted outputs
  when(nxtAccept) {
    pValid := Mux(io.c.valid, io.dst & Fill(n, 1.U(1.W)), 0.U)
    pData := io.c.bits
  }.otherwise {
    pValid := pValid & ~pReady // Clear bits corresponding to ready outputs
  }

  // Output assignment: Drive each output channel in `p`
  for (i <- 0 until n) {
    io.p(i).bits := pData                 // All outputs receive the same data payload
    io.p(i).valid := pValid(i)            // Valid bit driven by corresponding pValid bit
  }
  
  // Input ready signal: True when nxtAccept is true
  io.c.ready := nxtAccept
}

