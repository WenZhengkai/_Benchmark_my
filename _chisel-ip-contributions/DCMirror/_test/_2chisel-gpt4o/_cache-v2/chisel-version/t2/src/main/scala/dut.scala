import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, n: Int) extends Module {
  val io = IO(new Bundle {
    val dst = Input(UInt(n.W))
    val c = Flipped(DecoupledIO(data.cloneType))
    val p = Vec(n, DecoupledIO(data.cloneType))
  })

  // Register to hold the current data payload
  val pData = Reg(data.cloneType)

  // Register to track which outputs have valid data
  val pValid = RegInit(0.U(n.W))

  // Concatenated ready signals from all outputs
  val pReady = Cat(io.p.map(_.ready).reverse)

  // Compute next accept signal based on validity and readiness of data
  val nxtAccept = (pValid === 0.U) || (pValid & pReady) === pValid

  // Control logic for updating pValid and pData
  when(io.c.valid && nxtAccept) {
    pData := io.c.bits
    pValid := io.dst & Fill(n, 1.U(1.W))  // Apply mask from `dst`, indicating valid outputs
  }.otherwise {
    pValid := pValid & ~pReady // Clear valid bits for outputs that have accepted the data
  }

  // Assign valid and bits to each output channel in `p`
  io.p.zipWithIndex.foreach { case (out, i) =>
    out.valid := pValid(i)
    out.bits := pData
  }

  // Tell the input channel when the module is ready to accept new data
  io.c.ready := nxtAccept
}

