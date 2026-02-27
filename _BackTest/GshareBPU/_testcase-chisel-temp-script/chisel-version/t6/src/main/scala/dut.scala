import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Prediction Interface
    val predict_valid    = Input(Bool())
    val predict_pc       = Input(UInt(7.W))
    val predict_taken    = Output(Bool())
    val predict_history  = Output(UInt(7.W))

    // Training Interface
    val train_valid          = Input(Bool())
    val train_taken          = Input(Bool())
    val train_mispredicted   = Input(Bool())
    val train_history        = Input(UInt(7.W))
    val train_pc             = Input(UInt(7.W))

    // Asynchronous reset
    val reset                = Input(Bool())
  })

  // Constants
  val PHT_SIZE = 128
  val COUNTER_MAX = 3.U(2.W)
  val COUNTER_MIN = 0.U(2.W)

  // Internal state
  val globalHistory = RegInit(0.U(7.W))
  val saturatingCounters = RegInit(VecInit(Seq.fill(PHT_SIZE)(2.U(2.W)))) // Initialize to weakly taken (2)

  // Hashing function: XOR PC and Global History to generate index
  def hash(pc: UInt, history: UInt): UInt = pc ^ history

  // Predict Logic - Calculate index and fetch PHT entry
  val predictIndex = hash(io.predict_pc, globalHistory)
  val predictCounter = saturatingCounters(predictIndex)
  io.predict_taken := predictCounter >= COUNTER_MAX / 2.U // Taken if counter is 2 or 3
  io.predict_history := globalHistory

  // Training Logic - Update PHT or global history based on training inputs
  when (io.train_valid) {
    val trainIndex = hash(io.train_pc, io.train_history)

    // Update History Register on misprediction
    when (io.train_mispredicted) {
      globalHistory := io.train_history // Restore to train_history after misprediction
    }.otherwise {
      // Register next state of history for correct branches
      globalHistory := Cat(globalHistory(5, 0), io.train_taken)
    }

    // Update PHT with new information about the branch
    when (io.train_taken) {
      saturatingCounters(trainIndex) := Mux(
        saturatingCounters(trainIndex) < COUNTER_MAX,
        saturatingCounters(trainIndex) + 1.U,
        COUNTER_MAX
      )
    }.otherwise {
      saturatingCounters(trainIndex) := Mux(
        saturatingCounters(trainIndex) > COUNTER_MIN,
        saturatingCounters(trainIndex) - 1.U,
        COUNTER_MIN
      )
    }
  }

  // Handle reset asynchronously (active high)
  when (io.reset) {
    globalHistory := 0.U
    saturatingCounters.foreach(counter => counter := 2.U) // Reset all PHT entries to weakly taken
  }
}

// Test Harness (Optional)
/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
