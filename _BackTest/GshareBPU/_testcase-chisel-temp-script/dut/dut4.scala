import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Prediction Ports
    val predict_valid = Input(Bool())
    val predict_pc = Input(UInt(7.W))
    val predict_taken = Output(Bool())
    val predict_history = Output(UInt(7.W))

    // Training Ports
    val train_valid = Input(Bool())
    val train_taken = Input(Bool())
    val train_mispredicted = Input(Bool())
    val train_history = Input(UInt(7.W))
    val train_pc = Input(UInt(7.W))

    // Reset Signal
    val reset = Input(AsyncReset())
  })

  // Constants
  val PHTEntries = 128 // Number of Two-bit Saturating Counters

  // Two-bit saturating counter max/min values
  val CounterMax = 3.U(2.W)
  val CounterMin = 0.U(2.W)

  // Pattern History Table (PHT)
  val pht = RegInit(VecInit(Seq.fill(PHTEntries)(1.U(2.W)))) // Start counters at weakly not taken

  // Global Branch History Register
  val globalHistory = RegInit(0.U(7.W))

  // Generate index using XOR of PC and Global History
  val predict_index = io.predict_pc ^ globalHistory
  val train_index = io.train_pc ^ io.train_history

  // Prediction Logic
  io.predict_taken := false.B
  io.predict_history := globalHistory

  when(io.predict_valid) {
    val currentCounterState = pht(predict_index)
    io.predict_taken := currentCounterState >= 2.U // Taken if counter state is >= 2
  }

  when(io.predict_valid) {
    globalHistory := Cat(globalHistory(6, 1), io.predict_taken) // Shift in predicted outcome
  }

  // Training Logic
  when(io.train_valid) {
    // Update PHT based on actual branch outcome
    val trainCounter = pht(train_index)
    pht(train_index) := Mux(
      io.train_taken,
      Mux(trainCounter === CounterMax, CounterMax, trainCounter + 1.U), // Increment if taken
      Mux(trainCounter === CounterMin, CounterMin, trainCounter - 1.U)  // Decrement if not taken
    )

    // Recover global history register if there was a misprediction
    when(io.train_mispredicted) {
      globalHistory := io.train_history
    }
  }

  // Reset logic
  when(io.reset.asBool()) {
    globalHistory := 0.U
    for (i <- 0 until PHTEntries) {
      pht(i) := 1.U // Reset all counters to weakly not taken
    }
  }
}

// Chisel Driver (optional for testing purposes)
/*
object dutDriver extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
