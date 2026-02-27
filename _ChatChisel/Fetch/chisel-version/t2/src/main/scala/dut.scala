import chisel3._
import chisel3.util._

class BHT_IO extends Bundle {
  val pc = Input(UInt(32.W))
  val mem_pc = Input(UInt(32.W))
  val pcsrc = Input(UInt(1.W))
  val target_pc = Input(UInt(32.W))
  val matched = Output(UInt(1.W))
  val valid = Output(UInt(1.W))
  val bht_pred_pc = Output(UInt(32.W))
}

class BTB_IO extends Bundle {
  val pc = Input(UInt(32.W))
  val mem_pc = Input(UInt(32.W))
  val pcsrc = Input(UInt(1.W))
  val branch = Input(UInt(1.W))
  val btb_taken = Output(UInt(1.W))
}

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
  val inst_reg = RegInit(0.U(32.W)) // For decode stage

  // PC Update Logic
  val next_pc = Wire(UInt(32.W))
  next_pc := MuxCase(pc_reg + 4.U, Seq(
    reset.asBool -> RESET_VECTOR,
    io.trap -> io.trap_vector,
    io.mert -> io.mert_vector,
    io.pcsrc -> io.target_pc,
    (io_bht.matched.asBool && io_bht.valid.asBool && io_btb.btb_taken.asBool) -> io_bht.bht_pred_pc
  ))

  when(reset.asBool) {
    pc_reg := RESET_VECTOR
  }.elsewhen(!io.pc_stall) {
    pc_reg := next_pc
  }

  // Submodule Instantiation
  val io_bht = Module(new Module {
    val io = IO(new BHT_IO)
  }).io

  val io_btb = Module(new Module {
    val io = IO(new BTB_IO)
  }).io

  // Connect BHT Module
  io_bht.pc := pc_reg
  io_bht.mem_pc := io.mem_pc
  io_bht.pcsrc := io.pcsrc.asUInt
  io_bht.target_pc := io.target_pc

  // Connect BTB Module
  io_btb.pc := pc_reg
  io_btb.mem_pc := io.mem_pc
  io_btb.pcsrc := io.pcsrc.asUInt
  io_btb.branch := io.branch.asUInt

  // Pipeline Register Logic for IF/ID
  when(reset.asBool) {
    id_pc_reg := 0.U
    inst_reg := 0.U
  }.elsewhen(io.if_id_flush) {
    inst_reg := 0x00000013.U // NOP instruction in RISC-V
    id_pc_reg := pc_reg
  }.elsewhen(!io.if_id_stall) {
    id_pc_reg := pc_reg
    inst_reg := io.fetch_data
  }

  // Connect Outputs
  io.id_pc := id_pc_reg
  io.inst := inst_reg
  io.fetch_address := pc_reg
}
