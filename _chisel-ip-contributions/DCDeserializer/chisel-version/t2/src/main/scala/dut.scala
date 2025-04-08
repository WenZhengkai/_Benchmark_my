import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be greater than 0")

  // IO Declarations
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Total number of bits in the data type and calculate the required number of cycles
  val totalBits = data.getWidth
  val cycles = (totalBits + width - 1) / width

  // Registers to manage the deserialization state
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Default output values
  io.dataOut.bits := data.cloneType.asTypeOf(0.U).asTypeOf(data) // Default, to be overwritten
  io.dataOut.valid := dataValid

  // Input Handling Logic
  when(io.dataIn.fire) { // Fire when valid and ready
    dataSelect(cycleCount) := io.dataIn.bits // Store the incoming data
    when(cycleCount === (cycles - 1).U) { // If we reach the final cycle
      cycleCount := 0.U // Reset cycle count
      dataValid := true.B // Set data valid to indicate completion
    } .otherwise {
      cycleCount := cycleCount + 1.U // Increment cycle counter
    }
  }

  // Output Handling Logic
  when(io.dataOut.fire) { // Fire when valid and ready
    dataValid := false.B // Reset the valid flag after transmitting data
  }

  // Output Data Construction
  io.dataOut.bits := dataSelect.asTypeOf(data) // Concatenate and cast to original data type

  // Flow Control Logic
  io.dataIn.ready := !dataValid || io.dataOut.ready // Ready when idle or output is ready
}


