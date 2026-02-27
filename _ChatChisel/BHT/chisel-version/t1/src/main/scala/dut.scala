import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))               // Current PC for prediction
    val mem_pc = Input(UInt(32.W))           // PC from memory stage for update
    val pcsrc = Input(UInt(1.W))             // Branch taken signal
    val target_pc = Input(UInt(32.W))        // Target PC for branch
    val matched = Output(UInt(1.W))          // Indicates if prediction matches
    val valid = Output(UInt(1.W))            // Indicates if entry is valid
    val bht_pred_pc = Output(UInt(32.W))     // Predicted PC based on dut
  })

  // Task 1: Define dut entry structure and table storage
  class dutEntry extends Bundle {
    val tag = UInt(26.W)                     // Upper PC bits [31:6]
    val valid = UInt(1.W)                    // Valid flag
    val target_pc = UInt(32.W)               // Branch target PC
  }

  val bht = RegInit(VecInit(Seq.fill(16)(0.U.asTypeOf(new dutEntry)))) // 16-entry dut table

  // Task 2: Implement prediction logic
  val idx = io.pc(5, 2)                     // Extract index from PC [5:2]
  val entry = bht(idx)                      // Retrieve indexed entry

  io.matched := entry.valid && (entry.tag === io.pc(31, 6)) // Match condition
  io.valid := entry.valid                                 // Output valid bit
  io.bht_pred_pc := entry.target_pc                       // Output predicted PC

  // Task 3: Implement update logic
  val update_idx = io.mem_pc(5, 2)          // Extract index from memory-stage PC

  when(io.pcsrc === 1.U) {                  // Taken branch condition
    bht(update_idx).tag := io.mem_pc(31, 6) // Update tag with upper bits of mem_pc
    bht(update_idx).valid := 1.U            // Set valid bit
    bht(update_idx).target_pc := io.target_pc // Update target_pc with target PC
  }

  // Task 4: Handle read-write synchronization
  // (Implicitly handled with clock-driven updates in Chisel hardware descriptions)
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
