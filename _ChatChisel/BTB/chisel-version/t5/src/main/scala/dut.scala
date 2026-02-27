import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))        // Index to predict
    val mem_pc = Input(UInt(32.W))   // Index to update
    val pcsrc = Input(UInt(1.W))     // Whether the previous instruction is taken
    val branch = Input(UInt(1.W))    // Whether the previous instruction is a branch instruction
    val btb_taken = Output(UInt(1.W))// Predict result
  })

  /***********************************************************************
   * Task 1: Define dut Storage Structure
   ***********************************************************************/
  // Create dut table using a vector of 2-bit saturating counters
  val btb_table = RegInit(VecInit(Seq.fill(16)(0.U(2.W)))) // 16 entries, all initialized to 0 (weakly not-taken)

  /***********************************************************************
   * Task 2: Implement Prediction Logic
   ***********************************************************************/
  // Extract index using bits [5:2] from PC
  val predict_idx = io.pc(5, 2)
  // Access the corresponding saturating counter in the dut table
  val predict_counter = btb_table(predict_idx)
  // Predict 'taken' if the counter value is ≥ 2 (strongly/weakly taken)
  io.btb_taken := Mux(predict_counter >= 2.U, 1.U, 0.U)

  /***********************************************************************
   * Task 3: Implement Update Logic
   ***********************************************************************/
  // Extract index using bits [5:2] from mem_pc
  val update_idx = io.mem_pc(5, 2)
  // When `branch` is asserted, update corresponding dut entry
  when(io.branch === 1.U) {
    val current_counter = btb_table(update_idx)

    // Define reusable saturating counter update logic
    def updateCounter(old: UInt, inc: Bool): UInt = {
      Mux(inc,
        Mux(old === 3.U, 3.U, old + 1.U), // Increment and saturate at 3
        Mux(old === 0.U, 0.U, old - 1.U)  // Decrement and saturate at 0
      )
    }

    // Update the counter based on `pcsrc` (taken or not-taken)
    val updated_counter = updateCounter(current_counter, io.pcsrc === 1.U)
    // Write the updated counter back into dut table
    btb_table(update_idx) := updated_counter
  }

  /***********************************************************************
   * Task 4: Saturating Counter Logic - Embedded in Task 3
   ***********************************************************************/

  /***********************************************************************
   * Task 5: Connect Clock and Reset
   ***********************************************************************/
  // dut table already wrapped with RegInit to ensure synchronous operation.
  // Reset state initializes all counters to 0 (not-taken).

  /***********************************************************************
   * Task 6: Index Handling Verification
   ***********************************************************************/
  assert(predict_idx >= 0.U && predict_idx < 16.U, "Prediction index out of range!")
  assert(update_idx >= 0.U && update_idx < 16.U, "Update index out of range!")

  /***********************************************************************
   * Task 7: Pipeline Conflict Handling
   ***********************************************************************/
  // Read-before-write logic is naturally handled here. Prediction uses 'btb_table(predict_idx)'
  // which does not directly overwrite in the same cycle.

  /***********************************************************************
   * Task 8: Reset State Verification
   ***********************************************************************/
  // Reset behavior is handled through RegInit, which initializes all entries to the weakly not-taken state (0.U).
}

// Generate Verilog for the dut module
/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
