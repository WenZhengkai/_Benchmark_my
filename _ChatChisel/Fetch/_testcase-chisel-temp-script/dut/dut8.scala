// package fetch

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

  // BHT submodule
  val io_bht = IO(new Bundle {
    val pc = Input(UInt(32.W))
    val mem_pc = Input(UInt(32.W))
    val pcsrc = Input(UInt(1.W))
    val target_pc = Input(UInt(32.W))
    val matched = Output(UInt(1.W))
    val valid = Output(UInt(1.W))
    val bht_pred_pc = Output(UInt(32.W))
  })

  // BTB submodule
  val io_btb = IO(new Bundle {
    val pc = Input(UInt(32.W)) // Index to predict
    val mem_pc = Input(UInt(32.W)) // Index to update
    val pcsrc = Input(UInt(1.W)) // Whether the previous instruction is taken
    val branch = Input(UInt(1.W)) // Whether the previous instruction is a branch instruction
    val btb_taken = Output(UInt(1.W)) // Prediction result
  })

  // Define Constants
  val RESET_VECTOR = 0x80000000L.U(32.W)

  // Core Registers
  val pc_reg = RegInit(RESET_VECTOR)
  val id_pc_reg = RegInit(0.U(32.W))
  val inst_reg = RegInit(0.U(32.W))

  // PC Update Logic
  val next_pc = Wire(UInt(32.W))
  next_pc := MuxCase(pc_reg + 4.U, Seq(
    io.pc_stall -> pc_reg, // If stall, maintain current PC
    io.trap -> io.trap_vector,
    io.mert -> io.mert_vector,
    io.pcsrc -> io.target_pc,
    (io_bht.valid.asBool && io_bht.matched.asBool && io_btb.btb_taken.asBool) -> io_bht.bht_pred_pc
  ))

  when(reset.asBool) {
    pc_reg := RESET_VECTOR
  }.elsewhen(!io.pc_stall) {
    pc_reg := next_pc
  }

  // Update Pipeline Registers (IF/ID)
  when(reset.asBool) {
    id_pc_reg := 0.U
    inst_reg := 0.U
  }.elsewhen(io.if_id_flush) {
    inst_reg := 0.U // Insert bubble (NOP)
    id_pc_reg := pc_reg
  }.elsewhen(!io.if_id_stall) {
    id_pc_reg := pc_reg
    inst_reg := io.fetch_data
  }

  // BHT Connections
  io_bht.pc := pc_reg
  io_bht.mem_pc := io.mem_pc
  io_bht.pcsrc := io.pcsrc.asUInt
  io_bht.target_pc := io.target_pc

  // BTB Connections
  io_btb.pc := pc_reg
  io_btb.mem_pc := io.mem_pc
  io_btb.pcsrc := io.pcsrc.asUInt
  io_btb.branch := io.branch.asUInt

  // Output Connections
  io.id_pc := id_pc_reg
  io.inst := inst_reg
  io.fetch_address := pc_reg
}
