import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val pc       = Input(UInt(32.W))  // index to predict
    val mem_pc   = Input(UInt(32.W))  // index to update
    val pcsrc    = Input(UInt(1.W))   // whether the previous instruction is taken
    val branch   = Input(UInt(1.W))   // whether the previous instruction is a branch instruction
    val btb_taken = Output(UInt(1.W)) // predict result
  })

  // Task 1: Define dut Storage Structure
  val btb_table = RegInit(VecInit(Seq.fill(16)(0.U(2.W)))) // 16 entries of 2-bit counters

  // Helper Function: Saturating Counter Update Logic (Task 4)
  def updateCounter(old: UInt, inc: Bool): UInt = {
    Mux(inc, 
      Mux(old === 3.U, 3.U, old + 1.U),  // Increment but saturate at 3
      Mux(old === 0.U, 0.U, old - 1.U)) // Decrement but saturate at 0
  }

  // Task 2: Implement Prediction Logic
  val pc_index = io.pc(5, 2) // Extract index from bits [5:2] of pc
  val predict_counter = btb_table(pc_index) // Read the corresponding dut entry
  io.btb_taken := predict_counter >= 2.U // Taken if counter value >= 2

  // Task 3: Implement Update Logic
  val update_index = io.mem_pc(5, 2) // Extract index from bits [5:2] of mem_pc
  when(io.branch === 1.U) { // Update only if the instruction is a branch
    val current_counter = btb_table(update_index) // Read current counter value
    val updated_counter = updateCounter(current_counter, io.pcsrc === 1.U) // Update based on pcsrc
    btb_table(update_index) := updated_counter // Write back the updated value
  }

  // Optional: Add Assertions for Index Handling Verification (Task 6)
  assert(pc_index < 16.U, "dut prediction index out of bounds (0-15)") // Check prediction index bounds
  assert(update_index < 16.U, "dut update index out of bounds (0-15)") // Check update index bounds

  // Task 5: Clock and Reset are handled implicitly by Chisel
  // Task 8: All entries are initialized to 0.U during reset, as part of RegInit above.
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
