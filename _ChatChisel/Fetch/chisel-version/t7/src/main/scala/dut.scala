import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // from CSR
    val trap_vector = Input(UInt(32.W))
    val mert_vector = Input(UInt(32.W))
    // from Execute
    val target_pc = Input(UInt(32.W))
    // from Memory
    val mem_pc = Input(UInt(32.W))
    val pcsrc = Input(Bool())
    val branch = Input(Bool())
    // from Writeback
    val trap = Input(Bool())
    val mert = Input(Bool())
    // from Hazard
    val pc_stall = Input(Bool())
    val if_id_stall = Input(Bool())
    val if_id_flush = Input(Bool())
    // to Decode
    val id_pc = Output(UInt(32.W))
    val inst = Output(UInt(32.W))
    // from Top
    val fetch_data = Input(UInt(32.W))
    // to Top
    val fetch_address = Output(UInt(32.W))
  })

  // Constants
  val RESET_VECTOR = 0x80000000.U(32.W)

  // Core Registers
  val pc_reg = RegInit(RESET_VECTOR)  // Program Counter (PC)
  val id_pc_reg = RegInit(0.U(32.W)) // IF/ID pipeline register for PC
  val inst_reg = RegInit(0.U(32.W))  // IF/ID pipeline register for instruction

  // Wires for next PC calculation
  val next_pc = Wire(UInt(32.W))

  // Instantiate BHT (Branch History Table)
  val bht = Module(new BHT)
  bht.io.pc := pc_reg
  bht.io.mem_pc := io.mem_pc
  bht.io.pcsrc := io.pcsrc.asUInt
  bht.io.target_pc := io.target_pc

  // Instantiate BTB (Branch Target Buffer)
  val btb = Module(new BTB)
  btb.io.pc := pc_reg
  btb.io.mem_pc := io.mem_pc
  btb.io.pcsrc := io.pcsrc.asUInt
  btb.io.branch := io.branch.asUInt

  // Next PC calculation with priority logic
  next_pc := MuxCase(pc_reg + 4.U, Seq(
    (reset.asBool) -> RESET_VECTOR,                                     // Reset
    (io.trap) -> io.trap_vector,                                       // Trap
    (io.mert) -> io.mert_vector,                                       // MRET
    (io.pcsrc) -> io.target_pc,                                        // Branch Target
    (bht.io.matched.asBool && bht.io.valid.asBool && btb.io.btb_taken.asBool) -> bht.io.bht_pred_pc // BHT/BTB Prediction
  ))

  // PC register update logic
  when(reset.asBool) {
    pc_reg := RESET_VECTOR
  }.elsewhen(!io.pc_stall) {
    pc_reg := next_pc
  }

  // IF/ID pipeline register logic
  when(reset.asBool) {
    id_pc_reg := 0.U
    inst_reg := 0.U
  }.elsewhen(io.if_id_flush) {
    inst_reg := 0.U // Inserting bubble (NOP)
    id_pc_reg := pc_reg
  }.elsewhen(!io.if_id_stall) {
    id_pc_reg := pc_reg
    inst_reg := io.fetch_data
  }

  // Connect outputs to Decode stage
  io.id_pc := id_pc_reg
  io.inst := inst_reg

  // Connect fetch address to output (to Top)
  io.fetch_address := pc_reg
}
