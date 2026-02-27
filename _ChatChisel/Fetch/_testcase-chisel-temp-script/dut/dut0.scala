// package riscv

import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // From CSR
    val trap_vector = Input(UInt(32.W))
    val mert_vector = Input(UInt(32.W))
    // From execute
    val target_pc = Input(UInt(32.W))
    // From memory
    val mem_pc = Input(UInt(32.W))
    val pcsrc = Input(Bool())
    val branch = Input(Bool())
    // From writeback
    val trap = Input(Bool())
    val mert = Input(Bool())
    // From hazard
    val pc_stall = Input(Bool())
    val if_id_stall = Input(Bool())
    val if_id_flush = Input(Bool())
    // To decode
    val id_pc = Output(UInt(32.W))
    val inst = Output(UInt(32.W))
    // From top
    val fetch_data = Input(UInt(32.W))
    // To top
    val fetch_address = Output(UInt(32.W))
  })

  // Submodules
  val BHT = Module(new BHT)
  val BTB = Module(new BTB)

  // Constants
  val RESET_VECTOR = 0x80000000.U(32.W)

  // Core Registers
  val pc_reg = RegInit(RESET_VECTOR)
  val id_pc_reg = RegInit(0.U(32.W))
  val inst_reg = RegInit(0.U(32.W))

  // Wire definition for next PC
  val next_pc = Wire(UInt(32.W))

  // Priority PC update logic
  next_pc := MuxCase(pc_reg + 4.U, Seq(
    (reset.asBool) -> RESET_VECTOR,
    (io.trap) -> io.trap_vector,
    (io.mert) -> io.mert_vector,
    (io.pcsrc) -> io.target_pc,
    ((BHT.io.matched.asBool && BHT.io.valid.asBool && BTB.io.btb_taken.asBool)) -> BHT.io.bht_pred_pc
  ))

  // PC register update
  when(reset.asBool) {
    pc_reg := RESET_VECTOR
  }.elsewhen(!io.pc_stall) {
    pc_reg := next_pc
  }

  // Connecting BHT Ports
  BHT.io.pc := pc_reg
  BHT.io.mem_pc := io.mem_pc
  BHT.io.pcsrc := io.pcsrc.asUInt
  BHT.io.target_pc := io.target_pc

  // Connecting BTB Ports
  BTB.io.pc := pc_reg
  BTB.io.mem_pc := io.mem_pc
  BTB.io.pcsrc := io.pcsrc.asUInt
  BTB.io.branch := io.branch.asUInt

  // IF/ID Pipeline Register Logic
  when(reset.asBool) {
    id_pc_reg := 0.U
    inst_reg := 0.U
  }.elsewhen(io.if_id_flush) {
    inst_reg := 0.U // Insert bubble (nop)
    id_pc_reg := pc_reg // Maintain the PC for debugging
  }.elsewhen(!io.if_id_stall) {
    id_pc_reg := pc_reg
    inst_reg := io.fetch_data
  }

  // Connecting outputs
  io.id_pc := id_pc_reg
  io.inst := inst_reg
  io.fetch_address := pc_reg
}


