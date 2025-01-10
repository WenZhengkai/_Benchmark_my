import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  require(n > 0, "The number of output destinations (n) must be greater than 0.")

  // IO Definition
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))                       // Destination bit vector
    val c   = Flipped(DecoupledIO(data.cloneType))   // Input channel
    val p   = Vec(n, DecoupledIO(data.cloneType))    // Output channels
  })

  // Registers
  val pData  = RegInit(0.U.asTypeOf(data))           // Register to store data
  val pValid = RegInit(0.U(n.W))                     // Validity register for outputs
  
  // Ready Vector from Outputs
  val pReady = VecInit(io.p.map(_.ready)).asUInt()   // Concatenate all ready signals

  // Compute next accept signal
  val nxtAccept = (pValid === 0.U) || (pValid & pReady) === pValid

  // Update logic for pValid and pData
  when (nxtAccept) {
    // Accept new data only if input is valid and destination is specified
    when (io.c.valid) {
      pValid := io.dst & Fill(n, io.c.valid)         // Update pValid based on `dst` and `valid`
      pData  := io.c.bits                            // Capture incoming data
    }.otherwise {
      pValid := 0.U                                   // No valid data
    }
  } .otherwise {
    // Retain validity for outputs that are not ready
    pValid := pValid & ~pReady
  }

  // Flow control for input channel
  io.c.ready := nxtAccept

  // Drive outputs based on pValid and pData
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)                       // Output valid is based on pValid
    io.p(i).bits  := pData                           // Output data is same across all outputs
  }
}
