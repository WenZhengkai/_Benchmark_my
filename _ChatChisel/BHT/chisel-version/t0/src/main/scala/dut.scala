import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))          // Current PC in the fetch stage
    val mem_pc = Input(UInt(32.W))     // PC from memory stage (for updating dut)
    val pcsrc = Input(UInt(1.W))       // Indicates branch was taken (redirection)
    val target_pc = Input(UInt(32.W))  // Target PC for the branch
    val matched = Output(UInt(1.W))    // Indicates if prediction matches the current PC
    val valid = Output(UInt(1.W))      // Validity of the predicted entry
    val bht_pred_pc = Output(UInt(32.W)) // Predicted PC
  })

  // Task 1: Define dut entry structure and storage table
  class dutEntry extends Bundle {
    val tag = UInt(26.W)       // Higher 26 bits of the PC (31:6) for address matching
    val valid = UInt(1.W)      // Validity flag
    val target_pc = UInt(32.W) // Target PC
  }

  //val bht = RegInit(VecInit(Seq.fill(16)(0.U.asTypeOf(new dutEntry)))) // 16-entry dut indexed by PC[5:2]
  val bht = Reg(Vec(16, new dutEntry))
  // Task 2: Prediction logic
  val idx = io.pc(5, 2) // Extract index using bits [5:2] of current PC
  val entry = bht(idx)  // Retrieve the corresponding dut entry

  val tag_match = entry.tag === io.pc(31, 6) // Compare tag with PC[31:6]
  io.matched := tag_match                    // Output matched signal
  io.valid := entry.valid                    // Output validity of the entry
  io.bht_pred_pc := entry.target_pc          // Output predicted target PC

  // Task 3: Update logic
  val update_idx = io.mem_pc(5, 2)           // Extract index from memory-stage PC
  val do_update = io.pcsrc === 1.U          // Update signal when branch is taken (pcsrc == 1)

  when(do_update) {
    bht(update_idx).tag := io.mem_pc(31, 6) // Update tag with mem_pc[31:6]
    bht(update_idx).valid := 1.U            // Mark entry as valid
    bht(update_idx).target_pc := io.target_pc // Write target PC to the entry
  }
}

/*
object dutDriver extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
