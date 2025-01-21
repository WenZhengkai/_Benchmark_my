import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles needed to deserialize the data
  val cycles = (data.getWidth + width - 1) / width

  // Register Initialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Deserialization Process
  when(io.dataIn.fire()) {
    dataSelect(cycleCount) := io.dataIn.bits
    cycleCount := cycleCount + 1.U

    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U
    }
  }

  // Output Data Construction
  io.dataOut.bits := dataSelect.asTypeOf(data)

  // Manage Flow Control
  io.dataIn.ready := !dataValid
  io.dataOut.valid := dataValid

  when(io.dataOut.fire()) {
    dataValid := false.B
  }
}
