import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W)) // Active output channel bit vector
    val c = Flipped(DecoupledIO(data.cloneType)) // Input channel
    val p = Vec(n, DecoupledIO(data.cloneType)) // Output channels
  })

  // -----------------------------------
  // Task 1: Define Registers and Signals
  // -----------------------------------

  // Register to hold incoming data payload
  val pData = Reg(data.cloneType)

  // Register to track which outputs hold valid data
  val pValid = RegInit(0.U(n.W))

  // Signal representing the readiness of output channels
  val pReady = Wire(UInt(n.W))

  // Signal to decide if new data can be accepted
  val nxtAccept = Wire(Bool())

  // -----------------------------------
  // Task 2: Implement Data Register `pData`
  // -----------------------------------

  when(nxtAccept) {
    pData := io.c.bits
  }

  // -----------------------------------
  // Task 3: Implement Valid Register `pValid`
  // -----------------------------------

  when(nxtAccept) {
    // Update pValid based on destination bits and input valid
    pValid := io.dst & Fill(n, io.c.valid.asUInt)
  } .otherwise {
    // Mask out bits for outputs that are not ready
    pValid := pValid & ~pReady
  }

  // -----------------------------------
  // Task 4: Compute the Next Accept Signal `nxtAccept`
  // -----------------------------------

  nxtAccept := (pValid === 0.U) || (pValid & pReady === pValid)

  // -----------------------------------
  // Task 5: Assign Outputs
  // -----------------------------------

  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)
    io.p(i).bits := pData
    pReady := Cat(io.p.map(_.ready).reverse)
  }

  // -----------------------------------
  // Task 6: Integrate Flow Control
  // -----------------------------------

  io.c.ready := nxtAccept
}