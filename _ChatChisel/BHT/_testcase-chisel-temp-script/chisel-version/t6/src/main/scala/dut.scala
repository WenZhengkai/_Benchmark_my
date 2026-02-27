import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))                // Current PC for prediction
    val mem_pc = Input(UInt(32.W))            // Memory PC for update
    val pcsrc = Input(UInt(1.W))              // Redirect signal (1 = taken branch)
    val target_pc = Input(UInt(32.W))         // The target PC of the branch
    val matched = Output(UInt(1.W))           // Whether the prediction matched
    val valid = Output(UInt(1.W))             // Valid flag from the prediction entry
    val bht_pred_pc = Output(UInt(32.W))      // Predicted target PC
  })

  // Task 1: Define dut entry structure and storage
  class dutEntry extends Bundle {
    val tag = UInt(26.W)     // High bits of PC [31:6]
    val valid = UInt(1.W)    // Valid bit
    val target_pc = UInt(32.W) // Target PC
  }

  // Create a 16-entry dut table indexed by PC bits [5:2]
  val bht = RegInit(VecInit(Seq.fill(16)(0.U.asTypeOf(new dutEntry))))

  // Task 2: Prediction logic
  val idx = io.pc(5, 2)       // Index from current PC
  val entry = bht(idx)        // Fetch dut entry at `idx`
  val tag_match = entry.tag === io.pc(31, 6) // Check for tag match

  io.matched := tag_match     // Matched if tag matches
  io.valid := entry.valid     // Output valid bit
  io.bht_pred_pc := entry.target_pc // Output the predicted target PC

  // Task 3: Update logic
  val update_idx = io.mem_pc(5, 2) // Index from memory PC

  when(io.pcsrc === 1.U) {
    // For a taken branch:
    val update_entry = Wire(new dutEntry)
    update_entry.tag := io.mem_pc(31, 6)     // Upper bits of `mem_pc`
    update_entry.valid := 1.U                // Mark the entry as valid
    update_entry.target_pc := io.target_pc   // Update branch target PC

    bht(update_idx) := update_entry          // Update the entry in the table
  }

  // Task 4: Handle read-write synchronization
  // (Register updates already handle this correctly)

}
