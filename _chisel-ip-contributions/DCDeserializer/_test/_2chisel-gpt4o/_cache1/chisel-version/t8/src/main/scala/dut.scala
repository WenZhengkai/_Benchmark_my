import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate number of cycles required
  val totalWidth = data.getWidth
  val cycles = (totalWidth + width - 1) / width // ceil(totalWidth / width)

  // Registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Ready signal defaults
  io.dataIn.ready := !dataValid || io.dataOut.fire
  io.dataOut.valid := dataValid

  // Store incoming data segments
  when (io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits
    cycleCount := cycleCount + 1.U
  }

  // When last segment is received, prepare output
  when (cycleCount === (cycles - 1).U) {
    dataValid := true.B
    cycleCount := 0.U
  }

  // Output construction
  io.dataOut.bits := dataSelect.asUInt.asTypeOf(data)

  // Reset valid flag after data is transmitted
  when (io.dataOut.fire) {
    dataValid := false.B
  }
}
