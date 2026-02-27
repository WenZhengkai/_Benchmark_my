import chisel3._
import chisel3.util._

class dutIO extends Bundle {
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
}

class dut extends Module {
  val io = IO(new dutIO)

  // Task 1: Define I/O Ports and Core Registers
  val pht_table = RegInit(VecInit(Seq.fill(128)(1.U(2.W)))) // 128-entry, 2-bit "weak not taken"
  val ghr = RegInit(0.U(7.W)) // 7-bit Global History Register

  // Task 2: Prediction Interface Logic
  val prediction_index = io.predict_pc ^ ghr
  val predict_counter = pht_table(prediction_index)
  io.predict_taken := predict_counter(1)
  io.predict_history := ghr

  val next_ghr_prediction = Wire(UInt(7.W))
  next_ghr_prediction := (ghr << 1) | io.predict_taken

  // Task 3: Training Interface Logic
  val training_index = io.train_pc ^ io.train_history
  val train_counter = pht_table(training_index)

  val updated_train_counter = Mux(io.train_taken,
    Mux(train_counter === 3.U, 3.U, train_counter + 1.U),
    Mux(train_counter === 0.U, 0.U, train_counter - 1.U)
  )

  // Write updated counter to PHT only if training is valid
  when(io.train_valid) {
    pht_table(training_index) := updated_train_counter
  }

  val corrected_ghr = (io.train_history << 1) | io.train_taken
  val next_ghr_training = Mux(io.train_mispredicted, corrected_ghr, next_ghr_prediction)

  // Task 4: GHR Update Conflict Resolution
  val resolved_next_ghr = Wire(UInt(7.W))
  when(io.train_valid && io.train_mispredicted) {
    resolved_next_ghr := corrected_ghr
  }.elsewhen(io.train_valid) {
    resolved_next_ghr := next_ghr_training
  }.elsewhen(io.predict_valid) {
    resolved_next_ghr := next_ghr_prediction
  }.otherwise {
    resolved_next_ghr := ghr
  }

  // Task 5: Synchronous PHT and GHR Updates
  ghr := resolved_next_ghr

  // Task 6: Asynchronous Reset Handling
  // Already handled in `RegInit` with initializations

  // Task 7: Concurrent Training/Prediction Edge Cases
  // Already ensures PHT updates are considered at the next cycle

  // RegNext connection if needed would go here
}

/*
object dutTest extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
