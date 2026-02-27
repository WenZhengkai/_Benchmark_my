// package example

import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // From CSR
    val trap_vector = Input(UInt(32.W))
    val mert_vector = Input(UInt(32.W))
    // From execute stage
    val target_pc = Input(UInt(32.W))
    // From memory stage
    val mem_pc = Input(UInt(32.W))
    val pcsrc = Input(Bool())
    val branch = Input(Bool())
    // From writeback stage
    val trap = Input(Bool())
    val mert = Input(Bool())
    // From hazard
    val pc_stall = Input(Bool())
    val if_id_stall = Input(Bool())
    val if_id_flush = Input(Bool())
    // To decode stage
    val id_pc = Output(UInt(32.W))
    val inst = Output(UInt(32.W))
    // From top
    val fetch_data = Input(UInt(32.W))
    // To top
    val fetch_address = Output(UInt(32.W))
  })

  // Submodule Interfaces
  val io_bht = IO(new Bundle {
    val pc = Input(UInt(32.W))
    val mem_pc = Input(UInt(32.W))
    val pcsrc = Input(UInt(1.W))
    val target_pc = Input(UInt(32.W))
    val matched = Output(UInt(1.W))
    val valid = Output(UInt(1.W))
    val bht_pred_pc = Output(UInt(32.W))
  })

  val io_btb = IO(new Bundle {
    val pc = Input(UInt(32.W))
    val mem_pc = Input(UInt(32.W))
    val pcsrc = Input(UInt(1.W))
    val branch = Input(UInt(1.W))
    val btb_taken = Output(UInt(1.W))
  })

  /**
   * Task 1: Define Core Registers and Constants
   */
  val RESET_VECTOR = 0x80000000L.U(32.W) // RISC-V reset vector
  
  // Program Counter (PC) register
  val pc_reg = RegInit(RESET_VECTOR)
  
  // IF/ID pipeline registers
  val id_pc_reg = RegInit(0.U(32.W))
  val inst_reg = RegInit(0.U(32.W))

  /**
   * Task 2: Implement PC Update Logic
   */
  val next_pc = Wire(UInt(32.W))
  next_pc := MuxCase(pc_reg + 4.U, Seq(
    (reset.asBool) -> RESET_VECTOR,                              // Reset condition
    io.trap -> io.trap_vector,                                   // Exception vector
    io.mert -> io.mert_vector,                                   // MRET vector
    io.pcsrc -> io.target_pc,                                    // Branch target PC
    ((io_bht.matched.asBool && io_bht.valid.asBool) && 
    io_btb.btb_taken.asBool) -> io_bht.bht_pred_pc               // Predicted PC (BHT/BTB)
  ))

  // PC register synchronous update
  when(reset.asBool) {
    pc_reg := RESET_VECTOR
  }.elsewhen(!io.pc_stall) { // Halt PC update if stall is asserted
    pc_reg := next_pc
  }

  /**
   * Task 3: Instantiate and Connect BHT Submodule
   */
  val bht = Module(new BHT) // BHT instance
  bht.io.pc := pc_reg
  bht.io.mem_pc := io.mem_pc
  bht.io.pcsrc := io.pcsrc.asUInt
  bht.io.target_pc := io.target_pc

  // Connect BHT outputs to local I/O interface
  io_bht.matched := bht.io.matched
  io_bht.valid := bht.io.valid
  io_bht.bht_pred_pc := bht.io.bht_pred_pc

  /**
   * Task 4: Instantiate and Connect BTB Submodule
   */
  val btb = Module(new BTB) // BTB instance
  btb.io.pc := pc_reg
  btb.io.mem_pc := io.mem_pc
  btb.io.pcsrc := io.pcsrc.asUInt
  btb.io.branch := io.branch.asUInt
  
  // Connect BTB outputs to local I/O interface
  io_btb.btb_taken := btb.io.btb_taken

  /**
   * Task 5: Implement Pipeline Register Logic
   */
  when(reset.asBool) {
    id_pc_reg := 0.U
    inst_reg := 0.U
  }.elsewhen(io.if_id_flush) {
    // Insert NOP (no operation) bubble
    id_pc_reg := pc_reg
    inst_reg := 0.U // NOP instruction
  }.elsewhen(!io.if_id_stall) {
    // Normal pipeline register update
    id_pc_reg := pc_reg
    inst_reg := io.fetch_data
  }

  /**
   * Task 6: Connect I/O Ports
   */
  io.fetch_address := pc_reg // Fetch address is always current program counter
  io.id_pc := id_pc_reg      // Output current decode stage PC
  io.inst := inst_reg        // Output instruction to decode stage

  /**
   * Debugging (optionally add print)
   */
  // printf(p"PC: $pc_reg, Next_PC: $next_pc, Inst: $inst_reg\n")
}

