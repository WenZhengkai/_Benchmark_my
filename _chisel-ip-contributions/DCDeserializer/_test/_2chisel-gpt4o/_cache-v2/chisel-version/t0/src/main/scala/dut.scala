import chisel3._
import chisel3.util._

class dut[T <: Data](data: T, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles required for a complete deserialization
  val cycles = (data.getWidth + width - 1) / width

  // Registers and internal logic
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  io.dataOut.valid := dataValid
  io.dataOut.bits := dataSelect.asTypeOf(data)
  io.dataIn.ready := !dataValid

  // Deserialization process
  when(io.dataIn.fire()) {
    // Store the incoming serialized data
    dataSelect(cycleCount) := io.dataIn.bits

    when(cycleCount === (cycles - 1).U) {
      // Last cycle of deserialization
      dataValid := true.B
      cycleCount := 0.U
    } .otherwise {
      // Increment cycle counter
      cycleCount := cycleCount + 1.U
    }
  }

  // Reset the valid flag upon successful data transfer
  when(io.dataOut.fire()) {
    dataValid := false.B
  }
}
