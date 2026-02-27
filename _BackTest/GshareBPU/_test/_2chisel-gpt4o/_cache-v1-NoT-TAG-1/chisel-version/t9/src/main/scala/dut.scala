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

  // GHR: Global History Register
  val ghr = RegInit(0.U(7.W))

  // PHT: Pattern History Table with 128 entries of 2-bit counters
  val pht_table = RegInit(VecInit(Seq.fill(128)(2.U(2.W)))) // Initialized to 2'b10 (weak taken)

  // Task 2: Prediction Interface Logic
  val predict_index = io.predict_pc ^ ghr
  val predict_counter = pht_table(predict_index)
  io.predict_taken := predict_counter(1) // MSB of the counter denotes taken or not
  io.predict_history := ghr
  val next_ghr_prediction = (ghr << 1) | io.predict_taken

  // Task 3: Training Interface Logic
  val train_index = io.train_pc ^ io.train_history
  val current_counter = pht_table(train_index)
  val updated_counter = Mux(io.train_taken,
    Mux(current_counter === 3.U, 3.U, current_counter + 1.U),
    Mux(current_counter === 0.U, 0.U, current_counter - 1.U)
  )
  when(io.train_valid) {
    pht_table(train_index) := updated_counter
  }

  val corrected_ghr = (io.train_history << 1) | io.train_taken
  val next_ghr_training = Mux(io.train_mispredicted, corrected_ghr, (ghr << 1) | io.train_taken)

  // Task 4: GHR Update Conflict Resolution
  val next_ghr = Mux(io.train_valid && io.train_mispredicted, corrected_ghr,
                 Mux(io.train_valid, next_ghr_training,
                 Mux(io.predict_valid, next_ghr_prediction, ghr)))

  // Task 5: Synchronous PHT and GHR Updates
  ghr := next_ghr
}

// To fully validate and simulate the above design, additional testbench code would be required.
// This would typically involve using Chisel's testing tools to simulate various inputs and check outputs.
