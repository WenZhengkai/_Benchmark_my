import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Width must be greater than zero")
  require(data.getWidth > width, "Width must be less than the bit-width of the data")

  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Calculate the number of cycles required for serialization
  val cycles = if (data.getWidth % width != 0) data.getWidth / width + 1 else data.getWidth / width

  // Internal Registers
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))

  // Split the input data into segments of `width` bits
  val dataSplit = VecInit(Seq.tabulate(cycles) { i =>
    val start = i * width
    val end = math.min(start + width, data.getWidth)
    data.asUInt()(end - 1, start)
  })

  // Output Logic
  io.dataOut.bits := dataSplit(cycleCount)
  io.dataOut.valid := io.dataIn.valid

  // Input Handshaking
  io.dataIn.ready := (cycleCount === (cycles - 1).U) && io.dataOut.ready

  when(io.dataOut.fire()) {
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  when(io.dataIn.fire()) {
    cycleCount := 0.U
  }
}

