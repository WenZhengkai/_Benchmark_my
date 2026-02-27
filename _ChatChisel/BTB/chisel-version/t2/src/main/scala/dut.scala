import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W)) // Index to predict
    val mem_pc = Input(UInt(32.W)) // Index to update
    val pcsrc = Input(UInt(1.W)) // Whether the previous instruction is taken
    val branch = Input(UInt(1.W)) // Whether the previous instruction is a branch instruction
    val btb_taken = Output(UInt(1.W)) // Prediction result
  })

  // Task 1: Define dut Storage Structure
  // A vector of 16 saturating counters (2-bit wide), initialized to 0.U (weakly not-taken state)
  val btb_table = RegInit(VecInit(Seq.fill(16)(0.U(2.W))))

  // Task 2: Implement Prediction Logic
  // Extract index from io.pc using bits [5:2] and access corresponding counter
  val predict_index = io.pc(5, 2)
  val predict_counter = btb_table(predict_index)
  io.btb_taken := predict_counter >= 2.U // Taken if counter value is ≥ 2 (strongly/weakly taken)

  // Task 3: Implement Update Logic
  // Extract index from io.mem_pc using bits [5:2]
  val update_index = io.mem_pc(5, 2)

  when(io.branch === 1.U) { // Update only if the previous instruction was a branch
    val old_counter = btb_table(update_index)
    val updated_counter = Mux(io.pcsrc === 1.U, // Check if branch was taken
      Mux(old_counter === 3.U, 3.U, old_counter + 1.U), // Increment and saturate at 3
      Mux(old_counter === 0.U, 0.U, old_counter - 1.U)  // Decrement and saturate at 0
    )
    btb_table(update_index) := updated_counter // Write updated counter to dut table
  }

  // Task 4: Implement Saturating Counter Logic
  def updateCounter(old: UInt, inc: Bool): UInt = {
    Mux(inc,
      Mux(old === 3.U, 3.U, old + 1.U), // Increment and saturate at 3
      Mux(old === 0.U, 0.U, old - 1.U)  // Decrement and saturate at 0
    )
  }

  // Task 5: Connect Clock and Reset
  // This module inherently operates synchronously due to the use of `RegInit`.
  // The dut table is properly wrapped with clock and reset in Chisel.

  // Task 6: Index Handling Verification
  // Add assertions to ensure indices are within bounds (0-15)
  assert(predict_index >= 0.U && predict_index < 16.U, "Predict index is out of bounds!")
  assert(update_index >= 0.U && update_index < 16.U, "Update index is out of bounds!")

  // Task 7: Pipeline Conflict Handling
  // Implement write-first policy (read uses pre-update values, update writes take effect next cycle)
  // In this implementation, read and write conflict is avoided as there is no bypass logic needed.

  // Task 8: Reset State Verification
  // On reset, all counters are initialized to 0.U (predict not-taken)
  // Already handled by `RegInit` initialization above.
}

// Generate the Verilog
/*
object dutDriver extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
