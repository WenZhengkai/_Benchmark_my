import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(data.getWidth > width, "Serialized width must be less than the bit-width of the input data")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Calculate cycles needed for serialization
  val cycles = (data.getWidth + width - 1) / width

  // Register to track the current cycle
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  
  // Vec to store the serialized words
  val dataSelect = VecInit(Seq.tabulate(cycles) { i =>
    io.dataIn.bits.asUInt()((i + 1) * width - 1, i * width)
  })

  // Combinational logic for handshaking
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready
  io.dataOut.valid := io.dataIn.valid

  // Driving output
  io.dataOut.bits := dataSelect(cycleCount)

  // Cycle counter logic
  when(io.dataOut.fire) {
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
    } .otherwise {
      cycleCount := cycleCount + 1.U
    }
  }
}

