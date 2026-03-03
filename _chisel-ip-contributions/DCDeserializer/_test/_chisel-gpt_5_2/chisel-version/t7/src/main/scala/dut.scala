import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "width must be > 0")

  private val totalBits = data.getWidth
  require(totalBits > 0, "data type must have a known, > 0 width")

  // Number of serialized beats needed to reconstruct the full word
  private val cycles: Int = (totalBits + width - 1) / width
  require(cycles > 0)

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Track which beat we're currently capturing
  private val cycleCountW = if (cycles <= 1) 1 else log2Ceil(cycles)
  val cycleCount = RegInit(0.U(cycleCountW.W))

  // Storage for the incoming chunks
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))

  // Indicates a complete reconstructed word is available on dataOut
  val dataValid = RegInit(false.B)

  // Handshake:
  // - When we have a complete word pending (dataValid), stop accepting input
  // - Otherwise accept input while we are collecting beats
  io.dataIn.ready := !dataValid

  // Output side
  io.dataOut.valid := dataValid

  // Assemble captured chunks into the output type.
  // Note: If totalBits is not a multiple of width, the MSB unused bits in the last
  // captured chunk are included as-is in the packed word; choose width accordingly.
  io.dataOut.bits := dataSelect.asUInt.asTypeOf(data.cloneType)

  // Capture incoming serialized beats
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits

    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid := true.B
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Once the reconstructed word is accepted, clear valid to start next transaction
  when(io.dataOut.fire) {
    dataValid := false.B
  }
}
