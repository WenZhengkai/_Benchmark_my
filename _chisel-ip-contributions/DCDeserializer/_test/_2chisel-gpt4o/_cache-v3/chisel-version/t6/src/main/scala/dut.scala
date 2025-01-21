import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W))) // Input: serialized data
    val dataOut = Decoupled(data.cloneType)        // Output: deserialized data
  })

  // Calculate the number of cycles required for deserialization
  val totalBits = data.getWidth
  val cycles = (totalBits + width - 1) / width

  // Internal registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Default output values
  io.dataOut.bits := dataSelect.asTypeOf(data)
  io.dataOut.valid := dataValid
  io.dataIn.ready := !dataValid

  when(io.dataIn.fire()) {
    dataSelect(cycleCount) := io.dataIn.bits
    cycleCount := cycleCount + 1.U
  }

  // Condition who set the deserialized data is ready
  when(cycleCount === (cycles - 1).U && io.dataIn.fire()) {
    dataValid := true.B
    cycleCount := 0.U
  }

  // Reset dataValid if dataOut is consumed
  when(io.dataOut.fire()) {
    dataValid := false.B
  }
}
