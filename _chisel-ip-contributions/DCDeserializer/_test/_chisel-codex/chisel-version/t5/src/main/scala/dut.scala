import chisel3._
import chisel3.util._

class dut[D <: Data](gen: D, width: Int) extends Module {
  require(width > 0, "width must be > 0")

  private val totalBits = gen.getWidth
  require(totalBits > 0, "data type must have non-zero width")

  private val cycles = (totalBits + width - 1) / width

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(gen.cloneType)
  })

  // Storage for serialized chunks
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid  = RegInit(false.B)

  // Output reconstruction (trim potential padding bits in the final chunk)
  val packed = dataSelect.asUInt
  io.dataOut.bits  := packed(totalBits - 1, 0).asTypeOf(gen)
  io.dataOut.valid := dataValid

  // Accept new input when output is not pending, or when output is consumed this cycle
  io.dataIn.ready := !dataValid || io.dataOut.ready

  if (cycles == 1) {
    when(io.dataIn.fire) {
      dataSelect(0) := io.dataIn.bits
      dataValid := true.B
    }.elsewhen(io.dataOut.fire) {
      dataValid := false.B
    }
  } else {
    val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
    val lastIdx    = (cycles - 1).U

    when(io.dataIn.fire) {
      dataSelect(cycleCount) := io.dataIn.bits
      when(cycleCount === lastIdx) {
        cycleCount := 0.U
        dataValid := true.B
      }.otherwise {
        cycleCount := cycleCount + 1.U
        dataValid := false.B
      }
    }.elsewhen(io.dataOut.fire) {
      dataValid := false.B
    }
  }
}
