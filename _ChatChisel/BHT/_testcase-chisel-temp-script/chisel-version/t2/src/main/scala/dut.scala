import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))            // Current PC for prediction
    val mem_pc = Input(UInt(32.W))        // Memory PC for update
    val pcsrc = Input(UInt(1.W))          // Update signal: Was a jump taken?
    val target_pc = Input(UInt(32.W))     // Target PC to branch to
    val matched = Output(UInt(1.W))       // Does the tag match?
    val valid = Output(UInt(1.W))         // Is the entry valid?
    val bht_pred_pc = Output(UInt(32.W))  // Predicted PC for next cycle
  })

  // Define dut entry structure
  class dutEntry extends Bundle {
    val tag = UInt(26.W)      // Upper bits of PC (PC[31:6])
    val valid = UInt(1.W)     // Valid bit
    val target_pc = UInt(32.W) // Target PC for branches
  }

  // dut Storage: 16 entries indexed by PC[5:2]
  val bht = RegInit(VecInit(Seq.fill(16)(0.U.asTypeOf(new dutEntry))))

  // Extract indices
  val idx = io.pc(5, 2)          // Prediction index
  val update_idx = io.mem_pc(5, 2) // Update index

  // Predict branch
  val current_entry = bht(idx)   // Fetch current entry
  io.matched := (current_entry.tag === io.pc(31, 6)) // Match tag with PC[31:6]
  io.valid := current_entry.valid                     // Output valid bit
  io.bht_pred_pc := current_entry.target_pc           // Output predicted target PC

  // Update branch history table (on clock edge)
  when(io.pcsrc === 1.U) { // If branch is taken
    val updated_entry = Wire(new dutEntry)
    updated_entry.tag := io.mem_pc(31, 6) // Update tag with mem_pc[31:6]
    updated_entry.valid := 1.U            // Set valid bit to 1
    updated_entry.target_pc := io.target_pc // Update target PC with new value
    bht(update_idx) := updated_entry
  }
}

// Generate Verilog
/*
object dutDriver extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
