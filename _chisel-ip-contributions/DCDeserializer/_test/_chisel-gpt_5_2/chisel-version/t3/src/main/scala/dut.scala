import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "width must be > 0")

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Total bits in the target parallel type
  private val totalBits = data.getWidth
  require(totalBits > 0, "data type must have a known, >0 bit width")

  // Number of serial beats needed
  private val cycles = (totalBits + width - 1) / width
  require(cycles > 0)

  private val cycleCountW = if (cycles <= 1) 1 else log2Ceil(cycles)

  val cycleCount = RegInit(0.U(cycleCountW.W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid  = RegInit(false.B)

  // Output
  io.dataOut.valid := dataValid
  io.dataOut.bits  := dataSelect.asTypeOf(data)

  // Input ready: accept new segments only while not holding a complete word
  // (i.e., stall input when dataValid is true until output is consumed)
  io.dataIn.ready := !dataValid

  // Capture incoming segments
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits

    when(cycleCount === (cycles - 1).U) {
      dataValid  := true.B
      cycleCount := 0.U
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Once the complete word is accepted by downstream, clear valid
  when(io.dataOut.fire) {
    dataValid := false.B
  }
}
