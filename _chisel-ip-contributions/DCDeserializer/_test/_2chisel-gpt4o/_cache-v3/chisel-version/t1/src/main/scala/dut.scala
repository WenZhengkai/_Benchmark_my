import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles needed for deserialization
  val totalBits = data.getWidth
  val cycles = (totalBits + width - 1) / width

  // Internal registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = RegInit(VecInit(Seq.fill(cycles)(0.U(width.W))))
  val dataValid = RegInit(false.B)

  // Handling input data
  when(io.dataIn.fire()) {
    dataSelect(cycleCount) := io.dataIn.bits
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Construct the output data from selected segments
  io.dataOut.bits := dataSelect.asTypeOf(data)
  
  // Control logic for input and output readiness
  io.dataOut.valid := dataValid
  io.dataIn.ready := !dataValid || io.dataOut.fire()

  // Reset dataValid once dataOut has been transmitted
  when(io.dataOut.fire()) {
    dataValid := false.B
  }
}
