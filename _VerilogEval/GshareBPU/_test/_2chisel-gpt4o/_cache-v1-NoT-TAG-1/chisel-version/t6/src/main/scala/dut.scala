import chisel3._
import chisel3.util._

// Define input/output port bundle
class dut_IO extends Bundle {
  // Prediction interface
  val predict_valid     = Input(Bool())
  val predict_pc        = Input(UInt(7.W))
  val predict_taken     = Output(Bool())
  val predict_history   = Output(UInt(7.W))

  // Training interface
  val train_valid       = Input(Bool())
  val train_taken       = Input(Bool())
  val train_mispredicted= Input(Bool())
  val train_history     = Input(UInt(7.W))
  val train_pc          = Input(UInt(7.W))
}

// Gshare branch predictor module
class dut extends Module {
  val io = IO(new dut_IO)

  // Task 1: Define core registers
  // 128-entry PHT (Pattern History Table) initialized to 'weak taken' (2'b10)
  val pht_table = RegInit(VecInit(Seq.fill(128)(2.U(2.W))))
  
  // 7-bit Global History Register (GHR) initialized to 0
  val ghr = RegInit(0.U(7.W))

  // Task 2: Prediction Logic
  // XOR predict_pc with ghr to compute index
  val predict_index = io.predict_pc ^ ghr
  val pht_entry = pht_table(predict_index)

  // The prediction is taken if the MSB of the counter is 1
  io.predict_taken := pht_entry(1) // MSB of the counter
  io.predict_history := ghr

  // Compute the next GHR for prediction
  val next_ghr_prediction = (ghr << 1) | io.predict_taken

  // Task 3: Training Logic
  // XOR train_pc with train_history to compute the training index
  val train_index = io.train_pc ^ io.train_history
  val current_counter = pht_table(train_index)

  // Update PHT counter based on train_taken
  val next_counter = Mux(io.train_taken,
    Mux(current_counter === 3.U, 3.U, current_counter + 1.U), // Saturated increment
    Mux(current_counter === 0.U, 0.U, current_counter - 1.U)  // Saturated decrement
  )

  // Compute the corrected GHR in case of a misprediction
  val corrected_ghr = (io.train_history << 1) | io.train_taken

  // Task 4: GHR Update Conflict Resolution
  val next_ghr_training = Mux(io.train_mispredicted, corrected_ghr, ghr)

  // Priority Mux for GHR update
  val resolved_next_ghr = WireDefault(ghr)
  when(io.train_valid && io.train_mispredicted) {
    resolved_next_ghr := corrected_ghr
  } .elsewhen(io.train_valid) {
    resolved_next_ghr := next_ghr_training
  } .elsewhen(io.predict_valid) {
    resolved_next_ghr := next_ghr_prediction
  }

  // Task 5: Clocked PHT and GHR updates
  when(io.train_valid) {
    pht_table(train_index) := next_counter
  }

  ghr := resolved_next_ghr

  // Task 6, 7, and 8 are more about testing and integrating this but will ensure the components are upgradable if necessary in the testing framework.
}

/*
object dut extends App {
  chisel3.Driver.execute(Array[String](), () => new dut)
}
*/
