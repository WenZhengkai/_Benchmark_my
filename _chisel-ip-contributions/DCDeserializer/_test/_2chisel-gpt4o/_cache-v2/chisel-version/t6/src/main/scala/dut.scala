import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "The serialized data width must be greater than 0.")
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles needed to deserialize the complete data
  val totalDataWidth = data.getWidth
  val cycles = (totalDataWidth + width - 1) / width

  // Register initialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = RegInit(VecInit(Seq.fill(cycles)(0.U(width.W))))
  val dataValid = RegInit(false.B)

  // Deserialization process
  when(io.dataIn.fire()) {
    dataSelect(cycleCount) := io.dataIn.bits
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Output logic
  io.dataOut.bits := dataSelect.asTypeOf(data)
  io.dataOut.valid := dataValid

  // Manage flow control
  io.dataIn.ready := !dataValid
  when(io.dataOut.fire()) {
    dataValid := false.B
  }
}
