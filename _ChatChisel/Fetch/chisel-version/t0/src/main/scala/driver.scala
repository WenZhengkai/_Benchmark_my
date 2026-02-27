import chisel3._
import chisel3.util._
// Generate the Verilog code
class BHT extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))
    val mem_pc = Input(UInt(32.W))
    val pcsrc = Input(UInt(1.W))
    val target_pc = Input(UInt(32.W))
    val matched = Output(UInt(1.W))
    val valid = Output(UInt(1.W))
    val bht_pred_pc = Output(UInt(32.W))
  })

  val numEntries = 16
  val tagWidth = 26

  class BHTEntry extends Bundle {
    val tag = UInt(tagWidth.W)
    val valid = UInt(1.W)
    val target_pc = UInt(32.W)
  }

  val bhtTable = Mem(numEntries, new BHTEntry)


  val index = io.pc(5, 2)

  val bhtEntry = bhtTable.read(index)

  io.matched := bhtEntry.tag === io.pc(31, 6)
  io.valid := bhtEntry.valid
  io.bht_pred_pc := bhtEntry.target_pc

  when(io.pcsrc === 1.U) {
    val newEntry = Wire(new BHTEntry)
    newEntry.tag := io.mem_pc(31, 6)
    newEntry.valid := 1.U
    newEntry.target_pc := io.target_pc
    bhtTable.write(io.mem_pc(5,2), newEntry)
  }
}

class BTB extends Module {
  val io = IO(new Bundle {
    val pc = Input(UInt(32.W))      // Index to predict
    val mem_pc = Input(UInt(32.W))  // Index to update
    val pcsrc = Input(UInt(1.W))    // Whether the previous instruction is taken
    val branch = Input(UInt(1.W))   // Whether the previous instruction is a branch instruction
    val btb_taken = Output(UInt(1.W)) // Prediction result
  })

  // Define the BTB table with 16 entries (indexed by the lower 4 bits of pc)
  val btbTable = Mem(16, UInt(2.W))

  // 在模块初始化时写入值
  when (reset.asBool) {
    for (i <- 0 until 16) {
      btbTable.write(i.U, 0.U)  // 初始化每个地址为其索引值
    }
  }

  // Read the BTB table at the index specified by mem_pc
  val btbEntry = btbTable(io.pc(5, 2))

  // Predict the target based on the saturating counter value
  val btbPredict = btbEntry(1)

  // Update the BTB table when a branch instruction is encountered
  when(io.branch === 1.U) {
    when(io.pcsrc === 1.U) {
      // If the branch is taken, increment the saturating counter
      when(btbTable(io.mem_pc(5, 2)) < 3.U) {
        btbTable.write(io.mem_pc(5, 2), btbTable(io.mem_pc(5, 2)) + 1.U)
      }
    }.otherwise {
      // If the branch is not taken, decrement the saturating counter
      when(btbTable(io.mem_pc(5, 2)) > 0.U) {
        btbTable.write(io.mem_pc(5, 2), btbTable(io.mem_pc(5, 2)) - 1.U)
      }
    }
  }
  // Output the prediction result
  io.btb_taken := btbPredict
}



object Driver extends App {
  val dir = "../../_test/_cache/t0"
  emitVerilog(new dut(), Array("--target-dir", dir))
}

