import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))                            // Bit vector to select active output channels
    val c = Flipped(Decoupled(data.cloneType))            // Input channel
    val p = Vec(n, Decoupled(data.cloneType))             // Output channels
  })

  // Register to store the data payload
  val pData = Reg(data.cloneType)

  // Register to track which outputs hold valid data
  val pValid = RegInit(0.U(n.W))

  // The ready vector, aggregating all `ready` signals from outputs
  val pReady = VecInit(io.p.map(_.ready)).asUInt

  // Compute when to accept new data
  val nxtAccept = (pValid === 0.U) || (pValid === pReady)

  // Logic for accepting new data
  when(nxtAccept) {
    pData := io.c.bits // Update the data payload register with input data
    pValid := Mux(io.c.valid, io.dst & Fill(n, 1.U), 0.U) // Update valid register based on `dst` and `io.c.valid`
  } .otherwise {
    pValid := pValid & ~pReady // Retain only the bits for outputs that aren't ready
  }

  // Connect the output logic
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)  // Associate valid signal with corresponding `pValid` bit
    io.p(i).bits := pData       // Drive the data payload to all outputs
  }

  // Connect the input ready signal
  io.c.ready := nxtAccept // The module is ready to accept new data when `nxtAccept` is true
}
