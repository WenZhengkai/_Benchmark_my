import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))
    val mem_pc = Input(UInt(32.W))
    val pcsrc = Input(UInt(1.W))
    val target_pc = Input(UInt(32.W))
    val matched = Output(UInt(1.W))
    val valid = Output(UInt(1.W))
    val bht_pred_pc = Output(UInt(32.W))
  })

  // Task 1: Define dut entry structure and table storage
  class dutEntry extends Bundle {
    val tag = UInt(26.W)       // PC[31:6] for address matching
    val valid = UInt(1.W)      // Valid bit for the entry
    val target_pc = UInt(32.W) // Target PC for branches
  }

  // A 16-entry dut, indexed by pc(5:2)
  val bht = RegInit(VecInit(Seq.fill(16)(0.U.asTypeOf(new dutEntry))))

  // Default outputs
  io.matched := 0.U
  io.valid := 0.U
  io.bht_pred_pc := 0.U

  // --- Task 2: Implement prediction logic ---
  val idx = io.pc(5, 2)          // Extract index using PC[5:2]
  val current_entry = bht(idx)   // Retrieve the dut entry
  val tag_match = current_entry.tag === io.pc(31, 6) // Compare tags

  // Prediction outputs
  when(tag_match) {
    io.matched := 1.U
    io.valid := current_entry.valid
    io.bht_pred_pc := current_entry.target_pc
  }

  // --- Task 3: Implement update logic ---
  val update_idx = io.mem_pc(5, 2) // Extract update index from mem_pc
  when(io.pcsrc === 1.U) {         // When branch is taken
    bht(update_idx).tag := io.mem_pc(31, 6) // Update tag
    bht(update_idx).valid := 1.U            // Set valid bit
    bht(update_idx).target_pc := io.target_pc // Update target PC
  }
}
