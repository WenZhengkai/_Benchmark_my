import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(DecoupledIO(data.cloneType))
    val p = Vec(n, DecoupledIO(data.cloneType))
  })

  // State register for the data payload
  val pData = RegInit(0.U.asTypeOf(data))

  // Valid register to track valid outputs
  val pValid = RegInit(0.U(n.W))

  // Aggregated ready across all outputs
  val pReady = io.p.map(_.ready).asUInt

  // Next accept logic to determine if new data can be accepted
  val nxtAccept = (pValid === 0.U) || (pValid & pReady === pValid)

  // Data Flow Control Logic
  when(nxtAccept) {
    pData := io.c.bits
    // Update pValid with new valid outputs based on dst and c.valid
    pValid := Mux(io.c.valid, io.dst, 0.U)
  } .otherwise {
    // Retain the valid bits for channels that are not ready
    pValid := pValid & ~pReady
  }

  // Drive input ready signal
  io.c.ready := nxtAccept

  // Output assignments
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
  }
}
