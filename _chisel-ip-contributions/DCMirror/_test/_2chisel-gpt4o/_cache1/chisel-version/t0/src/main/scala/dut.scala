import chisel3._
import chisel3.util._

class dut[D <: Data](dataType: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W)) // Bit vector specifying active output channels
    val c = Flipped(Decoupled(dataType)) // Input channel (DecoupledIO)
    val p = Vec(n, Decoupled(dataType)) // Output channels (Vec of DecoupledIO)
  })

  // Register to store the incoming data payload
  val pData = Reg(dataType)
  // Register to track which output channels have valid data
  val pValid = RegInit(0.U(n.W))

  // Ready vector: combines readiness signals of all outputs
  val pReady = VecInit(io.p.map(_.ready)).asUInt

  // Determines when the module is ready to accept new data
  val nxtAccept = (pValid === 0.U) || (pValid & pReady) === pValid

  // Update valid register and data payload
  when(nxtAccept) {
    // When accepting new data, set valid bits to active (dst) if input is valid
    pValid := Mux(io.c.valid, io.dst & Fill(n, 1.U(1.W)), 0.U)
    // Capture the input payload when accepting new data
    when(io.c.valid) {
      pData := io.c.bits
    }
  }.otherwise {
    // When not accepting new data, retain only non-ready outputs
    pValid := pValid & ~pReady
  }

  // Input ready signal is driven by nxtAccept
  io.c.ready := nxtAccept

  // Connect output channels
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i) // Set valid for each channel based on pValid
    io.p(i).bits := pData      // Output data is the stored payload
  }
}
