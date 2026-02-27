import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))         // Index to predict
    val mem_pc = Input(UInt(32.W))    // Index to update
    val pcsrc = Input(UInt(1.W))      // Whether the previous instruction is taken
    val branch = Input(UInt(1.W))     // Whether the previous instruction is a branch instruction
    val btb_taken = Output(UInt(1.W)) // Predict result
  })

  // Task 1: Define dut Storage Structure
  val btb_table = RegInit(VecInit(Seq.fill(16)(0.U(2.W)))) // 16 entries, 2-bit counters initialized to 0

  // Helper function for saturating counter updates (Task 4)
  def updateCounter(old: UInt, inc: Bool): UInt = {
    Mux(inc, 
      Mux(old === 3.U, 3.U, old + 1.U), // Increment counter (saturating at 3)
      Mux(old === 0.U, 0.U, old - 1.U)  // Decrement counter (saturating at 0)
    )
  }

  // Task 2: Implement Prediction Logic
  val predict_index = io.pc(5, 2) // Extract prediction index (4 bits from io.pc)
  val predict_counter = btb_table(predict_index) // Fetch counter value
  io.btb_taken := (predict_counter >= 2.U) // Predict taken if counter value >= 2

  // Task 3: Implement Update Logic
  when(io.branch === 1.U) { // Update dut if the instruction was a branch
    val update_index = io.mem_pc(5, 2) // Extract update index (4 bits from io.mem_pc)
    val current_counter = btb_table(update_index) // Fetch current counter value
    val updated_counter = updateCounter(current_counter, io.pcsrc === 1.U) // Update based on pcsrc
    btb_table(update_index) := updated_counter // Write back updated value to dut table
  }

  // Task 6: Index Handling Verification (Optional, for debugging in hardware simulator)
  // Assertions ensure that indices are in valid range [0-15]
  assert(RegNext(io.pc(5, 2) >= 0.U && io.pc(5, 2) <= 15.U, true.B), "Predict index out of bounds!")
  assert(RegNext(io.mem_pc(5, 2) >= 0.U && io.mem_pc(5, 2) <= 15.U, true.B), "Update index out of bounds!")
}
