import chisel3._
import chisel3.util._

class dut[D <: Data](val data: D, val width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles required for deserialization
  val totalBits = data.getWidth
  val cycles    = (totalBits + width - 1) / width

  // Internal registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid  = RegInit(false.B)

  // Default output signals
  io.dataOut.valid := dataValid
  io.dataOut.bits  := dataSelect.asTypeOf(data)
  io.dataIn.ready  := !dataValid

  // Deserialization process
  when(io.dataIn.fire()) {
    // Store serialized segment into dataSelect
    dataSelect(cycleCount) := io.dataIn.bits
    // Update cycle count
    cycleCount := cycleCount + 1.U

    // Check if the last segment is received
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U // Reset cycle count
    }
  }

  // When dataOut is consumed, reset dataValid
  when(io.dataOut.fire()) {
    dataValid := false.B
  }
}
