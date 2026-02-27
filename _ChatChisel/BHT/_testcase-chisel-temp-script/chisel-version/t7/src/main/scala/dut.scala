import chisel3._
import chisel3.util._

class dutBundle extends Bundle {
  val tag = UInt(26.W) // Upper bits of PC[31:6] to match
  val valid = UInt(1.W) // Entry validity flag
  val target_pc = UInt(32.W) // Branch target address
}

class dut extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))         // Current PC for prediction
    val mem_pc = Input(UInt(32.W))     // PC from memory stage for update
    val pcsrc = Input(UInt(1.W))       // Branch taken signal
    val target_pc = Input(UInt(32.W))  // Target PC for branch
    val matched = Output(UInt(1.W))    // Indicates a match on prediction
    val valid = Output(UInt(1.W))      // Indicates entry is valid
    val bht_pred_pc = Output(UInt(32.W)) // Predicted branch target PC
  })
  
  // Task 1: Define dut entry structure and create table storage
  val bht = RegInit(VecInit(Seq.fill(16)(0.U.asTypeOf(new dutBundle)))) // 16-entry dut initialized to zero
  
  // Task 2: Prediction logic
  val idx = io.pc(5, 2) // Use PC[5:2] as the index for the table
  val current_entry = bht(idx) // Access the current dut entry based on the index
  
  io.matched := (current_entry.tag === io.pc(31, 6)) && current_entry.valid.asBool // Match if tags equal and entry valid
  io.valid := current_entry.valid // Output validity of the entry
  io.bht_pred_pc := current_entry.target_pc // Predicted target PC from the entry
  
  // Task 3: Update logic
  val update_idx = io.mem_pc(5, 2) // Index for update using mem_pc
  when(io.pcsrc === 1.U) { // Perform an update on branch taken
    bht(update_idx).tag := io.mem_pc(31, 6) // Update tag with upper bits of mem_pc
    bht(update_idx).valid := 1.U // Set entry as valid
    bht(update_idx).target_pc := io.target_pc // Update the target PC with resolved branch target
  }
  
  // Task 4: Handle read-write synchronization
  // No specific forwarding handling is required since updates apply synchronously
}

/*
object dutMain extends App {
  println("Generating the dut hardware...")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
