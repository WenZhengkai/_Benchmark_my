import chisel3._
import chisel3.util._



class dut extends Module {
  val io = IO(new Bundle {
    // From CSR
    val trap_vector = Input(UInt(32.W))
    val mert_vector = Input(UInt(32.W))
    // From Execute
    val target_pc = Input(UInt(32.W))
    // From Memory
    val mem_pc = Input(UInt(32.W))
    val pcsrc = Input(Bool())
    val branch = Input(Bool())
    // From Writeback
    val trap = Input(Bool())
    val mert = Input(Bool())
    // From Hazard
    val pc_stall = Input(Bool())
    val if_id_stall = Input(Bool())
    val if_id_flush = Input(Bool())
    // To Decode
    val id_pc = Output(UInt(32.W))
    val inst = Output(UInt(32.W))
    // From Top
    val fetch_data = Input(UInt(32.W))
    // To Top
    val fetch_address = Output(UInt(32.W))
  })

  // Constants
  val RESET_VECTOR = "h80000000".U(32.W)

  // Core Registers
  val pc_reg = RegInit(RESET_VECTOR)
  val id_pc_reg = RegInit(0.U(32.W))
  val inst_reg = RegInit(0.U(32.W))

  // Wire for next PC calculation
  val next_pc = Wire(UInt(32.W))

  // Submodule Instantiations
  val bht = Module(new BHT)
  val btb = Module(new BTB)

  // Submodule Connections
  bht.io.pc := pc_reg
  bht.io.mem_pc := io.mem_pc
  bht.io.pcsrc := io.pcsrc.asUInt
  bht.io.target_pc := io.target_pc

  btb.io.pc := pc_reg
  btb.io.mem_pc := io.mem_pc
  btb.io.pcsrc := io.pcsrc.asUInt
  btb.io.branch := io.branch.asUInt

  // PC Update Logic
  next_pc := MuxCase(pc_reg + 4.U, Seq(
    reset.asBool -> RESET_VECTOR,
    io.trap -> io.trap_vector,
    io.mert -> io.mert_vector,
    io.pcsrc -> io.target_pc,
    (bht.io.matched.asBool && bht.io.valid.asBool && btb.io.btb_taken.asBool) -> bht.io.bht_pred_pc
  ))

  // Update PC Register
  when(reset.asBool) {
    pc_reg := RESET_VECTOR
  }.elsewhen(!io.pc_stall) {
    pc_reg := next_pc
  }

  // IF/ID Pipeline Update Logic
  when(reset.asBool) {
    id_pc_reg := 0.U
    inst_reg := 0.U
  }.elsewhen(io.if_id_flush) {
    inst_reg := 0.U // Flush instruction (nop)
    id_pc_reg := pc_reg
  }.elsewhen(!io.if_id_stall) {
    id_pc_reg := pc_reg
    inst_reg := io.fetch_data
  }

  // Output Connections
  io.id_pc := id_pc_reg
  io.inst := inst_reg
  io.fetch_address := pc_reg
}
