import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "width must be > 0")
  require(data.getWidth > 0, "data width must be known and > 0")

  private val dataBits = data.getWidth
  private val cycles   = (dataBits + width - 1) / width

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(chiselTypeOf(data))
  })

  private val cycleCountW = math.max(1, log2Ceil(cycles))
  private val cycleCount  = RegInit(0.U(cycleCountW.W))
  private val dataSelect  = RegInit(VecInit(Seq.fill(cycles)(0.U(width.W))))
  private val dataValid   = RegInit(false.B)

  // Can accept new serial data when not holding a completed output,
  // or in the same cycle that output is consumed.
  io.dataIn.ready := !dataValid || io.dataOut.ready
  io.dataOut.valid := dataValid

  val packed = dataSelect.asUInt // element 0 is least-significant chunk
  io.dataOut.bits := packed(dataBits - 1, 0).asTypeOf(chiselTypeOf(data))

  when(io.dataOut.fire) {
    dataValid := false.B
  }

  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits
    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid := true.B
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }
}
