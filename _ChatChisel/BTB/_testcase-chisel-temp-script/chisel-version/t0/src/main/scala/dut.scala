import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))        // Index to update
    val mem_pc = Input(UInt(32.W))    // Index to predict
    val pcsrc = Input(UInt(1.W))      // Did previous instruction branch (taken)?
    val branch = Input(UInt(1.W))     // Was previous instruction a branch instruction?
    val btb_taken = Output(UInt(1.W)) // Predicted result
  })

  // Task 1: Define dut Storage Structure
  // Create a vector of 16 saturating 2-bit counters initialized to 0 (weakly not taken)
  val btb_table = RegInit(VecInit(Seq.fill(16)(0.U(2.W))))

  // Internal function for saturating counter logic
  def updateCounter(old: UInt, inc: Bool): UInt = {
    Mux(inc,
      Mux(old === 3.U, 3.U, old + 1.U),  // Increment with saturation at 3
      Mux(old === 0.U, 0.U, old - 1.U)   // Decrement with saturation at 0
    )
  }

  // Task 2: Implement Prediction Logic
  // Extract index for prediction using bits [5:2] of `io.pc`
  val predict_index = io.pc(5, 2)
  val predict_counter = btb_table(predict_index) // Access the corresponding counter

  // If the counter value >= 2, predict taken (io.btb_taken = 1), otherwise not-taken
  io.btb_taken := Mux(predict_counter >= 2.U, 1.U, 0.U)

  // Task 3: Implement Update Logic
  // Extract index for update using bits [5:2] of `io.mem_pc`
  val update_index = io.mem_pc(5, 2)
  when(io.branch === 1.U) {
    // Only update dut when the instruction is confirmed to be a branch
    val current_counter = btb_table(update_index)
    val updated_counter = updateCounter(current_counter, io.pcsrc.asBool)
    btb_table(update_index) := updated_counter // Write the updated counter value
  }

  // Task 6: Index Handling Verification
  // Add optional assertions for index bounds
  assert(predict_index < 16.U, "Predict index out of bounds")
  assert(update_index < 16.U, "Update index out of bounds")

  // Reset state verification logic (initialize counters to zero is done in RegInit above)
}
