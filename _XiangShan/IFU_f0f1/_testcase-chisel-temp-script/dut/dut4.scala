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

  // Stage 0 Registers and Logic
  val f0_valid = io.fromFtq.req.valid
  val f0_fire = f0_valid && io.fromFtq.req.ready
  io.fromFtq.req.ready := !io.f2_flush && !io.f2_ready
  
  // Stage 1 Registers and Logic
  val f1_valid = RegInit(false.B)
  val f1_ftq_req_startAddr = Reg(UInt(32.W))
  
  when(io.f2_flush) {
    f1_valid := false.B
  } .elsewhen(f0_fire) {
    f1_valid := true.B
    f1_ftq_req_startAddr := io.fromFtq.req.bits.startAddr
  } .elsewhen(io.f2_ready) {
    f1_valid := false.B
  }

  // Compute the address vectors for Stage 1
  val pcBase = Wire(Vec(PredictWidth, UInt(32.W)))
  val snpcBase = Wire(Vec(PredictWidth, UInt(32.W)))
  val cutPtrBase = Wire(Vec(PredictWidth + 1, UInt((blockOffBits - 1).W)))

  for (i <- 0 until PredictWidth) {
    pcBase(i) := f1_ftq_req_startAddr + (i.U << 1)
    snpcBase(i) := f1_ftq_req_startAddr + (i.U << 2) + 2.U
    cutPtrBase(i) := ((f1_ftq_req_startAddr + (i.U << 1))(blockOffBits - 1, 1))
  }
  cutPtrBase(PredictWidth) := 0.U((blockOffBits - 1).W)

  when(f1_valid && io.f2_ready) {
    io.f1_valid := true.B
    io.f1_pc := pcBase
    io.f1_half_snpc := snpcBase
    io.f1_cut_ptr := cutPtrBase
  } .otherwise {
    io.f1_valid := false.B
    io.f1_pc := VecInit(Seq.fill(PredictWidth)(0.U(32.W)))
    io.f1_half_snpc := VecInit(Seq.fill(PredictWidth)(0.U(32.W)))
    io.f1_cut_ptr := VecInit(Seq.fill(PredictWidth + 1)(0.U((blockOffBits - 1).W)))
  }
}

