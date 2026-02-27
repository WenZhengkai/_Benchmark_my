import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // from CSR
    val trap_vector = Input(UInt(32.W))
    val mert_vector = Input(UInt(32.W))
    // from execute
    val target_pc = Input(UInt(32.W))
    // from memory
    val mem_pc = Input(UInt(32.W))
    val pcsrc = Input(Bool())
    val branch = Input(Bool())
    // from writeback
    val trap = Input(Bool())
    val mert = Input(Bool())
    // from hazard
    val pc_stall = Input(Bool())
    val if_id_stall = Input(Bool())
    val if_id_flush = Input(Bool())
    // to decode
    val id_pc = Output(UInt(32.W))
    val inst = Output(UInt(32.W))
    // from top
    val fetch_data = Input(UInt(32.W))
    // to top
    val fetch_address = Output(UInt(32.W))
  })

  // Constants
  val RESET_VECTOR = 0x80000000.U(32.W)

  // Core Registers
  val pc_reg = RegInit(RESET_VECTOR) // PC register
  val id_pc_reg = RegInit(0.U(32.W)) // Pipeline register for decode stage PC
  val inst_reg = RegInit(0.U(32.W)) // Pipeline register for decode stage instruction

  // BHT Submodule
  val io_bht = Module(new BHT).io // Instantiate BHT module
  io_bht.pc := pc_reg
  io_bht.mem_pc := io.mem_pc
  io_bht.pcsrc := io.pcsrc.asUInt
  io_bht.target_pc := io.target_pc

  // BTB Submodule
  val io_btb = Module(new BTB).io // Instantiate BTB module
  io_btb.pc := pc_reg
  io_btb.mem_pc := io.mem_pc
  io_btb.pcsrc := io.pcsrc.asUInt
  io_btb.branch := io.branch.asUInt

  // Wires
  val next_pc = Wire(UInt(32.W)) // Next PC value
  val bht_prediction_valid = io_bht.matched && io_bht.valid && io_btb.btb_taken

  // Next PC Calculation
  next_pc := MuxCase(pc_reg + 4.U, Seq(
    reset.asBool -> RESET_VECTOR,
    io.trap -> io.trap_vector,
    io.mert -> io.mert_vector,
    io.pcsrc -> io.target_pc,
    bht_prediction_valid -> io_bht.bht_pred_pc
  ))

  // PC Update Logic
  when(reset.asBool) {
    pc_reg := RESET_VECTOR
  }.elsewhen(!io.pc_stall) {
    pc_reg := next_pc
  }

  // IF/ID Pipeline Registers
  when(reset.asBool) {
    id_pc_reg := 0.U
    inst_reg := 0.U
  }.elsewhen(io.if_id_flush) {
    inst_reg := 0.U // Bubble (nop) instruction
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

