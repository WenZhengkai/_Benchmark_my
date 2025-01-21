import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Task 1: Cycle Calculation
  val cycles = (data.getWidth + width - 1) / width

  // Task 2: Register Initialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Task 3: Deserialization Process
  when(io.dataIn.fire()) {
    dataSelect(cycleCount) := io.dataIn.bits
    cycleCount := cycleCount + 1.U

    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U
    }
  }

  // Task 4: Output Data Construction
  io.dataOut.bits := dataSelect.asTypeOf(data)

  // Task 5: Manage Flow Control
  io.dataIn.ready := !dataValid || io.dataOut.ready
  io.dataOut.valid := dataValid

  when(io.dataOut.fire()) {
    dataValid := false.B
  }
}

