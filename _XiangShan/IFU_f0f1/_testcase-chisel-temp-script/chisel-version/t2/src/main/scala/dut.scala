import chisel3._
import chisel3.util._

class FtqToIfuIO extends Bundle {
  val req = Decoupled(new Bundle{
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

  // Stage 0 - Fetch Request Handling
  val f0_valid = io.fromFtq.req.valid
  val f0_fire = f0_valid && io.f2_ready
  io.fromFtq.req.ready := io.f2_ready

  // Stage 1 - Registers and State
  val f1_valid_reg = RegInit(false.B)
  val f1_ftq_req = Reg(new Bundle {
    val startAddr = UInt(32.W)
  })

  when(f0_fire) {
    f1_valid_reg := true.B
    f1_ftq_req := io.fromFtq.req.bits
  }.elsewhen(io.f2_flush) {
    f1_valid_reg := false.B
  }

  // Stage 1 - Computation
  val f1_pc = Wire(Vec(PredictWidth, UInt(32.W)))
  val f1_half_snpc = Wire(Vec(PredictWidth, UInt(32.W)))
  val f1_cut_ptr = Wire(Vec(PredictWidth + 1, UInt((blockOffBits - 1).W)))

  for (i <- 0 until PredictWidth) {
    f1_pc(i) := f1_ftq_req.startAddr + (i.U << 1)
    f1_half_snpc(i) := f1_ftq_req.startAddr + (i.U << 2) + 2.U
    f1_cut_ptr(i) := Cat(0.U, (f1_pc(i) >> 1)(blockOffBits - 2, 0))
  }
  f1_cut_ptr(PredictWidth) := Cat(1.U, (f1_pc(PredictWidth - 1) >> 1)(blockOffBits - 2, 0))

  // Outputs
  io.f1_valid := f1_valid_reg && io.f2_ready
  io.f1_pc := f1_pc
  io.f1_half_snpc := f1_half_snpc
  io.f1_cut_ptr := f1_cut_ptr
}


