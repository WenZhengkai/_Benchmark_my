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

  // Stage 0 signals
  val f0_valid = io.fromFtq.req.valid
  val f0_fire = f0_valid && io.fromFtq.req.ready

  // Stage 1 signals
  val f1_valid = RegInit(false.B)
  val f1_ftq_req = Reg(new Bundle {
    val startAddr = UInt(32.W)
  })

  val f1_fire = f1_valid && io.f2_ready

  // Stage 0 logic
  io.fromFtq.req.ready := io.f2_ready && !io.f2_flush
  
  // Handle flushing
  when(io.f2_flush || !f0_fire) {
    f1_valid := false.B
  }.otherwise {
    f1_valid := f0_fire
    when(f0_fire) {
      f1_ftq_req := io.fromFtq.req.bits
    }
  }

  // Stage 1 logic
  io.f1_valid := f1_valid && !io.f2_flush

  // Calculate f1_pc, f1_half_snpc, f1_cut_ptr based on f1_ftq_req.startAddr
  for (i <- 0 until PredictWidth) {
    io.f1_pc(i) := f1_ftq_req.startAddr + (i.U * 2.U)
    io.f1_half_snpc(i) := f1_ftq_req.startAddr + (i.U * 4.U) + 2.U
  }

  for (i <- 0 until PredictWidth + 1) {
    io.f1_cut_ptr(i) := Cat(0.U(1.W), f1_ftq_req.startAddr(blockOffBits - 2, 0))
  }

  // Handle the f1_fire handshake
  io.f1_valid := f1_valid && io.f2_ready
}


