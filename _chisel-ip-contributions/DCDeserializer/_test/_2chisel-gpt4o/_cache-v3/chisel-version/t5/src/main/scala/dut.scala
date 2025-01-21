import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles required for deserialization
  val dataWidth = data.getWidth
  val cycles = (math.ceil(dataWidth.toDouble / width)).toInt

  // Internal registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  io.dataIn.ready := !dataValid

  // Deserialization process
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits
    cycleCount := cycleCount + 1.U

    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U
    }
  }

  // Output logic
  io.dataOut.valid := dataValid
  io.dataOut.bits := dataSelect.asTypeOf(data)

  when(io.dataOut.fire) {
    dataValid := false.B
  }
}
