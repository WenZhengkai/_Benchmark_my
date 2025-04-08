import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Prediction Interface
    val predict_valid   = Input(Bool())
    val predict_pc      = Input(UInt(7.W))
    val predict_taken   = Output(Bool())
    val predict_history = Output(UInt(7.W))

    // Training Interface
    val train_valid     = Input(Bool())
    val train_taken     = Input(Bool())
    val train_mispredicted = Input(Bool())
    val train_history   = Input(UInt(7.W))
    val train_pc        = Input(UInt(7.W))
  })

  // Task 1: Define I/O Ports and Core Registers

  // Pattern History Table (PHT) -- 128-entry 2-bit counters initialized to weak not taken (01)
  val pht_table = RegInit(VecInit(Seq.fill(128)(1.U(2.W))))

  // Global History Register (GHR) -- 7-bit register initialized to 0
  val ghr = RegInit(0.U(7.W))

  // Task 2: Prediction Interface Logic
  val predict_index = io.predict_pc ^ ghr
  val predict_counter = pht_table(predict_index)

  io.predict_taken := predict_counter(1)   // MSB of the counter
  io.predict_history := ghr
  val next_ghr_prediction = (ghr << 1) | io.predict_taken

  // Task 3: Training Interface Logic
  val train_index = io.train_pc ^ io.train_history

  // Update PHT counter based on training
  when(io.train_valid) {
    when(io.train_taken) {
      // Increment the counter (saturate at 3)
      when(pht_table(train_index) =/= 3.U) {
        pht_table(train_index) := pht_table(train_index) + 1.U
      }
    }.otherwise {
      // Decrement the counter (saturate at 0)
      when(pht_table(train_index) =/= 0.U) {
        pht_table(train_index) := pht_table(train_index) - 1.U
      }
    }
  }

  // Compute corrected GHR and next GHR for training logic
  val corrected_ghr = (io.train_history << 1) | io.train_taken
  val next_ghr_training = Mux(io.train_mispredicted, corrected_ghr, next_ghr_prediction)

  // Task 4: GHR Update Conflict Resolution
  when(io.train_valid && io.train_mispredicted) {
    ghr := corrected_ghr
  }.elsewhen(io.train_valid) {
    ghr := next_ghr_training
  }.elsewhen(io.predict_valid) {
    ghr := next_ghr_prediction
  }

  // Task 6: Asynchronous Reset Handling already handled by RegInit

  // Task 7: Ensure old PHT state is used for prediction even if updated in same cycle
  // This feedback logic ensures that training influence is scheduled for the next cycle and doesn't affect the current prediction directly.

  // The direct read for prediction logic; updates will reflect in the subsequent cycle.
}

