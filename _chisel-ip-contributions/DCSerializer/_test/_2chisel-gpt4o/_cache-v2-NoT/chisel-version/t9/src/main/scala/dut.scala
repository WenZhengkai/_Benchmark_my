import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0 && width < data.getWidth, "Width must be less than the bit-width of the input data")

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Task 1: Cycle Calculation Logic
  val cycles = if (data.getWidth % width != 0) (data.getWidth / width) + 1 else data.getWidth / width

  // Task 2: Cycle Counter Register
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Task 3: Data Selection and Storage
  val dataSelect = Wire(Vec(cycles, UInt(width.W)))
  for (i <- 0 until cycles) {
    val start = i * width
    val end = start + width - 1
    dataSelect(i) := io.dataIn.bits.asUInt()(end.min(data.getWidth - 1), start)
  }
  
  // Current output word
  io.dataOut.bits := dataSelect(cycleCount)

  // Task 4: Handshaking Logic for Data Input
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready

  // Task 5: Handshaking Logic for Data Output
  io.dataOut.valid := io.dataIn.valid

  // Logic to handle cycle count increment and reset
  when(io.dataOut.fire()) {
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  } .otherwise {
    when(io.dataIn.fire()) {
      cycleCount := 0.U
    }
  }
  
  // Optional: Stalling logic for output until data is available
  io.dataOut.valid := io.dataIn.valid && (cycleCount < cycles.U)
}


