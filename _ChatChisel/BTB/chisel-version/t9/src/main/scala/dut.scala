import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))       // index to predict
    val mem_pc = Input(UInt(32.W))  // index to update
    val pcsrc = Input(UInt(1.W))    // whether the previous instruction was taken
    val branch = Input(UInt(1.W))   // whether the previous instruction was a branch
    val btb_taken = Output(UInt(1.W)) // predict result
  })

  // Task 1: Define dut Storage Structure
  val btb_table = RegInit(VecInit(Seq.fill(16)(0.U(2.W)))) // 16 entries, each 2-bit counter

  // Utility function: Saturating Counter Update (Task 4)
  def updateCounter(old: UInt, inc: Bool): UInt = {
    Mux(inc, 
      Mux(old === 3.U, 3.U, old + 1.U),
      Mux(old === 0.U, 0.U, old - 1.U)
    )
  }

  // Task 2: Implement Prediction Logic
  val pc_index = io.pc(5, 2) // Extract index (bits 5 to 2 of pc)
  val pc_counter = btb_table(pc_index) // Read the corresponding counter
  io.btb_taken := Mux(pc_counter >= 2.U, 1.U, 0.U) // Predict taken if counter is 2 or 3

  // Task 3: Implement Update Logic
  val mem_pc_index = io.mem_pc(5, 2) // Extract index for update (bits 5 to 2 of mem_pc)
  when(io.branch === 1.U) {
    val current_counter = btb_table(mem_pc_index) // Read current counter value
    val updated_counter = updateCounter(current_counter, io.pcsrc === 1.U) // Update counter
    btb_table(mem_pc_index) := updated_counter // Write back updated counter
  }

  // Task 5: Clock and Reset (Handled Implicitly in Chisel)
  // Registers are reset to 0 via RegInit during module initialization.

  // Task 6: Index Handling Verification
  assert(pc_index >= 0.U && pc_index < 16.U, "PC index out of bounds!")
  assert(mem_pc_index >= 0.U && mem_pc_index < 16.U, "mem_pc index out of bounds!")

  // Task 7: Pipeline Conflict Handling
  // In this basic dut, we use a write-first policy:
  // Predictions use pre-update values; updates take effect in the next cycle.

  // Task 8: Reset State Verification
  // All counters are initialized to 0 using RegInit(VecInit(Seq.fill(16)(0.U(2.W)))), predicting not-taken on reset.
}

// Generate the Verilog for the dut module
/*
object dutGen extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
