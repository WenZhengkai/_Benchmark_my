import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // from csr
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

  // Submodule interface
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
    val pc = Input(UInt(32.W))      // Index to predict
    val mem_pc = Input(UInt(32.W))  // Index to update
    val pcsrc = Input(UInt(1.W))    // Whether the previous instruction is taken
    val branch = Input(UInt(1.W))   // Whether the previous instruction is a branch instruction
    val btb_taken = Output(UInt(1.W)) // Prediction result
  })

  // Task 1: Define Core Registers and Constants
  val RESET_VECTOR = "h80000000".U(32.W)  // Standard RISC-V RESET_VECTOR
  val pc_reg = RegInit(RESET_VECTOR)      // PC register initialized to RESET_VECTOR
  val id_pc_reg = RegInit(0.U(32.W))      // Pipeline register for PC (decode stage)
  val inst_reg = RegInit(0.U(32.W))       // Instruction register for pipeline

  // Task 2: Implement PC Update Logic
  val next_pc = Wire(UInt(32.W))         // Wire for computing next PC, used combinationally

  // Priority-based logic for calculating next PC
  next_pc := MuxCase(pc_reg + 4.U, Seq(
    (reset.asBool) -> RESET_VECTOR,
    io.trap -> io.trap_vector,
    io.mert -> io.mert_vector,
    io.pcsrc -> io.target_pc,
    (io_bht.matched.asBool && io_bht.valid.asBool && io_btb.btb_taken.asBool) -> io_bht.bht_pred_pc
  ))

  // PC register update logic
  when (reset.asBool) {
    pc_reg := RESET_VECTOR
  }.elsewhen(!io.pc_stall) {  // Update PC if not stalled
    pc_reg := next_pc
  }

  // Task 3: Instantiate and Connect BHT Submodule
  val bht = Module(new BHT)   // Instantiate BHT submodule
  bht.io.pc := pc_reg         // Connect BHT inputs
  bht.io.mem_pc := io.mem_pc
  bht.io.pcsrc := io.pcsrc.asUInt
  bht.io.target_pc := io.target_pc

  // Connect BHT outputs
  io_bht.matched := bht.io.matched
  io_bht.valid := bht.io.valid
  io_bht.bht_pred_pc := bht.io.bht_pred_pc

  // Task 4: Instantiate and Connect BTB Submodule
  val btb = Module(new BTB)   // Instantiate BTB submodule
  btb.io.pc := pc_reg         // Connect BTB inputs
  btb.io.mem_pc := io.mem_pc
  btb.io.pcsrc := io.pcsrc.asUInt
  btb.io.branch := io.branch.asUInt

  // Connect BTB outputs
  io_btb.btb_taken := btb.io.btb_taken

  // Task 5: Implement Pipeline Register Logic
  when (reset.asBool) {
    // Reset the pipeline registers
    id_pc_reg := 0.U
    inst_reg := 0.U
  }.elsewhen(io.if_id_flush) {
    // Flush pipeline register for IF/ID stage (insert bubble)
    inst_reg := 0.U  // Insert a bubble (NOP instruction)
    id_pc_reg := pc_reg
  }.elsewhen(!io.if_id_stall) {
    // Update pipeline registers during normal operation
    id_pc_reg := pc_reg
    inst_reg := io.fetch_data
  }

  // Connect decode stage outputs
  io.id_pc := id_pc_reg
  io.inst := inst_reg

  // Task 6: Connect I/O Ports
  io.fetch_address := pc_reg
}
