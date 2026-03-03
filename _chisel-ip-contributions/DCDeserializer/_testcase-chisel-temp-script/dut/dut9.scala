import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, s"width must be > 0, got $width")

  private val totalBits = data.getWidth
  private val cycles    = (totalBits + width - 1) / width
  private val cntWidth  = math.max(1, log2Ceil(cycles))

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  val cycleCount = RegInit(0.U(cntWidth.W))
  val dataSelect = RegInit(VecInit(Seq.fill(cycles)(0.U(width.W))))
  val dataValid  = RegInit(false.B)

  // Accept input only while current deserialized word is not pending on output.
  io.dataIn.ready := !dataValid

  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits

    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid  := true.B
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Reconstruct original width and cast back to type D.
  val packed = dataSelect.asUInt
  io.dataOut.bits  := packed(totalBits - 1, 0).asTypeOf(data.cloneType)
  io.dataOut.valid := dataValid

  when(io.dataOut.fire) {
    dataValid := false.B
  }
}
