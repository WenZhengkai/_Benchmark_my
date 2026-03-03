import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles needed to deserialize the data
  val dataWidth = data.asUInt.getWidth
  val cycles = (dataWidth + width - 1) / width  // Equivalent to ceil(dataWidth / width)

  // Register initialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid  = RegInit(false.B)

  // Deserialization process
  when(io.dataIn.fire) {
    // Store the incoming serialized data segment
    dataSelect(cycleCount) := io.dataIn.bits
    
    when(cycleCount === (cycles - 1).U) {
      // All segments received, mark data as valid
      dataValid := true.B
      cycleCount := 0.U
    }.otherwise {
      // Move to next cycle
      cycleCount := cycleCount + 1.U
    }
  }

  // Reset dataValid when output fires
  when(io.dataOut.fire) {
    dataValid := false.B
  }

  // Output logic
  io.dataOut.bits := dataSelect.asTypeOf(data)
  io.dataOut.valid := dataValid

  // Input ready control
  // dataIn is ready when we're not waiting for dataOut to be consumed
  // or when dataOut fires in the same cycle
  io.dataIn.ready := !dataValid || io.dataOut.fire

}
