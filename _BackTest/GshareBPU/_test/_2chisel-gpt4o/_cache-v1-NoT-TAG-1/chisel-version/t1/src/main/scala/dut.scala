import chisel3._
import chisel3.util._

class dutIO extends Bundle {
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
}

class dut extends Module {
  val io = IO(new dutIO)

  // Define the Pattern History Table (PHT) with 128 entries of 2-bit counters
  val pht_table = RegInit(VecInit(Seq.fill(128)(2.U(2.W))))

  // Define the Global History Register (GHR), 7-bit
  val ghr = RegInit(0.U(7.W))

  // Task 2: Prediction Interface Logic
  val prediction_index = io.predict_pc ^ ghr
  val pht_counter = pht_table(prediction_index)

  io.predict_taken := pht_counter(1) // The MSB represents the prediction
  io.predict_history := ghr

  val next_ghr_prediction = (ghr << 1) | io.predict_taken

  // Task 3: Training Interface Logic
  when(io.train_valid) {
    val training_index = io.train_pc ^ io.train_history
    val current_counter = pht_table(training_index)

    val updated_counter = Mux(io.train_taken,
      Mux(current_counter === 3.U, 3.U, current_counter + 1.U),
      Mux(current_counter === 0.U, 0.U, current_counter - 1.U)
    )

    pht_table(training_index) := updated_counter

    val corrected_ghr = (io.train_history << 1) | io.train_taken
    val next_ghr_training = Mux(io.train_mispredicted, corrected_ghr, next_ghr_prediction)

    // Task 4: GHR Update Conflict Resolution
    ghr := Mux(io.train_valid && io.train_mispredicted, corrected_ghr,
      Mux(io.train_valid, next_ghr_training,
        Mux(io.predict_valid, next_ghr_prediction, ghr)
      )
    )
  }

  // Task 6: Asynchronous Reset and Task 5: Updates handled with RegNext
  when(reset.asBool()) {
    ghr := 0.U
    for (i <- 0 until 128) {
      pht_table(i) := 2.U  // Initialize to weak taken
    }
  }
}

/*
object dutTest extends App {
  println("Generating the dut hardware")
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
