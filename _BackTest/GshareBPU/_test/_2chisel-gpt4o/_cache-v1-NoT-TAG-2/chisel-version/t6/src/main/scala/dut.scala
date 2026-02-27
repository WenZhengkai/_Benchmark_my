import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Prediction interface
    val predict_valid = Input(Bool())
    val predict_pc = Input(UInt(7.W))
    val predict_taken = Output(Bool())
    val predict_history = Output(UInt(7.W))

    // Training interface
    val train_valid = Input(Bool())
    val train_taken = Input(Bool())
    val train_mispredicted = Input(Bool())
    val train_history = Input(UInt(7.W))
    val train_pc = Input(UInt(7.W))
  })

  // Initialize PHT and GHR
  val pht_table = RegInit(VecInit(Seq.fill(128)(1.U(2.W)))) // 128 entries, each 2 bits (01: weak not taken)
  val ghr = RegInit(0.U(7.W)) // 7-bit Global History Register

  // Task 2: Prediction Interface Logic
  // Calculate prediction index and predict_taken
  val prediction_index = io.predict_pc ^ ghr
  val pht_counter = pht_table(prediction_index)
  io.predict_taken := pht_counter(1) // MSB of the counter
  io.predict_history := ghr
  val next_ghr_prediction = Cat(ghr(5, 0), io.predict_taken) // Shift left and append predict_taken

  // Task 3: Training Interface Logic
  // Calculate training index and update PHT
  val training_index = io.train_pc ^ io.train_history
  when(io.train_valid) {
    when(io.train_taken) {
      // Increment counter (saturating at 3)
      when(pht_table(training_index) =/= 3.U) {
        pht_table(training_index) := pht_table(training_index) + 1.U
      }
    }.otherwise {
      // Decrement counter (saturating at 0)
      when(pht_table(training_index) =/= 0.U) {
        pht_table(training_index) := pht_table(training_index) - 1.U
      }
    }
  }

  // Correct GHR if misprediction happened
  val corrected_ghr = Cat(io.train_history(5, 0), io.train_taken) // Shift left and append train_taken
  val next_ghr_training = Mux(io.train_mispredicted, corrected_ghr, Cat(io.train_history(5, 0), io.train_taken))

  // Task 4: GHR Update Conflict Resolution
  val next_ghr = WireDefault(ghr)
  when(io.train_valid && io.train_mispredicted) {
    next_ghr := corrected_ghr
  }.elsewhen(io.predict_valid) {
    next_ghr := next_ghr_prediction
  }

  // Task 5: Synchronous PHT and GHR Updates
  ghr := RegNext(next_ghr)

  // Task 6: Asynchronous Reset Handling
  when(reset.asBool) {
    ghr := 0.U
    for (i <- 0 until 128) {
      pht_table(i) := 1.U // "weak not taken"
    }
  }
}
