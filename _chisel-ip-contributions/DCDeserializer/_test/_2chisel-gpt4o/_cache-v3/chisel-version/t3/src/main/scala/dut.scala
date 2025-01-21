import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Determine number of cycles required for deserialization
  val totalWidth = data.getWidth
  val cycles = (totalWidth + width - 1) / width // ceil(totalWidth / width)

  // Register declarations
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Initial signals
  io.dataIn.ready := !dataValid
  io.dataOut.valid := dataValid
  io.dataOut.bits := dataSelect.asTypeOf(data)

  // Deserialization logic
  when(io.dataIn.fire()) {
    dataSelect(cycleCount) := io.dataIn.bits
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U
    } .otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Output logic
  when(io.dataOut.fire()) {
    dataValid := false.B
  }
}
