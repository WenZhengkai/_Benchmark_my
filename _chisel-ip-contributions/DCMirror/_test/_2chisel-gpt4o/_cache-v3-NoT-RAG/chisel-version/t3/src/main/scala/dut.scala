import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  require(n > 0, "The number of output destinations (n) must be greater than zero.")
  
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W)) // Bit vector specifying active output channels
    val c = Flipped(Decoupled(data.cloneType)) // Input data channel
    val p = Vec(n, Decoupled(data.cloneType)) // Output data channels
  })

  // Task 1: Define Registers and Signals
  val pData = Reg(data.cloneType) // Register to store incoming data payload
  val pValid = RegInit(0.U(n.W)) // Valid registers for each output channel
  val pReady = Wire(Vec(n, Bool())) // Readiness signals for all output channels
  val nxtAccept = Wire(Bool()) // Signal indicating if new data can be accepted

  pReady := VecInit(io.p.map(_.ready)) // Assign output ready signals to pReady vector

  // Task 2: Implement Data Register (pData)
  when(nxtAccept) {
    pData := io.c.bits // Update pData when module is ready to accept new data
  }

  // Task 3: Implement Valid Register (pValid)
  when(nxtAccept) {
    pValid := Mux(io.c.valid, io.dst, 0.U) // Update pValid based on dst and c.valid
  } .otherwise {
    pValid := pValid & ~Cat(pReady.map(_.asUInt)).asUInt // Mask out ready outputs from pValid
  }

  // Task 4: Compute the Next Accept Signal (nxtAccept)
  nxtAccept := (pValid === 0.U) || (pValid & Cat(pReady.map(_.asUInt)).asUInt) === pValid

  // Task 5: Assign Outputs
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i) // Set valid signal for each output channel based on pValid
    io.p(i).bits := pData // Assign data payload to all active output channels
  }

  // Task 6: Integrate Flow Control
  io.c.ready := nxtAccept // Ready signal for input data based on nxtAccept
}