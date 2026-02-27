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

  // Define core registers and storage
  val pht_table = RegInit(VecInit(Seq.fill(128)(2.U(2.W)))) // 128-entry PHT initialized to "weakly taken"
  val ghr = RegInit(0.U(7.W)) // 7-bit global history register

  // Task 2: Prediction Interface Logic
  val predict_index = io.predict_pc ^ ghr // XOR pc and ghr to get the index
  val predict_counter = Mux(io.predict_valid, pht_table(predict_index), 0.U) // Read PHT only if valid
  io.predict_taken := predict_counter(1) // MSB of the counter determines the taken/not-taken prediction
  io.predict_history := ghr // Output current GHR for prediction
  val next_ghr_prediction = (ghr << 1) | io.predict_taken // Update GHR prediction

  // Task 3: Training Interface Logic
  val train_index = io.train_pc ^ io.train_history // XOR pc and history to compute training index
  val updated_train_counter = Wire(UInt(2.W))
  when(io.train_valid) {
    when(io.train_taken) {
      // Increment counter if taken, saturate at 3
      updated_train_counter := Mux(pht_table(train_index) === 3.U, 3.U, pht_table(train_index) + 1.U)
    }.otherwise {
      // Decrement counter if not taken, saturate at 0
      updated_train_counter := Mux(pht_table(train_index) === 0.U, 0.U, pht_table(train_index) - 1.U)
    }
    pht_table(train_index) := updated_train_counter // Write updated counter back to the PHT
  }

  // Handle misprediction recovery
  val corrected_ghr = (io.train_history << 1) | io.train_taken // Correct GHR for misprediction
  val next_ghr_training = Mux(io.train_mispredicted, corrected_ghr, next_ghr_prediction)

  // Task 4: GHR Update Conflict Resolution
  when(io.train_valid && io.train_mispredicted) {
    ghr := corrected_ghr // Train and recover GHR on misprediction
  }.elsewhen(io.train_valid) {
    ghr := next_ghr_training // Update GHR with training result
  }.elsewhen(io.predict_valid) {
    ghr := next_ghr_prediction // Update GHR with prediction result
  }

  // Task 1: Asynchronous Reset Handling
  when(reset.asBool()) {
    ghr := 0.U // Reset GHR to 0
    for (i <- 0 until 128) {
      pht_table(i) := 2.U // Reset PHT entries to "weakly taken"
    }
  }
}
