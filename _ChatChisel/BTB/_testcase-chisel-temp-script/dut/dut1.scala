import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))   // index to predict
    val mem_pc = Input(UInt(32.W))  // index to update
    val pcsrc = Input(UInt(1.W)) // whether previous instruction is taken
    val branch = Input(UInt(1.W)) // whether previous instruction is a branch instruction
    val btb_taken = Output(UInt(1.W)) // predicted result
  })

  // Task 1: Define dut Storage Structure
  val btb_table = RegInit(VecInit(Seq.fill(16)(0.U(2.W)))) // 16 entries, each 2-bit saturating counter

  // Task 4: Define saturating counter update utility function
  def updateCounter(old: UInt, inc: Bool): UInt = {
    Mux(inc,
      Mux(old === 3.U, 3.U, old + 1.U),
      Mux(old === 0.U, 0.U, old - 1.U)
    )
  }

  // Task 2: Implement Prediction Logic
  val pred_index = io.pc(5, 2)                           // Extracting index from io.pc
  val pred_counter = btb_table(pred_index)              // Access corresponding counter in btb_table
  io.btb_taken := Mux(pred_counter >= 2.U, 1.U, 0.U)    // Predict taken if counter value ≥ 2

  // Task 3: Implement Update Logic
  val update_index = io.mem_pc(5, 2)                    // Extract index from io.mem_pc
  when(io.branch === 1.U) {                             // If the previous instruction is a branch
    val current_counter = btb_table(update_index)       // Read current value of the counter
    val updated_counter = updateCounter(current_counter, io.pcsrc === 1.U) // Update counter based on pcsrc
    btb_table(update_index) := updated_counter          // Write updated value back to btb_table
  }
}

// Test the module with a dummy main
/*
object dutMain extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
