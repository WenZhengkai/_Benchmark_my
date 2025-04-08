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
    val train_history = Input(UInt(7.W))
    val train_pc = Input(UInt(7.W))
  })

  // Task 1: Define I/O Ports and Core Registers
  // Pattern History Table (PHT) initialized to 2'b01 (weak not taken)
  val pht_table = RegInit(VecInit(Seq.fill(128)(1.U(2.W))))
  // Global History Register (GHR) initialized to 0
  val ghr = RegInit(0.U(7.W))

  // Task 2: Prediction Interface Logic
  val prediction_index = io.predict_pc ^ ghr
  val predict_counter = pht_table(prediction_index)
  io.predict_taken := predict_counter(1) // MSB of the counter
  io.predict_history := ghr
  val next_ghr_prediction = Wire(UInt(7.W))
  next_ghr_prediction := (ghr << 1) | io.predict_taken

  // Task 3: Training Interface Logic
  val training_index = io.train_pc ^ io.train_history
  // Update PHT counter based on the actual outcome
  when(io.train_valid) {
    when(io.train_taken) {
      when(pht_table(training_index) =/= 3.U) {
        pht_table(training_index) := pht_table(training_index) + 1.U
      }
    }.otherwise {
      when(pht_table(training_index) =/= 0.U) {
        pht_table(training_index) := pht_table(training_index) - 1.U
      }
    }
  }
  val corrected_ghr = (io.train_history << 1) | io.train_taken

  // Task 4: GHR Update Conflict Resolution
  val next_ghr_training = Mux(io.train_mispredicted, corrected_ghr, next_ghr_prediction)
  when(io.train_valid && io.train_mispredicted) {
    ghr := corrected_ghr
  }.elsewhen(io.train_valid) {
    ghr := next_ghr_training
  }.elsewhen(io.predict_valid) {
    ghr := next_ghr_prediction
  }

  // Task 5: Synchronous PHT and GHR Updates handled by default by Chisel

  // Task 6: Asynchronous Reset Handling
  // In Chisel, reset handling is integrated with RegInit for synchronous reset logic

  // Task 7: Concurrent Training/Prediction Edge Cases handled by ensuring correct logic usage
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
