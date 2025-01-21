import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width < data.getWidth, "Output width must be less than input data width.")

  // I/O Definitions
  val io = IO(new Bundle {
    val dataIn = Flipped(Decoupled(data))
    val dataOut = Decoupled(UInt(width.W))
  })

  // Calculate the number of cycles required to serialize the input data
  val dataWidth = data.getWidth
  val cycles = if (dataWidth % width != 0) dataWidth / width + 1 else dataWidth / width

  // Internal state
  val cycleCount = RegInit(0.U(log2Ceil(cycles).W))
  val dataBits = Wire(UInt(dataWidth.W))
  val dataSelect = VecInit(Seq.tabulate(cycles) { i =>
    dataBits((i + 1) * width - 1, i * width)
  })

  // Default handshaking signals
  io.dataIn.ready := false.B
  io.dataOut.valid := false.B
  io.dataOut.bits := 0.U

  // Data input acceptance
  when(io.dataIn.fire()) {
    dataBits := io.dataIn.bits.asUInt
    cycleCount := 0.U
  }

  // Data output logic
  when(io.dataOut.ready && cycleCount =/= cycles.U) {
    io.dataOut.bits := dataSelect(cycleCount)
    io.dataOut.valid := true.B

    // Increment cycle count
    cycleCount := cycleCount + 1.U

    // Acknowledge input when all cycles are complete
    when(cycleCount === (cycles - 1).U) {
      io.dataIn.ready := true.B
    }
  }
}
