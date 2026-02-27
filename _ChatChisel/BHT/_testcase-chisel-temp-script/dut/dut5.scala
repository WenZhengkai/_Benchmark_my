import chisel3._
import chisel3.util._

/**
 * dut Module
 * Uses a 16-entry table to provide branch prediction and update functionality based on resolved branches.
 */
class dut extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))         // Program Counter (current cycle)
    val mem_pc = Input(UInt(32.W))     // Program Counter (resolved branch in memory stage)
    val pcsrc = Input(UInt(1.W))       // Signal indicating a branch taken
    val target_pc = Input(UInt(32.W))  // Resolved branch target PC
    val matched = Output(UInt(1.W))    // Indicates if a prediction is a match
    val valid = Output(UInt(1.W))      // Indicates if the dut entry is valid
    val bht_pred_pc = Output(UInt(32.W)) // Predicted PC from the dut
  })

  // Define the dut entry structure
  class dutEntry extends Bundle {
    val tag = UInt(26.W)      // Tag field (upper bits of PC)
    val valid = UInt(1.W)     // Valid bit (entry validity indicator)
    val target_pc = UInt(32.W) // Target PC (predicted branch target)
  }

  // Initialize a 16-entry dut table indexed by PC[5:2]
  val bht = RegInit(VecInit(Seq.fill(16)(0.U.asTypeOf(new dutEntry))))

  // Task 2: Prediction Logic
  // Extract index from PC: PC[5:2]
  val idx = io.pc(5, 2)

  // Retrieve the entry from the dut
  val entry = bht(idx)

  // Compare entry tag with PC[31:6]
  val tagMatch = entry.tag === io.pc(31, 6)

  // Prediction outputs
  io.matched := tagMatch
  io.valid := entry.valid
  io.bht_pred_pc := entry.target_pc

  // Task 3: Update Logic
  // Extract index from memory-stage PC: mem_pc[5:2]
  val update_idx = io.mem_pc(5, 2)

  when(io.pcsrc === 1.U) {
    // Update dut entry at update_idx
    bht(update_idx).tag := io.mem_pc(31, 6)    // Update tag
    bht(update_idx).valid := 1.U              // Mark entry as valid
    bht(update_idx).target_pc := io.target_pc // Set the target PC
  }

  // Note: Reads and writes are synchronized using registers, ensuring updates occur at the next clock edge.
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
