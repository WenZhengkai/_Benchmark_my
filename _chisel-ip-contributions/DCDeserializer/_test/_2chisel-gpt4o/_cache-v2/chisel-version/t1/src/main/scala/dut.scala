import chisel3._
import chisel3.util._

class dut[D <: Data](val data: D, val width: Int) extends Module {
  require(width > 0, "Width must be greater than 0")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W))) // Serial data input
    val dataOut = Decoupled(data.cloneType)         // Parallel data output
  })

  // Calculate the number of cycles required to deserialize the data
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width

  // Internal state
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Deserialization process
  when(io.dataIn.fire()) {
    dataSelect(cycleCount) := io.dataIn.bits
    cycleCount := cycleCount + 1.U

    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U
    }
  }

  // Output Logic
  io.dataOut.bits := dataSelect.asTypeOf(data)
  io.dataOut.valid := dataValid
  io.dataIn.ready := !dataValid

  when(io.dataOut.fire()) {
    dataValid := false.B
  }
}