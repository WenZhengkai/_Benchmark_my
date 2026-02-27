import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val predict_valid = Input(Bool())
    val predict_pc = Input(UInt(7.W))
    val predict_taken = Output(Bool())
    val predict_history = Output(UInt(7.W))

    val train_valid = Input(Bool())
    val train_taken = Input(Bool())
    val train_mispredicted = Input(Bool())
    val train_history = Input(UInt(7.W))
    val train_pc = Input(UInt(7.W))
  })

  // Define PHT and GHR
  val pht_table = RegInit(VecInit(Seq.fill(128)(1.U(2.W)))) // 128-entry table, initialized to 2'b01
  val ghr = RegInit(0.U(7.W)) // 7-bit global history register

  // Prediction Interface Logic
  val prediction_index = io.predict_pc ^ ghr // XOR to get index
  val prediction_counter = pht_table(prediction_index) // read the PHT counter
  io.predict_taken := prediction_counter(1) // MSB of counter
  io.predict_history := ghr // current GHR

  // Next GHR from prediction
  val next_ghr_prediction = (ghr << 1) | io.predict_taken

  // Training Interface Logic
  val training_index = io.train_pc ^ io.train_history // XOR for training index
  when(io.train_valid) {
    when(io.train_taken) {
      // Increment the counter if taken, saturate at 3
      pht_table(training_index) := Mux(pht_table(training_index) === 3.U, 3.U, pht_table(training_index) + 1.U)
    }.otherwise {
      // Decrement the counter if not taken, saturate at 0
      pht_table(training_index) := Mux(pht_table(training_index) === 0.U, 0.U, pht_table(training_index) - 1.U)
    }
  }

  // Compute corrected GHR for misprediction
  val corrected_ghr = (io.train_history << 1) | io.train_taken
  val next_ghr_training = Mux(io.train_mispredicted, corrected_ghr, next_ghr_prediction)

  // GHR Update Conflict Resolution
  when(io.train_valid && io.train_mispredicted) {
    ghr := corrected_ghr
  }.elsewhen(io.train_valid) {
    ghr := next_ghr_training
  }.elsewhen(io.predict_valid) {
    ghr := next_ghr_prediction
  }

  // Ensure PHT and GHR updates occur on next clock edge
  // (Implicitly handled by Chisel; updates are synchronous with the clock edge)

  // Reset logic handled by RegInit
}
