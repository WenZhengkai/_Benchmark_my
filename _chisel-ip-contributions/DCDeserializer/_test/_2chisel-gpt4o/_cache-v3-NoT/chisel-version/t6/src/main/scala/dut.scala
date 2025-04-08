import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles needed to process the entire width of the original data
  val cycles = (data.getWidth + width - 1) / width

  // Register for tracking the deserialization process
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Deserialization process
  when (io.dataIn.fire()) {
    dataSelect(cycleCount) := io.dataIn.bits
    cycleCount := cycleCount + 1.U

    when (cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U
    }
  }

  // Output data construction
  io.dataOut.bits := dataSelect.asTypeOf(data)
  io.dataOut.valid := dataValid

  // Manage flow control
  io.dataIn.ready := !dataValid || io.dataOut.ready

  when (io.dataOut.fire()) {
    dataValid := false.B
  }
}

// Testbench or further integration would go here
