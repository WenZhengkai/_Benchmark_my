import chisel3._
import chisel3.util._

class FtqToIfuIO extends Bundle {
  val req = Decoupled(new Bundle {
    val startAddr = UInt(32.W)
  })
}

class dut(val PredictWidth: Int, val blockOffBits: Int) extends Module {
  val io = IO(new Bundle {
    // Inputs
    val f2_flush = Input(Bool())
    val fromFtq = Flipped(new FtqToIfuIO)
    val f2_ready = Input(Bool())

    // Outputs
    val f1_valid = Output(Bool())
    val f1_pc = Output(Vec(PredictWidth, UInt(32.W)))
    val f1_half_snpc = Output(Vec(PredictWidth, UInt(32.W)))
    val f1_cut_ptr = Output(Vec(PredictWidth + 1, UInt((blockOffBits - 1).W)))
  })

  // Stage 0 - Fetch Request Handling
  val f0_valid = io.fromFtq.req.valid
  val f0_fire = f0_valid && io.fromFtq.req.ready

  io.fromFtq.req.ready := !f0_fire

  // Stage 1 - Instruction Address Calculations
  val f1_valid = RegInit(false.B)
  val f1_ftq_req = RegInit(0.U.asTypeOf(io.fromFtq.req.bits))

  when(!f1_valid || f0_fire) {
    f1_ftq_req := io.fromFtq.req.bits
  }

  when(io.f2_flush) {
    f1_valid := false.B
  }.elsewhen(f0_fire) {
    f1_valid := true.B
  }

  val f1_fire = f1_valid && io.f2_ready

  // Calculations for PCs, half_snpcs, and cut_ptrs
  val baseAddr = f1_ftq_req.startAddr
  val pcIncr = 2.U
  val halfSnpcIncr = 4.U

  for (i <- 0 until PredictWidth) {
    io.f1_pc(i) := baseAddr + (i.U * pcIncr)
    io.f1_half_snpc(i) := baseAddr + (i.U * halfSnpcIncr) + 2.U
  }

  for (i <- 0 until PredictWidth + 1) {
    // Assume 0th bit as a fixed bit; adjust below logic according to your design
    io.f1_cut_ptr(i) := Cat(1.U(1.W), (baseAddr >> 1.U)((blockOffBits - 2), 0))
  }

  // Outputs
  io.f1_valid := f1_valid
}


