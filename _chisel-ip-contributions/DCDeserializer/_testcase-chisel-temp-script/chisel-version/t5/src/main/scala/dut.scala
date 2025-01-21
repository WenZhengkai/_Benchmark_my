import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate number of cycles required to deserialize the data
  val cycles = (data.getWidth + width - 1) / width

  // Register initialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Manage input and output readiness
  io.dataIn.ready := !dataValid // Allow new data if not currently valid
  io.dataOut.valid := dataValid

  when(io.dataIn.fire()) {
    dataSelect(cycleCount) := io.dataIn.bits
    cycleCount := cycleCount + 1.U

    // Check if we have processed the entire data
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U // Reset cycle count for next deserialization
    }
  }

  when(io.dataOut.fire()) {
    dataValid := false.B // Reset dataValid after dataOut is fired
  }

  // Construct the output data from collected segments
  io.dataOut.bits := dataSelect.asTypeOf(data)
}


