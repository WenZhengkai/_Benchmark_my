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
    val train_valid         = Input(Bool())
    val train_taken         = Input(Bool())
    val train_mispredicted  = Input(Bool())
    val train_history       = Input(UInt(7.W))
    val train_pc            = Input(UInt(7.W))
  })

  // Task 1: Define I/O Ports and Core Registers
  // Initialize PHT (Pattern History Table) -- 128 entries of 2-bit saturating counters.
  val pht_table = RegInit(VecInit(Seq.fill(128)(1.U(2.W)))) // 2'b01 = weak not taken

  // Initialize GHR (Global History Register) -- 7-bit shift-register.
  val ghr = RegInit(0.U(7.W))

  // Task 2: Prediction Interface Logic
  // Calculate the index for the PHT table by XORing PC with GHR (7 bits).
  val prediction_index = io.predict_pc ^ ghr

  // Read the PHT counter associated with the index.
  val pht_counter = pht_table(prediction_index)

  // Determine the prediction outcome based on the MSB of the counter value.
  io.predict_taken := pht_counter(1) // MSB of PHT counter determines "taken" or "not taken".
  io.predict_history := ghr

  // Compute the next state of the GHR assuming prediction.
  val next_ghr_prediction = Cat(ghr(5, 0), io.predict_taken)

  // Task 3: Training Interface Logic
  // Calculate the training index for the PHT table using XOR of train_pc and train_history.
  val training_index = io.train_pc ^ io.train_history

  // Update policy for PHT counter.
  val updated_pht_counter = Wire(UInt(2.W))
  when(io.train_taken) {
    // If the branch was actually taken, increment the counter (saturating at 3).
    updated_pht_counter := Mux(pht_table(training_index) === 3.U, 3.U, pht_table(training_index) + 1.U)
  }.otherwise {
    // If the branch was not taken, decrement the counter (saturating at 0).
    updated_pht_counter := Mux(pht_table(training_index) === 0.U, 0.U, pht_table(training_index) - 1.U)
  }

  // Update the PHT table if training is valid.
  when(io.train_valid) {
    pht_table(training_index) := updated_pht_counter
  }

  // Compute the corrected GHR on misprediction.
  val corrected_ghr = Cat(io.train_history(5, 0), io.train_taken)

  // Select the next GHR value during training.
  val next_ghr_training = Mux(io.train_mispredicted, corrected_ghr, Cat(io.train_history(5, 0), io.train_taken))

  // Task 4: GHR Update Conflict Resolution
  // Priority mux to resolve GHR updates.
  val next_ghr = Wire(UInt(7.W))
  when(io.train_valid && io.train_mispredicted) {
    next_ghr := corrected_ghr
  }.elsewhen(io.train_valid) {
    next_ghr := next_ghr_training
  }.elsewhen(io.predict_valid) {
    next_ghr := next_ghr_prediction
  }.otherwise {
    next_ghr := ghr
  }

  // Task 5: Synchronous PHT and GHR Updates
  // Update GHR on the next clock edge.
  ghr := next_ghr

  // Task 6: Asynchronous Reset Handling
  // The reset logic for GHR and PHT is handled in `RegInit`.

  // Task 7: Concurrent Training/Prediction Edge Cases
  // Ensure predictions read the PHT directly and reflect training in the next cycle.
  // This is inherently handled since PHT updates occur via `pht_table := updated_pht_counter`.
}
