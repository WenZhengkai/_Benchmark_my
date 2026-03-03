import chisel3._
import chisel3.util._

class dut[D <: Data](gen: D, width: Int) extends Module {
  require(width > 0, "Serialized channel width must be > 0")

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(gen.cloneType)
  })

  private val totalBits = gen.getWidth
  require(totalBits > 0, "Data type width must be known and > 0")

  private val cycles = (totalBits + width - 1) / width
  private val cntW   = math.max(1, log2Ceil(cycles))

  val cycleCount = RegInit(0.U(cntW.W))
  val dataSelect = RegInit(VecInit(Seq.fill(cycles)(0.U(width.W))))
  val dataValid  = RegInit(false.B)

  // Allow new input when no completed word is pending, or when output is consumed this cycle.
  io.dataIn.ready  := !dataValid || io.dataOut.ready
  io.dataOut.valid := dataValid

  // Pack received chunks and cast back to target type.
  val packed = dataSelect.asUInt
  io.dataOut.bits := packed(totalBits - 1, 0).asTypeOf(gen.cloneType)

  // If output fires, clear valid (may be set again below if an input beat also completes a word).
  when(io.dataOut.fire) {
    dataValid := false.B
  }

  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits

    if (cycles == 1) {
      dataValid  := true.B
      cycleCount := 0.U
    } else {
      when(cycleCount === (cycles - 1).U) {
        dataValid  := true.B
        cycleCount := 0.U
      }.otherwise {
        cycleCount := cycleCount + 1.U
      }
    }
  }
}
