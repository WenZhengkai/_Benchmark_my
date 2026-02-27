import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))            // Current PC for prediction
    val mem_pc = Input(UInt(32.W))        // PC from memory stage (for update)
    val pcsrc = Input(UInt(1.W))          // Signals if a branch/jump is taken (update condition)
    val target_pc = Input(UInt(32.W))     // Target PC to update into dut
    val matched = Output(UInt(1.W))       // Indicates if prediction matches
    val valid = Output(UInt(1.W))         // Valid bit for the matched entry
    val bht_pred_pc = Output(UInt(32.W))  // Predicted target PC
  })

  // Task 1: Define dut entry structure and table storage
  class dutEntry extends Bundle {
    val tag = UInt(26.W)      // PC[31:6] for address matching
    val valid = UInt(1.W)     // Entry validity flag
    val target_pc = UInt(32.W) // Branch target address
  }

  val bht_table = RegInit(VecInit(Seq.fill(16)(0.U.asTypeOf(new dutEntry))))
  
  // Extract index from PC[5:2]
  val idx = io.pc(5, 2)

  // Task 2: Implement prediction logic
  val entry = bht_table(idx) // Retrieve the indexed entry
  val tag_match = entry.tag === io.pc(31, 6) // Compare PC tag with stored tag
  io.matched := tag_match
  io.valid := entry.valid
  io.bht_pred_pc := entry.target_pc

  // Task 3: Implement update logic
  val update_idx = io.mem_pc(5, 2) // Extract index from the memory-stage PC
  
  when(io.pcsrc === 1.U) { // If the branch is taken
    bht_table(update_idx).tag := io.mem_pc(31, 6)    // Update tag
    bht_table(update_idx).valid := 1.U               // Set valid bit to 1
    bht_table(update_idx).target_pc := io.target_pc  // Update target PC
  }

  // Task 4: Handle read-write synchronization (implicit due to Reg-based table)
  // - Prediction retrieves the current table state.
  // - Update logic is synchronous (applies changes on next clock edge).
}

/*
object dutMain extends App {
  // Generate Verilog code for the dut module
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
