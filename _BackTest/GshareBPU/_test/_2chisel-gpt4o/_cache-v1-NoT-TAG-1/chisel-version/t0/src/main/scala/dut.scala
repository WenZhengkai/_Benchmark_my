import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Prediction interface
    val predict_valid = Input(Bool())
    val predict_pc = Input(UInt(7.W)) // 7-bit program counter for prediction
    val predict_taken = Output(Bool())
    val predict_history = Output(UInt(7.W)) // Current global history

    // Training interface
    val train_valid = Input(Bool())
    val train_taken = Input(Bool())
    val train_mispredicted = Input(Bool())
    val train_history = Input(UInt(7.W))
    val train_pc = Input(UInt(7.W))
  })

  // Register and memory table definitions
  val pht_table = RegInit(VecInit(Seq.fill(128)(2.U(2.W)))) // Initialized to "weak taken" = 2'b10
  val ghr = RegInit(0.U(7.W)) // Global history register initialized to 0

  // Wires for calculation
  val prediction_index = io.predict_pc ^ ghr
  val prediction_counter = pht_table(prediction_index)
  val next_ghr_prediction = (ghr << 1) | prediction_counter(1)

  // Prediction logic
  io.predict_taken := prediction_counter(1) // MSB of counter determines 'taken'
  io.predict_history := ghr

  // Training logic
  val training_index = io.train_pc ^ io.train_history

  // Update counter with saturation logic
  val updated_counter = WireInit(pht_table(training_index))
  when(io.train_valid) {
    when(io.train_taken) {
      updated_counter := Mux(pht_table(training_index) === 3.U, 3.U, pht_table(training_index) + 1.U)
    }.otherwise {
      updated_counter := Mux(pht_table(training_index) === 0.U, 0.U, pht_table(training_index) - 1.U)
    }
  }

  pht_table(training_index) := updated_counter

  // GHR correction logic on misprediction
  val corrected_ghr = Mux(io.train_valid && io.train_mispredicted, (io.train_history << 1) | io.train_taken, ghr)

  // Resolve GHR updates: Priority logic
  when(io.train_valid && io.train_mispredicted) {
    ghr := corrected_ghr
  }.elsewhen(io.predict_valid) {
    ghr := next_ghr_prediction
  }

  // Asynchronous reset handled by RegInit
}

/*
object dutTest extends App {
  println(getVerilog(new dut()))
}
*/
