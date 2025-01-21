import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Total data width and number of required cycles to deserialize
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width
  
  // Register to track deserialization cycle
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  
  // Vector register to hold segments of deserialized data
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))

  // Register to indicate if deserialized data is valid and ready for output
  val dataValid = RegInit(false.B)

  // Default output logic
  io.dataIn.ready := !dataValid
  io.dataOut.bits := dataSelect.asTypeOf(data)
  io.dataOut.valid := dataValid

  // Deserialization logic
  when(io.dataIn.fire()) {
    // Store incoming segment of serialized data
    dataSelect(cycleCount) := io.dataIn.bits
    // Check if we've reached the last cycle needed
    when(cycleCount === (cycles - 1).U) {
      // Mark the data as valid for output and reset cycle count
      dataValid := true.B
      cycleCount := 0.U
    }.otherwise {
      // Increment cycle count to receive next segment
      cycleCount := cycleCount + 1.U
    }
  }

  // If the output data is successfully transmitted, prepare for next data deserialization
  when(io.dataOut.fire()) {
    dataValid := false.B
  }
}

