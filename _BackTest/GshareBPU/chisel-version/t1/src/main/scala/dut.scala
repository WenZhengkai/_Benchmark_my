import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Prediction interface
    val predict_valid   = Input(Bool())
    val predict_pc      = Input(UInt(7.W))
    val predict_taken   = Output(Bool())
    val predict_history = Output(UInt(7.W))

    // Training interface
    val train_valid       = Input(Bool())
    val train_taken       = Input(Bool())
    val train_mispredicted = Input(Bool())
    val train_history     = Input(UInt(7.W))
    val train_pc          = Input(UInt(7.W))

    // asynchronous reset
    val reset = Input(Bool())
  })

  // Constants
  val PHT_SIZE = 128 // Number of entries in the Pattern History Table (PHT)

  // The PHT consists of 128 entries of 2-bit saturating counters
  val pht = RegInit(VecInit(Seq.fill(PHT_SIZE)(1.U(2.W)))) // Start counters at 1 (weakly taken)

  // Global branch history register
  val globalBranchHistory = RegInit(0.U(7.W))

  // Generate index for PHT lookup using XOR of PC and global history
  def generateIndex(pc: UInt, history: UInt): UInt = {
    pc ^ history
  }

  // PREDICTION LOGIC
  val predict_index = generateIndex(io.predict_pc, globalBranchHistory)
  val predict_pht_value = pht(predict_index)
  io.predict_taken := predict_pht_value >= 2.U // Predict taken if PHT value is 2 or 3
  io.predict_history := globalBranchHistory

  // TRAINING LOGIC
  when(io.train_valid) {
    val train_index = generateIndex(io.train_pc, io.train_history)
    val train_pht_value = pht(train_index)

    // Update the PHT entry based on branch outcome
    when(io.train_taken) {
      // Increment the counter if the branch is taken (saturation at 3)
      pht(train_index) := Mux(train_pht_value === 3.U, 3.U, train_pht_value + 1.U)
    }.otherwise {
      // Decrement the counter if the branch is not taken (saturation at 0)
      pht(train_index) := Mux(train_pht_value === 0.U, 0.U, train_pht_value - 1.U)
    }

    // If a mispredicted branch is being trained, recover the global branch history register
    when(io.train_mispredicted) {
      globalBranchHistory := io.train_history
    }
  }

  // Prediction-valid logic updates the global branch history register on a prediction
  when(io.predict_valid && !io.train_valid) {
    globalBranchHistory := Cat(globalBranchHistory(5, 0), io.predict_taken)
  }

  // Asynchronous reset logic
  when(io.reset) {
    globalBranchHistory := 0.U
    for (i <- 0 until PHT_SIZE) {
      pht(i) := 1.U
    }
  }
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
