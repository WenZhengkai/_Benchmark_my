// package branchpredictor

import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Prediction Interface
    val predict_valid = Input(Bool())
    val predict_pc = Input(UInt(7.W))
    val predict_taken = Output(Bool())
    val predict_history = Output(UInt(7.W))

    // Training Interface
    val train_valid = Input(Bool())
    val train_taken = Input(Bool())
    val train_mispredicted = Input(Bool())
    val train_history = Input(UInt(7.W)) // History for the branch being trained
    val train_pc = Input(UInt(7.W))

    // Reset (asynchronous active high)
    val reset = Input(Bool())
  })

  // Internal state
  val pht = RegInit(VecInit(Seq.fill(128)(2.U(2.W)))) // 128-entry table (2-bit saturating counters)
  val globalHistory = RegInit(0.U(7.W))              // Global branch history register

  // Helper functions for 2-bit saturating counter updates
  def incrementSaturatingCounter(counter: UInt): UInt = Mux(counter === 3.U, 3.U, counter + 1.U)
  def decrementSaturatingCounter(counter: UInt): UInt = Mux(counter === 0.U, 0.U, counter - 1.U)

  // XOR hash for index calculation
  def getIndex(pc: UInt, history: UInt): UInt = pc ^ history

  // === Prediction Logic === //
  val predict_index = getIndex(io.predict_pc, globalHistory) // Calculate index
  val predict_pht_entry = pht(predict_index)                // Fetch entry from PHT
  val predict_taken = predict_pht_entry(1)                  // MSB of saturating counter determines prediction

  // Outputs for prediction
  io.predict_taken := predict_taken
  io.predict_history := globalHistory

  // === Training Logic === //
  when(io.train_valid) {
    // Calculate index for the training entry
    val train_index = getIndex(io.train_pc, io.train_history)
    val train_pht_entry = pht(train_index)

    // Update PHT based on correct outcome
    pht(train_index) := Mux(
      io.train_taken,
      incrementSaturatingCounter(train_pht_entry),  // If taken, increment the counter
      decrementSaturatingCounter(train_pht_entry)  // If not taken, decrement the counter
    )

    // Update global history when recovering from misprediction
    when(io.train_mispredicted) {
      globalHistory := io.train_history
    }
  }

  // === Global History Register Update === //
  when(io.predict_valid && !(io.train_valid && io.train_mispredicted)) {
    // Update the global history register only for predictions
    globalHistory := Cat(globalHistory(5, 0), io.predict_taken)
  }

  // Reset Logic
  when(reset.asBool) {
    globalHistory := 0.U
    for (i <- 0 until 128) {
      pht(i) := 2.U // Initialize all counters to "weakly taken"
    }
  }
}

