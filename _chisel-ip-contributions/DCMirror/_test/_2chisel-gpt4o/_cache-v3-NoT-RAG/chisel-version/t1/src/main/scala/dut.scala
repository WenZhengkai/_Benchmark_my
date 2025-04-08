import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))                        // Destination bit vector
    val c = Flipped(Decoupled(data.cloneType))        // Input channel
    val p = Vec(n, Decoupled(data.cloneType))         // Output vector
  })

  // Task 1: Define Registers and Signals
  val pData = Reg(data.cloneType)                    // Register to hold input data
  val pValid = RegInit(0.U(n.W))                     // Valid register to track active outputs
  val pReady = VecInit(io.p.map(_.ready)).asUInt     // Aggregated readiness of all outputs
  val nxtAccept = Wire(Bool())                       // Signal to determine when the module accepts new data

  // Task 2: Implement Data Register (`pData`)
  when(nxtAccept) {
    pData := io.c.bits                               // Update `pData` when module accepts new data
  }

  // Task 3: Implement Valid Register (`pValid`)
  when(nxtAccept) {
    pValid := Mux(io.c.valid, io.dst, 0.U)           // Set `pValid` based on `dst` and `c.valid`
  }.otherwise {
    pValid := pValid & ~pReady                       // Retain bits for outputs that aren't ready
  }

  // Task 4: Compute the Next Accept Signal (`nxtAccept`)
  nxtAccept := (pValid === 0.U) || ((pValid & ~pReady) === 0.U)

  // Task 5: Assign Outputs
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)                       // Drive the `valid` signal for each output
    io.p(i).bits := pData                            // Distribute the same `pData` to all outputs
  }

  // Task 6: Integrate Flow Control
  io.c.ready := nxtAccept                            // Input is ready when the module can accept data
}