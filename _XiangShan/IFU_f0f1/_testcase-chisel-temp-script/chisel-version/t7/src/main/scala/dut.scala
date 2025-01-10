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

  io.fromFtq.req.ready := !io.f2_flush // Ready to accept when not flushing

  // Stage 1 - Instruction Address Calculations
  val f1_valid = RegInit(false.B)
  val f1_ftq_req = Reg(io.fromFtq.req.bits.cloneType) // Register for storing the current request

  val f1_fire = f1_valid && io.f2_ready
  io.f1_valid := f1_valid

  // Flushing and validity control
  when(io.f2_flush) {
    f1_valid := false.B
  }.elsewhen(f0_fire) {
    f1_valid := true.B
    f1_ftq_req := io.fromFtq.req.bits
  }.elsewhen(f1_fire) {
    f1_valid := false.B
  }

  // Calculation of program counters, half next PCs, and cut pointers
  io.f1_pc := VecInit(Seq.tabulate(PredictWidth) { i =>
    f1_ftq_req.startAddr + (i.U << 1)
  })

  io.f1_half_snpc := VecInit(Seq.tabulate(PredictWidth) { i =>
    f1_ftq_req.startAddr + (i.U << 2) + 2.U
  })

  io.f1_cut_ptr := VecInit(Seq.tabulate(PredictWidth + 1) { i =>
    Cat(1.U(1.W), (f1_ftq_req.startAddr + (i.U << 1))(blockOffBits - 2, 0))
  })
}
