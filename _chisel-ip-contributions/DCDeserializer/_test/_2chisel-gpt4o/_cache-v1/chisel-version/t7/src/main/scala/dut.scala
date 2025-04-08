import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Serialized data width must be greater than 0")

  // IO Definition
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W))) // Serialized data input
    val dataOut = Decoupled(data.cloneType)        // Deserialized output
  })

  // Calculate number of cycles required to process the entire data
  val totalBits = data.getWidth
  val cycles = (totalBits + width - 1) / width // Ceiling of totalBits / width

  // Internal State
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W)) // Cycle counter
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))  // Temporary storage for serialized segments
  val dataValid = RegInit(false.B)                 // Flag for valid deserialized data

  // Default ready-valid signals
  io.dataIn.ready := !dataValid // Only accept new data when not busy producing output
  io.dataOut.valid := dataValid
  io.dataOut.bits := DontCare // Default assignment

  // Deserialization Process
  when(io.dataIn.fire) { // When input data is valid and ready
    dataSelect(cycleCount) := io.dataIn.bits
    when(cycleCount === (cycles - 1).U) {
      // Last segment received
      dataValid := true.B
      cycleCount := 0.U // Reset cycle count for next transaction
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Assemble the deserialized data when all segments are collected
  if (cycles == 1) {
    // Special case when only a single cycle is needed (edge case)
    io.dataOut.bits := dataSelect.head.asTypeOf(data)
  } else {
    io.dataOut.bits := dataSelect.asUInt.asTypeOf(data)
  }

  // Reset dataValid when the output is successfully transmitted
  when(io.dataOut.fire) {
    dataValid := false.B
  }
}
