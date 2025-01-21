import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles needed
  val totalWidth = data.getWidth
  val cyclesRequired = (totalWidth + width - 1) / width // Equivalent to ceil(totalWidth / width)

  // Registers for storing intermediate deserialization process states
  val cycleCount = RegInit(0.U(log2Ceil(cyclesRequired).W))
  val dataSelect = Reg(Vec(cyclesRequired, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Default assignments
  io.dataIn.ready := false.B
  io.dataOut.valid := dataValid
  io.dataOut.bits := dataSelect.asTypeOf(data)

  when(io.dataIn.fire()) {
    // Capture incoming data into dataSelect
    dataSelect(cycleCount) := io.dataIn.bits
    // Increment cycleCount or reset if complete
    cycleCount := Mux(cycleCount === (cyclesRequired - 1).U, 0.U, cycleCount + 1.U)
    // Check if we are at the last required cycle
    dataValid := cycleCount === (cyclesRequired - 1).U
  }

  // Manage ready/valid signaling
  io.dataIn.ready := !dataValid || io.dataOut.fire()
  
  when(io.dataOut.fire()) {
    // Reset dataValid for the next transaction
    dataValid := false.B
  }
}

