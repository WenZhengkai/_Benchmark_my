import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "width must be > 0")

  private val totalBits = data.getWidth
  require(totalBits > 0, "data type must have a known, non-zero width")

  private val cycles = (totalBits + width - 1) / width

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(chiselTypeOf(data))
  })

  // Registers
  private val cycleCount = RegInit(0.U(log2Ceil(cycles).max(1).W))
  private val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  private val dataValid  = RegInit(false.B)

  // Default assignments / flow control
  io.dataOut.valid := dataValid
  io.dataOut.bits  := dataSelect.asUInt.asTypeOf(chiselTypeOf(data))

  // Accept input only when not holding a completed word
  // (and optionally allow immediate restart when output is being consumed)
  io.dataIn.ready := !dataValid || io.dataOut.fire

  // Clear valid when output is consumed
  when(io.dataOut.fire) {
    dataValid := false.B
  }

  // Capture incoming serialized segments
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits

    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid  := true.B
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }
}
