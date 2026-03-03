import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, s"width must be > 0, got $width")
  private val dataBits = data.getWidth
  require(dataBits > 0, s"data type must have known positive width, got $dataBits")

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(chiselTypeOf(data))
  })

  private val cycles = (dataBits + width - 1) / width
  private val cntW   = math.max(1, log2Ceil(cycles))

  val cycleCount = RegInit(0.U(cntW.W))
  val dataSelect = RegInit(VecInit(Seq.fill(cycles)(0.U(width.W))))
  val dataValid  = RegInit(false.B)

  // Output reconstruction
  private val assembled = dataSelect.asUInt
  io.dataOut.bits  := assembled(dataBits - 1, 0).asTypeOf(chiselTypeOf(data))
  io.dataOut.valid := dataValid

  // Backpressure: accept input only when not holding a completed output
  // or when output is being accepted this cycle.
  io.dataIn.ready := !dataValid || io.dataOut.ready

  // If output is consumed, clear valid (unless overwritten below by a new full word in same cycle).
  when(io.dataOut.fire) {
    dataValid := false.B
  }

  // Consume serialized chunks
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits

    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid := true.B
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }
}
