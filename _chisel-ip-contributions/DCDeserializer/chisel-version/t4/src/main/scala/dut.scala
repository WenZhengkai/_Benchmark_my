import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, s"width must be > 0, got $width")

  private val dataWidth = data.getWidth
  require(dataWidth > 0, s"data width must be known and > 0, got $dataWidth")

  private val cycles = (dataWidth + width - 1) / width
  private val cycleCountWidth = math.max(1, log2Ceil(cycles))

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  val cycleCount = RegInit(0.U(cycleCountWidth.W))
  val dataSelect = RegInit(VecInit(Seq.fill(cycles)(0.U(width.W))))
  val dataValid  = RegInit(false.B)

  // Output side
  io.dataOut.valid := dataValid
  private val assembled = Cat(dataSelect.reverse) // LSB-first collection into cycle slots
  private val trimmed =
    if (cycles * width == dataWidth) assembled
    else assembled(dataWidth - 1, 0)
  io.dataOut.bits := trimmed.asTypeOf(data)

  // Input ready: accept when not holding a complete word, or when output is consumed now
  io.dataIn.ready := !dataValid || io.dataOut.ready

  val inFire  = io.dataIn.fire
  val outFire = io.dataOut.fire

  // Once output is consumed, clear valid (may be reasserted below if a full new word arrives same cycle)
  when(outFire) {
    dataValid := false.B
  }

  // Collect serialized chunks
  when(inFire) {
    dataSelect(cycleCount) := io.dataIn.bits
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }
}
