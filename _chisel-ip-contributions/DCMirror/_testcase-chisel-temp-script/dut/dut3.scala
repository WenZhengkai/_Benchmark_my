import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))                       // Active output destinations
    val c   = Flipped(DecoupledIO(data.cloneType))   // Input channel
    val p   = Vec(n, DecoupledIO(data.cloneType))    // Output channels (array of DecoupledIO interfaces)
  })

  // Registers to store the data payload and the valid signal for each output
  val pData  = Reg(data.cloneType)                  // Data register
  val pValid = RegInit(0.U(n.W))                    // Valid register, initialized to zero

  // Concatenate all outputs' ready signals into a ready vector
  val pReady = Cat(io.p.map(_.ready).reverse)

  // Compute the next accept signal
  val nxtAccept = (pValid === 0.U) || (pValid & pReady === pValid)

  // Update the data and valid signals based on nxtAccept
  when(nxtAccept) {
    // Update pData with the incoming data if nxtAccept is true
    pData := io.c.bits
    
    // Set valid bits for outputs according to dst if incoming data is valid
    pValid := Mux(io.c.valid, io.dst, 0.U)
  }.otherwise {
    // Retain valid bits for outputs that are not ready
    pValid := pValid & ~pReady
  }

  // Control the input ready signal
  io.c.ready := nxtAccept

  // Assign outputs
  for (i <- 0 until n) {
    io.p(i).valid := pValid(i)                      // Drive valid signals from pValid
    io.p(i).bits  := pData                          // Share the same data payload across all outputs
  }
}

// Test module or instantiation can be created as follows:
// class Top extends Module {
//   val dataWidth = 16
//   val numOutputs = 4
//   val io = IO(new Bundle {
//     val dst = Input(UInt(numOutputs.W))
//     val in  = Flipped(DecoupledIO(UInt(dataWidth.W)))
//     val out = Vec(numOutputs, DecoupledIO(UInt(dataWidth.W)))
//   })
//   val dcMirror = Module(new DCMirror(UInt(dataWidth.W), numOutputs))
//   dcMirror.io.dst := io.dst
//   dcMirror.io.c <> io.in
//   io.out <> dcMirror.io.p
// }
