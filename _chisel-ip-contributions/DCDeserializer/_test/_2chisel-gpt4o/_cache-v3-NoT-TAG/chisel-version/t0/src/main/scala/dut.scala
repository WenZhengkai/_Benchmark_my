import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  val cycles = (data.getWidth + width - 1) / width
  require(cycles > 0, "Number of deserialization cycles must be greater than 0")

  // Input and output interface
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(UInt(width.W)))  // Serialized input
    val dataOut = Decoupled(data.cloneType)         // Deserialized output
  })

  // Task 2: Register Initialization
  val cycleCount = RegInit(0.U(log2Ceil(cycles + 1).W))
  val dataSelect = Reg(Vec(cycles, UInt(width.W)))
  val dataValid = RegInit(false.B)

  // Task 3: Data Capture Logic
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits
    cycleCount := Mux(cycleCount === (cycles - 1).U, 0.U, cycleCount + 1.U)
  }

  // Task 4: Deserialization Completion Logic
  when(io.dataIn.fire && (cycleCount === (cycles - 1).U)) {
    dataValid := true.B
  }

  // Task 5: Output Acknowledgment Logic
  when(io.dataOut.fire) {
    dataValid := false.B
  }

  // Task 6: Output Data Construction
  io.dataOut.bits := dataSelect.asTypeOf(data.cloneType)

  // Task 7: Flow Control Logic
  io.dataOut.valid := dataValid
  io.dataIn.ready := !dataValid || io.dataOut.ready
}
