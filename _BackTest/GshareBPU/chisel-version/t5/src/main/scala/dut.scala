import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Prediction interface
    val predict_valid   = Input(Bool())
    val predict_pc      = Input(UInt(7.W)) // 7-bit PC
    val predict_taken   = Output(Bool())
    val predict_history = Output(UInt(7.W)) // 7-bit history
    
    // Training interface
    val train_valid        = Input(Bool())
    val train_taken        = Input(Bool())
    val train_mispredicted = Input(Bool())
    val train_history      = Input(UInt(7.W)) // 7-bit history
    val train_pc           = Input(UInt(7.W)) // 7-bit PC
    
    // Reset (asynchronous)
    val reset = Input(Bool()) // Active-high reset
  })

  // Parameters
  val PHT_SIZE = 128 // Pattern History Table size
  val COUNTER_MAX = 3.U // Two-bit saturating counter max value
  val COUNTER_MIN = 0.U // Two-bit saturating counter min value

  // Internal state
  val pht = RegInit(VecInit(Seq.fill(PHT_SIZE)(2.U(2.W)))) // Initialize PHT to weakly taken
  val global_history = RegInit(0.U(7.W)) // 7-bit global history register

  // Prediction logic
  val predict_index = io.predict_pc ^ global_history // XOR PC and global history for index
  val predict_counter = pht(predict_index)           // Access PHT entry
  val predict_taken = predict_counter >= 2.U         // Taken if counter >= 2
  io.predict_taken := predict_taken
  io.predict_history := global_history               // Expose current global history

  // Training logic
  when(io.train_valid) {
    val train_index = io.train_pc ^ io.train_history // Index calculation for training
    val train_counter = pht(train_index)

    // Update PHT counter
    when(io.train_taken) {
      pht(train_index) := Mux(train_counter === COUNTER_MAX, COUNTER_MAX, train_counter + 1.U) // Increment up to max
    }.otherwise {
      pht(train_index) := Mux(train_counter === COUNTER_MIN, COUNTER_MIN, train_counter - 1.U) // Decrement down to min
    }

    // Misprediction recovery
    when(io.train_mispredicted) {
      global_history := io.train_history // Restore global history to the correct state
    }
  }

  // Update global history on prediction
  when(io.predict_valid && !io.reset) {
    // Shift global history, append current prediction
    global_history := Cat(global_history(5, 0), predict_taken)
  }

  // Asynchronous reset
  when(io.reset) {
    global_history := 0.U
    for (i <- 0 until PHT_SIZE) {
      pht(i) := 2.U // Reset PHT to weakly taken state
    }
  }
}
