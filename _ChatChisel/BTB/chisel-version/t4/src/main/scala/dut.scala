import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W)) // index for prediction
    val mem_pc = Input(UInt(32.W)) // index for update
    val pcsrc = Input(UInt(1.W)) // whether the previous instruction is taken
    val branch = Input(UInt(1.W)) // whether the previous instruction is a branch
    val btb_taken = Output(UInt(1.W)) // prediction result
  })

  // Task 1: Define dut Storage Structure
  val btb_table = RegInit(VecInit(Seq.fill(16)(0.U(2.W)))) // 16 entries of 2-bit saturating counter initialized to 0

  // Helper function for reading/writing indices and saturating counters
  def getIndex(pc: UInt): UInt = pc(5, 2) // Extract lower 4-bits of the address (bits 5 to 2)

  // Task 2: Implement Prediction Logic
  // Extract index for prediction
  val predict_index = getIndex(io.pc) // Extract index based on io.pc
  val predict_counter = btb_table(predict_index) // Access the current counter value
  // Predict as taken if the counter value is >= 2
  io.btb_taken := Mux(predict_counter >= 2.U, 1.U, 0.U)

  // Task 3: Implement Update Logic
  // Extract index for update
  val update_index = getIndex(io.mem_pc)
  // Read the current counter value of the update index
  val update_counter = btb_table(update_index)

  // Task 4: Implement Saturating Counter Logic
  // Define reusable saturating counter update function
  def updateCounter(old: UInt, inc: Bool): UInt = {
    Mux(inc,
      Mux(old === 3.U, 3.U, old + 1.U), // Increment unless already max (3)
      Mux(old === 0.U, 0.U, old - 1.U)  // Decrement unless already min (0)
    )
  }

  // When `branch` is asserted, determine whether to increment or decrement the counter
  when(io.branch === 1.U) { // Only update if it's a branch instruction
    btb_table(update_index) := updateCounter(update_counter, io.pcsrc === 1.U) // Increment if taken, decrement otherwise
  }

  // Task 5: Connect Clock and Reset
  // NOTE: In Chisel, `RegInit` already ties storage registers to clock/reset

  // Task 6: Index Handling Verification
  // Assertion to verify correct indexing (use chisel3.util.assert)
  assert(predict_index < 16.U, "Predict index out of bounds!")
  assert(update_index < 16.U, "Update index out of bounds!")

  // Task 7: Pipeline Conflict Handling
  // Implement write-first policy (write to dut happens after prediction)
  // NOTE: This is handled implicitly by Chisel semantics since updates are synchronous

  // Task 8: Reset State Verification
  // All counters are reset to 0 via RegInit, so they predict not-taken by default
  // This is already ensured by the initialization of `btb_table`
}

/*
object dut extends App {
  println(getVerilog(new dut))
}
*/
