import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "Serialized input width must be > 0")
  require(data.getWidth > 0, "Data type must have a known, positive width")

  private val dataWidth = data.getWidth
  private val cycles    = (dataWidth + width - 1) / width
  private val cntWidth  = math.max(1, log2Ceil(cycles))

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  val cycleCount = RegInit(0.U(cntWidth.W))
  val dataSelect = RegInit(VecInit(Seq.fill(cycles)(0.U(width.W))))
  val dataValid  = RegInit(false.B)

  io.dataOut.valid := dataValid

  // dataIn ready is controlled by current output state and downstream readiness
  io.dataIn.ready := !dataValid || io.dataOut.ready

  // Assemble collected serialized chunks and cast back to original type.
  // Vec.asUInt packs element 0 into LSBs, matching dataSelect(cycleCount) write order.
  val packed = dataSelect.asUInt
  io.dataOut.bits := packed(dataWidth - 1, 0).asTypeOf(data.cloneType)

  // If output is consumed, clear valid first; input logic below can set it again
  // in the same cycle (e.g., width >= dataWidth and both handshakes happen together).
  when(io.dataOut.fire) {
    dataValid := false.B
  }

  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits

    when(cycleCount === (cycles - 1).U) {
      dataValid := true.B
      cycleCount := 0.U
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }
}
