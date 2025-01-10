import chisel3._
import chisel3.util._

class FtqToIfuIO extends Bundle {
  val req = Flipped(Decoupled(new Bundle {
    val startAddr = UInt(32.W)
  }))
}

class dut(val PredictWidth: Int, val blockOffBits: Int) extends Module {
  val io = IO(new Bundle {
    val f2_flush = Input(Bool())
    val fromFtq = new FtqToIfuIO
    val f2_ready = Input(Bool())
    
    val f1_valid = Output(Bool())
    val f1_pc = Output(Vec(PredictWidth, UInt(32.W)))
    val f1_half_snpc = Output(Vec(PredictWidth, UInt(32.W)))
    val f1_cut_ptr = Output(Vec(PredictWidth + 1, UInt((blockOffBits - 1).W)))
  })

  // Stage 0
  val f0_valid = io.fromFtq.req.valid
  val f0_fire = f0_valid && io.fromFtq.req.ready

  // Stage 1 Registers
  val f1_valid_reg = RegInit(false.B)
  val f1_ftq_req = RegEnable(io.fromFtq.req.bits, f0_fire)

  // Stage 1 Control Signals
  val f1_fire = f1_valid_reg && io.f2_ready
  val f1_ready = !f1_valid_reg || f1_fire

  io.fromFtq.req.ready := f1_ready

  // Update f1_valid based on flush or fire logic
  when (f1_fire || io.f2_flush) {
    f1_valid_reg := false.B
  }.elsewhen(f0_fire) {
    f1_valid_reg := true.B
  }

  // Compute f1_pc, f1_half_snpc, and f1_cut_ptr
  io.f1_pc := VecInit(Seq.tabulate(PredictWidth) { i =>
    f1_ftq_req.startAddr + (i.U << 1)
  })

  io.f1_half_snpc := VecInit(Seq.tabulate(PredictWidth) { i =>
    f1_ftq_req.startAddr + (i.U << 2) + 2.U
  })

  io.f1_cut_ptr := VecInit(Seq.tabulate(PredictWidth + 1) { i =>
    (1.U << (blockOffBits - 1)) | (f1_ftq_req.startAddr(head(blockOffBits - 2, 0)))
  })

  // Outputs
  io.f1_valid := f1_valid_reg
}

