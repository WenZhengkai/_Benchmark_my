import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c   = Flipped(Decoupled(data.cloneType))
    val p   = Vec(n, Decoupled(data.cloneType))
  })

  // Data Register to store incoming data when accepted
  val pData = Reg(data.cloneType)

  // Valid Register to track valid status of data for each output
  val pValid = RegInit(0.U(n.W))

  // Ready signal vector from all outputs
  val pReady = VecInit(io.p.map(_.ready)).asUInt

  // Determine the next data acceptance condition
  // Accept new data if no valid data is currently pending or all pending data has been accepted
  val nxtAccept = (pValid === 0.U) || (pValid & pReady) === pValid

  // Logic to accept new data and update the valid status
  when(nxtAccept) {
    pValid := io.dst & Fill(n, io.c.valid)
    pData  := io.c.bits
  } .otherwise {
    // Retain valid status for channels that are not ready
    pValid := pValid & ~pReady
  }

  // Drive the ready signal of input based on acceptance condition
  io.c.ready := nxtAccept

  // Assign output signals
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}
