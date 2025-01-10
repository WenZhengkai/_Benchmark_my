import chisel3._
import chisel3.util._

class FtqToIfuIO extends Bundle {
  val req = Decoupled(new Bundle {
    val startAddr = UInt(32.W)
  })
}

class dut(val PredictWidth: Int, val blockOffBits: Int) extends Module {
  val io = IO(new Bundle {
    val f2_flush    = Input(Bool())
    val fromFtq     = Flipped(new FtqToIfuIO())
    val f2_ready    = Input(Bool())
    val f1_valid    = Output(Bool())
    val f1_pc       = Output(Vec(PredictWidth, UInt(32.W)))
    val f1_half_snpc= Output(Vec(PredictWidth, UInt(32.W)))
    val f1_cut_ptr  = Output(Vec(PredictWidth + 1, UInt((blockOffBits - 1).W)))
  })

  // Stage 0 - Fetch Request Handling

  // Signal assignments
  val f0_valid = WireInit(io.fromFtq.req.valid)
  val f0_fire = f0_valid && io.fromFtq.req.ready

  // Initialize the flush signals
  val f0_flush = WireInit(false.B)

  // Manage request ready logic
  io.fromFtq.req.ready := !io.f2_flush && io.f2_ready

  // Stage 1 - Instruction Address Calculations

  // Registers and state
  val f1_valid_reg = RegInit(false.B)
  val f1_ftq_req = RegInit(0.U.asTypeOf(io.fromFtq.req.bits))

  // Computation and signal propagation
  val f1_fire = f1_valid_reg && io.f2_ready
  val f1_ready = f1_fire || !f1_valid_reg

  when(f0_fire && f1_ready) {
    f1_ftq_req := io.fromFtq.req.bits
    f1_valid_reg := true.B
  }.elsewhen(io.f2_flush) {
    f1_valid_reg := false.B
  }

  io.f1_valid := f1_valid_reg && !io.f2_flush

  // Calculate program counters and offsets
  val baseAddr = f1_ftq_req.startAddr
  for (i <- 0 until PredictWidth) {
    io.f1_pc(i) := baseAddr + (i.U << 1)
    io.f1_half_snpc(i) := baseAddr + (i.U << 2) + 2.U
  }

  // Cut pointer calculation: Concatenate fixed bits with portions of calculated address
  for (i <- 0 until PredictWidth + 1) {
    if (i == 0) {
      io.f1_cut_ptr(i) := 0.U // Assuming some base; replace as per specific functionality required
    } else {
      io.f1_cut_ptr(i) := ((i.U - 1.U) << (blockOffBits - 2)).asUInt()
    }
  }

  // Control logic for validity and flush handling
  when(io.f2_flush) {
    f0_flush := true.B
    f1_valid_reg := false.B
  }
}

