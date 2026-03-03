import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Serialized channel width must be > 0")

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  private val totalBits = data.getWidth
  require(totalBits > 0, "data must have a known, non-zero width")

  // Number of serialized beats needed to reconstruct the full parallel word
  private val cycles = (totalBits + width - 1) / width
  require(cycles > 0)

  // Counter for which beat we are currently receiving
  private val cycleCountWidth = math.max(1, log2Ceil(cycles))
  val cycleCount = RegInit(0.U(cycleCountWidth.W))

  // Storage for each received beat
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))

  // Indicates that we have a complete reconstructed word waiting to be consumed
  val dataValid = RegInit(false.B)

  // Flow control:
  // - Accept input only when we are not holding a completed word,
  //   or when the completed word is being consumed in the same cycle.
  val outFire = io.dataOut.valid && io.dataOut.ready
  io.dataIn.ready := !dataValid || outFire

  // Output side
  io.dataOut.valid := dataValid
  io.dataOut.bits  := dataSelect.asTypeOf(data.cloneType)

  // Input capture and completion
  val inFire = io.dataIn.valid && io.dataIn.ready
  when(inFire) {
    dataSelect(cycleCount) := io.dataIn.bits

    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid  := true.B
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Clear valid once the output transaction completes
  when(outFire) {
    dataValid := false.B
  }
}
