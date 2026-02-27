import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Calculate the number of cycles required to deserialize the data
  val totalBits = data.getWidth
  val cycles = (totalBits + width - 1) / width // Ceiling division

  // Internal registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid  = RegInit(false.B)

  // Deserialization process
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits
    cycleCount := cycleCount + 1.U

    // Check if all cycles are completed
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

  // Reset dataValid when dataOut is successfully transmitted
  when(io.dataOut.fire) {
    dataValid := false.B
  }
}

// Example usage with a 32-bit UInt as the data type
class dutExample extends Module {
  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(8.W)))
    val dataOut = Decoupled(UInt(32.W))
  })

  val dut = Module(new dut(UInt(32.W), 8))
  io.dataIn <> dut.io.dataIn
  io.dataOut <> dut.io.dataOut
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dutExample)
}
*/
