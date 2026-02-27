// package riscv

import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // From csr
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

  // Task 1: Define Core Registers and Constants
  val RESET_VECTOR = "h80000000".U(32.W)
  val pc_reg = RegInit(RESET_VECTOR)
  val id_pc_reg = RegInit(0.U(32.W))
  val inst_reg = RegInit(0.U(32.W))

  // Task 2: Implement PC Update Logic
  val bht_pred_pc = Wire(UInt(32.W)) // Placeholder for BHT prediction output
  val matched = Wire(Bool()) // Placeholder for BHT-matched signal
  val valid = Wire(Bool()) // Placeholder for BHT-valid signal
  val btb_taken = Wire(Bool()) // Placeholder for BTB prediction output
  
  val next_pc = MuxCase(pc_reg + 4.U, Seq(
    reset.asBool -> RESET_VECTOR,
    io.trap -> io.trap_vector,
    io.mert -> io.mert_vector,
    io.pcsrc -> io.target_pc,
    (matched && valid && btb_taken) -> bht_pred_pc
  ))

  when(reset.asBool) {
    pc_reg := RESET_VECTOR
  }.elsewhen(!io.pc_stall) {
    pc_reg := next_pc
  }

  // Task 3: Instantiate and Connect BHT Submodule
  val bht = Module(new BHT)
  bht.io.pc := pc_reg
  bht.io.mem_pc := io.mem_pc
  bht.io.pcsrc := io.pcsrc.asUInt
  bht.io.target_pc := io.target_pc
  matched := bht.io.matched.asBool
  valid := bht.io.valid.asBool
  bht_pred_pc := bht.io.bht_pred_pc

  // Task 4: Instantiate and Connect BTB Submodule
  val btb = Module(new BTB)
  btb.io.pc := pc_reg
  btb.io.mem_pc := io.mem_pc
  btb.io.pcsrc := io.pcsrc.asUInt
  btb.io.branch := io.branch.asUInt
  btb_taken := btb.io.btb_taken.asBool

  // Task 5: Implement Pipeline Register Logic
  when(reset.asBool) {
    id_pc_reg := 0.U
    inst_reg := 0.U
  }.elsewhen(io.if_id_flush) {
    inst_reg := 0.U // Insert bubble (nop)
    id_pc_reg := pc_reg // Maintain pc for debugging
  }.elsewhen(!io.if_id_stall) {
    id_pc_reg := pc_reg
    inst_reg := io.fetch_data
  }

  io.id_pc := id_pc_reg
  io.inst := inst_reg

  // Task 6: Connect I/O Ports
  io.fetch_address := pc_reg

  // Optional: Debug prints (applicable in simulation)
  /* Uncomment for debugging only
  printf(p"[FETCH] PC: ${pc_reg}, FETCH_ADDR: ${io.fetch_address}, INST: ${io.fetch_data}\n")
   */
}


// Generate Verilog
/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
