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

  // Stage 1 - Instruction Address Calculations
  val f1_valid_reg = RegInit(false.B)
  val f1_ftq_req_reg = Reg(new Bundle {
    val startAddr = UInt(32.W)
  })

  // Handshake and control signals for each pipeline stage
  val f1_fire = f1_valid_reg && io.f2_ready 

  // Update valid and request state for stage 1
  when(f0_fire && !io.f2_flush) {
    f1_valid_reg := true.B
    f1_ftq_req_reg := io.fromFtq.req.bits
  }.elsewhen(io.f2_flush) {
    f1_valid_reg := false.B
  }

  io.fromFtq.req.ready := !f1_valid_reg || io.f2_ready

  io.f1_valid := f1_valid_reg && !io.f2_flush

  // Compute f1_pc, f1_half_snpc, and f1_cut_ptr
  for (i <- 0 until PredictWidth) {
    io.f1_pc(i) := f1_ftq_req_reg.startAddr + (i.U << 1)
    io.f1_half_snpc(i) := f1_ftq_req_reg.startAddr + (i.U << 2) + 2.U
    io.f1_cut_ptr(i) := Cat(0.U(1.W), i.U((blockOffBits - 1).W))
  }
  io.f1_cut_ptr(PredictWidth) := Cat(1.U(1.W), (PredictWidth - 1).U((blockOffBits - 1).W))

  // Reset logic handled by f2_flush
  when(f1_fire) {
    f1_valid_reg := false.B
  }
}

