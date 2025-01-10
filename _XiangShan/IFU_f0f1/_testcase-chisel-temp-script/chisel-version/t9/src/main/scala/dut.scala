import chisel3._
import chisel3.util._

class FtqToIfuIO extends Bundle {
  val req = Decoupled(new Bundle {
    val startAddr = UInt(32.W)
  })
}

class dut(val PredictWidth: Int, val blockOffBits: Int) extends Module {
  val io = IO(new Bundle {
    val f2_flush = Input(Bool())
    val fromFtq = Flipped(new FtqToIfuIO)
    val f2_ready = Input(Bool())

    val f1_valid = Output(Bool())
    val f1_pc = Output(Vec(PredictWidth, UInt(32.W)))
    val f1_half_snpc = Output(Vec(PredictWidth, UInt(32.W)))
    val f1_cut_ptr = Output(Vec(PredictWidth + 1, UInt((blockOffBits - 1).W)))
  })

  // Stage 0: Fetch Request Handling
  val f0_valid = io.fromFtq.req.valid
  val f0_fire = f0_valid && io.f2_ready

  // Initialize flush signals
  val f0_flush, f1_flush = WireInit(false.B)

  // Stage 1: Instruction Address Calculations
  val f1_valid = RegInit(false.B)
  val f1_ftq_req = RegEnable(io.fromFtq.req.bits.startAddr, f0_fire)

  val f1_fire = f1_valid && io.f2_ready
  val f1_ready = io.f2_ready

  when(io.f2_flush) {
    f1_valid := false.B
  }.elsewhen(f0_fire) {
    f1_valid := true.B
  }.otherwise {
    f1_valid := f1_valid && !io.f2_flush
  }

  // Compute the program counters, half next PCs, and cut pointers
  when(f0_fire) {
    for (i <- 0 until PredictWidth) {
      io.f1_pc(i) := f1_ftq_req + (i.U * 2.U)
      io.f1_half_snpc(i) := f1_ftq_req + (i.U * 4.U) + 2.U
    }
    for (i <- 0 until PredictWidth + 1) {
      io.f1_cut_ptr(i) := Cat(1.U(1.W), (f1_ftq_req >> 1.U)(blockOffBits-2, 0))
    }
  }

  // Connecting outputs
  io.f1_valid := f1_valid && !io.f2_flush

  // Handshake management for Ftq
  io.fromFtq.req.ready := f1_ready
}

