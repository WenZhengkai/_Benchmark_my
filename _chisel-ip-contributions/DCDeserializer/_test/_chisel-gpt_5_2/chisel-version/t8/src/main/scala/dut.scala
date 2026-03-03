import chisel3._
import chisel3.util._

/**
  * Deserializer: collects a serial stream (width bits per cycle) into a parallel word of type D.
  *
  * - Does not acknowledge the incoming transaction until the full word has been received.
  * - Holds the completed word on dataOut until it is accepted (dataOut.fire).
  */
class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, s"width must be > 0, got $width")

  val totalBits = data.getWidth
  require(totalBits > 0, s"data must have a known, non-zero width, got $totalBits")

  // Number of beats required to collect the full word
  val cycles = (totalBits + width - 1) / width
  require(cycles > 0)

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid  = RegInit(false.B)

  // Accept input only while assembling (i.e., no completed word pending),
  // and (optionally) only when the output side is ready to accept immediately.
  // This matches the spec statement that ready is controlled by dataValid and dataOut.ready.
  io.dataIn.ready := !dataValid && io.dataOut.ready

  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits

    when(cycleCount === (cycles - 1).U) {
      dataValid  := true.B
      cycleCount := 0.U
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  io.dataOut.valid := dataValid
  io.dataOut.bits  := dataSelect.asTypeOf(data)

  when(io.dataOut.fire) {
    dataValid := false.B
  }
}
