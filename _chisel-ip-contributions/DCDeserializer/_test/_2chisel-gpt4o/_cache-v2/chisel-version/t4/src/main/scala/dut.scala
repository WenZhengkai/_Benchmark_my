import chisel3._
import chisel3.util._

class dut[D <: Data](gen: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(gen.cloneType)
  })

  // Calculate how many cycles are needed to deserialize the full data
  val dataBits = gen.getWidth
  val cycles = (dataBits + width - 1) / width // Ceiling division

  // State registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Input handling and cycle counting
  when(io.dataIn.fire) {
    // Store incoming data at the current cycle index
    dataSelect(cycleCount) := io.dataIn.bits
    cycleCount := cycleCount + 1.U
  }

  // Completion and output logic
  when(cycleCount === (cycles - 1).U) {
    dataValid := true.B
    cycleCount := 0.U
  }

  // Connect output bits and valid signal
  when(dataValid) {
    io.dataOut.bits := dataSelect.asTypeOf(gen)
  }

  // Output control logic
  io.dataOut.valid := dataValid
  io.dataIn.ready := !dataValid

  // Reset the dataValid once dataOut is accepted
  when(io.dataOut.fire) {
    dataValid := false.B
  }
}

