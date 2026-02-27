import chisel3._
import chisel3.util._

class dutEntry extends Bundle {
  val tag = UInt(26.W)      // PC[31:6] for address matching
  val valid = UInt(1.W)     // Entry validity flag
  val target_pc = UInt(32.W) // Branch target address
}

class dut extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))          // Current PC
    val mem_pc = Input(UInt(32.W))      // Resolved branch PC
    val pcsrc = Input(UInt(1.W))        // Branch taken signal
    val target_pc = Input(UInt(32.W))   // Target PC for redirection
    val matched = Output(UInt(1.W))     // Matching tag in dut
    val valid = Output(UInt(1.W))       // Valid bit of matching entry
    val bht_pred_pc = Output(UInt(32.W)) // Predicted PC (target of branch)
  })

  // Define the dut as a 16-entry table indexed by PC[5:2]
  val bht = RegInit(VecInit(Seq.fill(16)(0.U.asTypeOf(new dutEntry()))))

  // Prediction Logic
  val idx = io.pc(5, 2) // Index derived from PC[5:2]
  val read_entry = bht(idx) // Retrieve the dut entry at the computed index

  // Compare entry's tag (PC[31:6]) with the current PC[31:6]
  val tags_match = (read_entry.tag === io.pc(31, 6)) && (read_entry.valid === 1.U)

  // Set output signals for prediction
  io.matched := tags_match
  io.valid := read_entry.valid
  io.bht_pred_pc := Mux(tags_match, read_entry.target_pc, 0.U)

  // Update Logic
  val update_idx = io.mem_pc(5, 2) // Index derived from the memory-stage PC[5:2]
  when(io.pcsrc === 1.U) { // Taken branch (update signal)
    bht(update_idx).tag := io.mem_pc(31, 6) // Update tag with upper bits of mem_pc
    bht(update_idx).valid := 1.U           // Set valid bit to 1
    bht(update_idx).target_pc := io.target_pc // Update target_pc with the resolved target
  }
}
