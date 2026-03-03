import chisel3._
import chisel3.util._

/**
  * Deserializer dut
  *
  * Reconstructs a parallel word of type `data` from a serialized input stream
  * of `UInt(width.W)` beats. No buffering: it only accepts a new transaction
  * when not holding a completed output word (or when that word is being accepted).
  */
class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "width must be > 0")

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Total bits in the reconstructed type
  private val totalBits = data.getWidth
  require(totalBits > 0, "data type must have a known, non-zero width")

  // Number of serialized beats required (ceil division)
  private val cycles = (totalBits + width - 1) / width
  require(cycles > 0)

  // Counter for which beat we're receiving
  private val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Storage for each incoming beat
  private val dataSelect = RegInit(VecInit(Seq.fill(cycles)(0.U(width.W))))

  // Indicates we have a complete word ready to present on dataOut
  private val dataValid = RegInit(false.B)

  // Flow control:
  // - Only accept input when we are not holding valid output OR output is being consumed.
  // - While holding valid output and downstream not ready, backpressure input.
  io.dataIn.ready  := !dataValid || io.dataOut.ready
  io.dataOut.valid := dataValid

  // Assemble output bits from captured beats and cast to the desired type.
  // Note: if totalBits is not a multiple of width, the extra MSBs are ignored by asTypeOf.
  io.dataOut.bits := dataSelect.asUInt.asTypeOf(data.cloneType)

  // Capture incoming serialized beats
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits

    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid  := true.B
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Once the deserialized word is accepted, clear valid to allow next transaction
  when(io.dataOut.fire) {
    dataValid := false.B
  }
}
