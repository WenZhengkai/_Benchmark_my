import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W)) // Destination bit vector
    val c = Flipped(Decoupled(data.cloneType)) // Input channel
    val p = Vec(n, Decoupled(data.cloneType)) // Output channels
  })

  // Register to store the incoming data
  val pData = Reg(data.cloneType)

  // Register to track which outputs hold valid data
  val pValid = RegInit(0.U(n.W))

  // Concatenated `ready` signals from all output channels
  val pReady = io.p.map(_.ready).asUInt()

  // Next accept logic: ready to accept new data if no valid data is currently held
  // or if all currently valid data bits have been accepted
  val nxtAccept = (pValid === 0.U) || (pValid & pReady) === pValid

  // Updating the data and valid registers
  when(nxtAccept) {
    pData := io.c.bits // Always update pData on nxtAccept
    when(io.c.valid) {
      pValid := io.dst & Fill(n, io.c.valid) // Update pValid based on `dst` and `c.valid`
    }.otherwise {
      pValid := 0.U // Clear pValid if incoming data is not valid
    }
  }.otherwise {
    pValid := pValid & ~pReady // Retain valid bits for outputs that aren't ready
  }

  // Connecting the output channels
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i) // Output is valid based on corresponding bit in pValid
    io.p(i).bits := pData // All outputs receive the same data payload
  }

  // Input ready signal: module can accept new data if nxtAccept is true
  io.c.ready := nxtAccept
}
