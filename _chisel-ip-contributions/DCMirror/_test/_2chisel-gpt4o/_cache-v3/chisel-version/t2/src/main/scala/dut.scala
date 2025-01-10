import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  require(n > 0, "Number of destinations (n) must be greater than 0")
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))                     // Destination bit vector
    val c = Flipped(Decoupled(data.cloneType))     // Input data stream
    val p = Vec(n, Decoupled(data.cloneType))      // Output data streams
  })

  // Register to hold data payload
  val pData = Reg(data.cloneType)
  // Register to track valid states of output channels
  val pValid = RegInit(0.U(n.W))

  // Concatenate all output ready signals into a ready vector
  val pReady = VecInit(io.p.map(_.ready)).asUInt()

  // Compute the 'next accept' signal
  val nxtAccept = (pValid === 0.U) || (pValid === pReady)

  // Data flow control logic
  when(nxtAccept) {
    pData := io.c.bits                           // Update data payload (`pData`)
    when(io.c.valid) {                           // Update `pValid` based on `dst` and `io.c.valid`
      pValid := io.dst & Fill(n, 1.U(1.W))
    }.otherwise {
      pValid := 0.U
    }
  }.otherwise {
    pValid := pValid & ~pReady                   // Clear `pValid` for accepted channels
  }

  // Assign signals to each output interface in `p`
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)                   // Output `valid` based on `pValid`
    io.p(i).bits := pData                        // Each output gets the same data payload (`pData`)
  }

  // Input `ready` signal
  io.c.ready := nxtAccept                        // Ready to accept new data when `nxtAccept` is true
}
