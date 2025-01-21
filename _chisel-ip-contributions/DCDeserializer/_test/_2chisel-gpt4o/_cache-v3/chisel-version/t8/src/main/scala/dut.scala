import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate how many cycles are needed to deserialize the data
  val dataBits = data.getWidth
  val cycles = (dataBits + width - 1) / width // ceiling division to account for partial cycle

  // Internal registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = RegInit(VecInit(Seq.fill(cycles)(0.U(width.W))))
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

  // Output logic
  io.dataOut.bits := dataSelect.asTypeOf(data)
  io.dataOut.valid := dataValid

  // Flow control
  io.dataIn.ready := !dataValid || io.dataOut.ready

  when(io.dataOut.fire()) {
    dataValid := false.B
  }
}
