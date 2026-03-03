// package dut

import chisel3._
import chisel3.util._

class dut[D <: Data](data: D, width: Int) extends Module {
  require(width > 0, "width must be > 0")

  val io = IO(new Bundle {
    val dataIn  = Flipped(Decoupled(UInt(width.W)))
    val dataOut = Decoupled(data.cloneType)
  })

  // Total bits in the output type
  private val totalBits = data.getWidth
  require(totalBits > 0, "data must have a known, positive width")

  // Number of serialized beats required
  private val cycles = (totalBits + width - 1) / width
  require(cycles > 0)

  // Registers
  private val cycleCount = RegInit(0.U(log2Ceil(cycles).max(1).W))
  private val dataSelect = RegInit(VecInit(Seq.fill(cycles)(0.U(width.W))))
  private val dataValid  = RegInit(false.B)

  // Handshake control:
  // - accept input only when we are not holding a complete output word (dataValid=0)
  // - and either the output is not valid, or the consumer is ready (conservative gating)
  io.dataIn.ready := !dataValid && io.dataOut.ready

  // Capture incoming serialized segments
  when(io.dataIn.fire) {
    dataSelect(cycleCount) := io.dataIn.bits

    when(cycleCount === (cycles - 1).U) {
      cycleCount := 0.U
      dataValid  := true.B
    }.otherwise {
      cycleCount := cycleCount + 1.U
    }
  }

  // Build output from collected segments
  // Note: if totalBits is not a multiple of width, the MSBs of the last beat may be unused.
  private val packed = dataSelect.asUInt
  io.dataOut.bits  := packed(totalBits - 1, 0).asTypeOf(data)

  io.dataOut.valid := dataValid

  // Clear valid when output is consumed
  when(io.dataOut.fire) {
    dataValid := false.B
  }
}
