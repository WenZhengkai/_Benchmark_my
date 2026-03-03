import chisel3._
import chisel3.util._

/**
  * Deserializer: accepts a serialized stream (width bits per beat) and rebuilds a parallel word of type D.
  *
  * - Does not acknowledge (accept) a new transaction while holding an unconsumed output word.
  * - Assembles `cycles = ceil(totalWidth / width)` beats, stores them, then raises dataOut.valid.
  */
class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Serialized channel width must be > 0")

  private val totalBits = data.getWidth
  require(totalBits > 0, "data must have a known, non-zero width")

  private val cycles = (totalBits + width - 1) / width
  require(cycles > 0)

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Counter for which beat we are currently receiving
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Storage for each received beat
  val dataSelect = RegInit(VecInit(Seq.fill(cycles)(0.U(width.W))))

  // Indicates we have a complete reconstructed word waiting to be consumed
  val dataValid = RegInit(false.B)

  // Ready to accept input only when we're not holding a completed output.
  // While collecting beats, keep accepting as long as downstream isn't blocking completion.
  io.dataIn.ready := !dataValid

  // Output valid when a full word has been assembled
  io.dataOut.valid := dataValid

  // Reconstruct bits from stored beats; truncate to totalBits then cast to D
  // Beat 0 goes to the least-significant chunk.
  val assembled = Cat(dataSelect.reverse) // MS chunk first for Cat
  io.dataOut.bits := assembled(totalBits - 1, 0).asTypeOf(data)

  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits

    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  when(io.dataOut.fire) {
    dataValid := false.B
  }
}
