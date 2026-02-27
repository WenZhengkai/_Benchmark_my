import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))     // Index to predict
    val mem_pc = Input(UInt(32.W)) // Index to update
    val pcsrc = Input(UInt(1.W))   // Whether the previous instruction is taken
    val branch = Input(UInt(1.W))  // Whether the previous instruction is a branch instruction
    val btb_taken = Output(UInt(1.W)) // Predict result
  })

  // Task 1: Define dut storage structure
  val btb_table = RegInit(VecInit(Seq.fill(16)(0.U(2.W)))) // 16-entry, 2-bit saturating counters initialized to 0

  // Helper function for saturating counter update (Task 4)
  def updateCounter(old: UInt, inc: Bool): UInt = {
    Mux(inc, 
      Mux(old === 3.U, 3.U, old + 1.U),  // Increment, saturate at 3
      Mux(old === 0.U, 0.U, old - 1.U)   // Decrement, saturate at 0
    )
  }

  // Task 2: Implement prediction logic
  val predict_index = io.pc(5, 2)           // Use bits 5:2 from PC for indexing
  val predict_entry = btb_table(predict_index) // Fetch corresponding entry in dut table
  io.btb_taken := Mux(predict_entry >= 2.U, 1.U, 0.U) // Predict taken if counter value >= 2

  // Task 3: Implement update logic
  val update_index = io.mem_pc(5, 2)        // Use bits 5:2 from mem_pc for indexing
  val current_counter = btb_table(update_index)
  when(io.branch === 1.U) {                 // Perform update only if previous instruction was a branch
    val updated_counter = updateCounter(current_counter, io.pcsrc === 1.U) // Update counter based on taken (pcsrc)
    btb_table(update_index) := updated_counter // Write updated value back to dut table
  }

  // Optional Assertions for Index Handling Verification (Task 6)
  assert(predict_index >= 0.U && predict_index < 16.U, "Invalid prediction index")
  assert(update_index >= 0.U && update_index < 16.U, "Invalid update index")

  // Task 8: Reset State Verification
  // All entries in dut initialize to 0 (weakly not-taken). This is ensured by the `RegInit` statement above.

  // Notes:
  // Any pipeline conflict handling or bypass logic can be added depending on the broader processor design.
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
