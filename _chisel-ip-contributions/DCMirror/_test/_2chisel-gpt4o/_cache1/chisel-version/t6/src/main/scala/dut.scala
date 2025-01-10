import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  require(n > 0, "The number of output destinations (n) must be greater than 0.")
  
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))                      // Destination bit vector
    val c = Flipped(DecoupledIO(data.cloneType))    // Input channel
    val p = Vec(n, DecoupledIO(data.cloneType))     // Output channels
  })

  // Internal registers
  val pData = RegInit(0.U.asTypeOf(data.cloneType)) // Register to store input data
  val pValid = RegInit(0.U(n.W))                   // Register to store which outputs are valid

  // Output readiness concatenated into a single vector
  val pReady = VecInit(io.p.map(_.ready)).asUInt()

  // Compute next accept condition
  val nxtAccept = (pValid === 0.U) || (pValid & pReady === pValid)

  // Logic for managing `pValid` and `pData`
  when(nxtAccept) {
    // If we can accept new data, update validity and store the data
    pValid := Mux(io.c.valid, io.dst & Fill(n, 1.U(1.W)), 0.U)
    pData := io.c.bits
  } .otherwise {
    // Update `pValid` to remove outputs that have accepted the data
    pValid := pValid & ~pReady
  }

  // Ready signal for input channel (can accept when `nxtAccept` is true)
  io.c.ready := nxtAccept

  // Assign outputs
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i) // Output is valid if its corresponding bit in `pValid` is set
    io.p(i).bits := pData      // Payload for the output is the stored data
  }
}
