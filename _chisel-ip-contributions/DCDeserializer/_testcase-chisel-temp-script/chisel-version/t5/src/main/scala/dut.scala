import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Task 1: Calculate number of cycles
  val totalBits = data.getWidth
  val cycles = ((totalBits + width - 1) / width).U

  // Task 2: Registers for state and data
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles.toInt, UInt(width.W))) // Store intermediate data segments
  val dataValid = RegInit(false.B)

  // Task 3: Input data handling
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits
    // Increment the cycle counter
    when(cycleCount === (cycles - 1.U)) {
      cycleCount := 0.U
      dataValid := true.B // Indicate that data is ready
    } .otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Task 5: Construct output data
  io.dataOut.bits := dataSelect.asTypeOf(data) // Concatenate and cast to original data type

  // Task 6: Output valid signal
  io.dataOut.valid := dataValid

  // Task 4: Reset valid flag after outputting data
  when(io.dataOut.fire) {
    dataValid := false.B
  }

  // Task 7: Input flow control
  io.dataIn.ready := !dataValid || io.dataOut.ready
}
