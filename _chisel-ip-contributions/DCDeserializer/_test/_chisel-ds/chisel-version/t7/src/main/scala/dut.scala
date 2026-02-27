import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles required for deserialization
  val totalBits = data.getWidth
  val cycles = (totalBits + width - 1) / width

  // Registers for tracking the deserialization process
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid  = RegInit(false.B)

  // Deserialization logic
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits
    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Output logic
  io.dataOut.bits := dataSelect.asTypeOf(data)
  io.dataOut.valid := dataValid

  // Flow control
  io.dataIn.ready := !dataValid || io.dataOut.ready

  // Reset dataValid when the output is successfully transmitted
  when(io.dataOut.fire) {
    dataValid := false.B
  }
}

/*
object dut extends App {
  // Example usage with a 32-bit UInt data type and 8-bit serialized width
  val dataType = UInt(32.W)
  val width = 8
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(dataType, width), Array("--target-dir", "generated"))
}
*/
