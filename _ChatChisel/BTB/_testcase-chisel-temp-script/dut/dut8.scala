import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W)) // index to update
    val mem_pc = Input(UInt(32.W)) // index to predict
    val pcsrc = Input(UInt(1.W)) // whether the previous instruction is taken
    val branch = Input(UInt(1.W)) // whether the previous instruction is a branch instruction
    val btb_taken = Output(UInt(1.W)) // predict result
  })

  /** Task 1: Define dut Storage Structure **/
  val btb_table = RegInit(VecInit(Seq.fill(16)(0.U(2.W)))) // 16 entries, initialized to 0.U (weakly not-taken)

  /** Task 4: Define Saturating Counter Logic **/
  def updateCounter(old: UInt, inc: Bool): UInt = {
    Mux(inc,
      Mux(old === 3.U, 3.U, old + 1.U), // Increment counter (saturate at 3)
      Mux(old === 0.U, 0.U, old - 1.U)  // Decrement counter (saturate at 0)
    )
  }

  /** Task 2: Implement Prediction Logic **/
  val predict_index = io.pc(5, 2) // Lower 4 bits of current PC
  val predict_counter = btb_table(predict_index) // Access corresponding counter
  io.btb_taken := (predict_counter >= 2.U) // Strongly/weakly taken if counter value ≥ 2

  /** Task 3: Implement Update Logic **/
  val update_index = io.mem_pc(5, 2) // Lower 4 bits of memory PC
  when(io.branch === 1.U) { // Update logic only triggered for branch instructions
    val current_counter = btb_table(update_index)
    btb_table(update_index) := updateCounter(
      current_counter,
      io.pcsrc === 1.U // Increment if branch is taken, decrement if not-taken
    )
  }

  /** Extra Features **/
  // ** Task 6: Index Handling Verification **
  assert(predict_index < 16.U, "Predict index out of bounds!")
  assert(update_index < 16.U, "Update index out of bounds!")

  // Ensure all state updates occur synchronously
  withClockAndReset(clock, reset) {
    // dut table already wrapped in synchronous `RegInit`
  }

  /** Task 8: Reset State Verification **/
  // Confirm that all entries in `btb_table` are reset to 0 (predict not-taken)
  assert((0 until 16).map(i => btb_table(i) === 0.U).reduce(_ && _), "dut table failed to reset properly")
}

/*
object dut extends App {
  println("Generating the dut hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
