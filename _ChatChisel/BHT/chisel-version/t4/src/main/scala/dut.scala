import chisel3._
import chisel3.util._

class dutEntry extends Bundle {
  val tag = UInt(26.W)       // Stores PC[31:6]
  val valid = UInt(1.W)      // Valid bit
  val target_pc = UInt(32.W) // Branch target address
}

class dut extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))           // Current PC
    val mem_pc = Input(UInt(32.W))       // Memory-stage PC
    val pcsrc = Input(UInt(1.W))         // Branch direction signal
    val target_pc = Input(UInt(32.W))    // Resolved branch target PC
    val matched = Output(UInt(1.W))      // Match output
    val valid = Output(UInt(1.W))        // Valid output
    val bht_pred_pc = Output(UInt(32.W)) // Predicted PC
  })

  // Define storage for dut entries
  val bht = RegInit(VecInit(Seq.fill(16)(0.U.asTypeOf(new dutEntry))))

  // Extract index bits from PC
  val idx = io.pc(5, 2)
  val update_idx = io.mem_pc(5, 2)

  // Access the current dut entry
  val current_entry = bht(idx)

  // Prediction logic
  val tag_match = current_entry.tag === io.pc(31, 6)
  io.matched := tag_match
  io.valid := current_entry.valid
  io.bht_pred_pc := current_entry.target_pc

  // Update logic
  when(io.pcsrc === 1.U) {
    bht(update_idx).tag := io.mem_pc(31, 6)
    bht(update_idx).valid := 1.U
    bht(update_idx).target_pc := io.target_pc
  }
}

/*
object dutDriver extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
