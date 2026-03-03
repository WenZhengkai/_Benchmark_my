import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Cycle Calculation
  val dataWidth = data.getWidth
  val cycles = (dataWidth + width - 1) / width  // Ceiling division to handle remainder

  // Register Initialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Deserialization Process
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits
    
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid := true.B
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  when(io.dataOut.fire) {
    dataValid := false.B
  }

  // Output Logic
  io.dataOut.bits := dataSelect.asTypeOf(data)
  io.dataOut.valid := dataValid

  // Input ready control
  // dataIn is ready when we're not holding valid data, or when dataOut is being consumed
  io.dataIn.ready := !dataValid || io.dataOut.ready

}
