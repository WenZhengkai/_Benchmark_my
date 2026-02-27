import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles required for deserialization
  val totalBits = data.getWidth
  val cycles = (totalBits + width - 1) / width // Ceiling division

  // Internal registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid  = RegInit(false.B)

  // Deserialization logic
  when(io.dataIn.fire) {
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

  // Reset dataValid when dataOut is transmitted
  when(io.dataOut.fire) {
    dataValid := false.B
  }
}

// Example usage
/*
object dut extends App {
  val dataType = UInt(32.W) // Example data type
  val width = 8             // Example serialized width
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(dataType, width), args)
}
*/
