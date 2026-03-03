import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "width must be > 0")
  require(data.getWidth > 0, "data width must be > 0")

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

  val lastCycle = (cycles - 1).U(cntWidth.W)

  io.dataOut.valid := dataValid
  io.dataOut.bits  := dataSelect.asUInt()(totalBits - 1, 0).asTypeOf(data)

  // Ready is controlled by data-valid state and downstream readiness.
  io.dataIn.ready := !dataValid || io.dataOut.ready

  // If current output is consumed, clear valid unless overwritten below by a new completed word.
  when(io.dataOut.fire) {
    dataValid := false.B
  }

  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits

    when(cycleCount === lastCycle) {
      cycleCount := 0.U
      dataValid  := true.B
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }
}
