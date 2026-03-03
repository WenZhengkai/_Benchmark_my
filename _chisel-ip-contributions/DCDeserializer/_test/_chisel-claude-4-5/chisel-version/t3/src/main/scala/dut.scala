import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles required to deserialize the data
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width  // Ceiling division
  
  // Register initialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Deserialization process
  when(io.dataIn.fire) {
    // Store the incoming serialized data segment
    dataSelect(cycleCount) := io.dataIn.bits
    
    when(cycleCount === (cycles - 1).U) {
      // Last segment received
      dataValid := true.B
      cycleCount := 0.U
    }.otherwise {
      // Continue to next cycle
      cycleCount := cycleCount + 1.U
    }
  }

  when(io.dataOut.fire) {
    // Reset dataValid when output is successfully transmitted
    dataValid := false.B
  }

  // Output logic
  io.dataOut.bits := dataSelect.asTypeOf(data)
  io.dataOut.valid := dataValid

  // Input ready control
  // dataIn is ready when we are either:
  // 1. Not yet valid (still collecting data), OR
  // 2. Valid but dataOut is ready (so we can accept new data after this transaction)
  io.dataIn.ready := !dataValid || io.dataOut.ready
}
