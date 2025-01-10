import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  // Ensure that output width is less than the width of the input data structure
  require(width > 0, "Output width must be greater than zero")
  require(data.getWidth > width, "Output width must be less than input data width")

  // I/O interface declaration
  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(data))    // Input handshaking interface
    val dataOut = Decoupled(UInt(width.W))   // Output handshaking interface
  })

  // Internal fields
  val dataWidth = data.getWidth               // Total bit-width of input data
  val cycles = (dataWidth + width - 1) / width // Number of cycles to serialize the input data

  // Registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))  // Counter to track serialization cycle
  val activeData = Reg(data)                        // Register to hold the current input data
  val activeTransaction = RegInit(false.B)         // Indicates if a transaction is active

  // Data splitting
  val dataVec = Wire(Vec(cycles, UInt(width.W)))    // Splitting the input data into words of `width` bits
  for (i <- 0 until cycles) {
    val startBit = i * width
    val endBit = math.min(startBit + width, dataWidth) - 1
    dataVec(i) := activeData.asUInt()(endBit, startBit)
  }

  // Output logic
  io.dataOut.bits := dataVec(cycleCount)
  io.dataOut.valid := activeTransaction

  // Input logic
  io.dataIn.ready := !activeTransaction && io.dataOut.ready

  // FSM / State Logic
  when(io.dataOut.fire) {
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      activeTransaction := false.B
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }.otherwise {
    when(io.dataIn.fire) {
      activeData := io.dataIn.bits
      activeTransaction := true.B
      cycleCount := 0.U
    }
  }
}
