import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Serialized channel width must be > 0")
  private val dataWidth = data.getWidth
  require(dataWidth > 0, "Data type must have a known, positive width")

  private val cycles = (dataWidth + width - 1) / width
  private val countWidth = math.max(1, log2Ceil(cycles))

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  val cycleCount = RegInit(0.U(countWidth.W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid  = RegInit(false.B)

  // Output reconstruction
  val assembled = dataSelect.asUInt
  io.dataOut.bits  := assembled(dataWidth - 1, 0).asTypeOf(data)
  io.dataOut.valid := dataValid

  // Input flow control:
  // - accept serialized words while collecting (dataValid == false)
  // - optionally allow immediate restart when output is consumed
  io.dataIn.ready := !dataValid || (io.dataOut.valid && io.dataOut.ready)

  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid  := true.B
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  when(io.dataOut.fire) {
    dataValid := false.B
  }
}
