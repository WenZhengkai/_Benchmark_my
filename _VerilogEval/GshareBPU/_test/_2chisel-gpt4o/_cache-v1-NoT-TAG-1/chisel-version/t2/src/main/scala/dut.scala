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

  // Task 1: Define I/O Ports and Core Registers
  val pht_table = RegInit(VecInit(Seq.fill(128)(2.U(2.W)))) // Initialize to 2'b10
  val ghr = RegInit(0.U(7.W))

  // Task 2: Prediction Interface Logic
  val predict_index = io.predict_pc ^ ghr
  val pht_counter = pht_table(predict_index)
  io.predict_taken := pht_counter(1) // MSB as prediction taken
  io.predict_history := ghr
  val next_ghr_prediction = (ghr << 1) | io.predict_taken

  // Task 3: Training Interface Logic
  val train_index = io.train_pc ^ io.train_history

  // Update PHT Counter Logic
  val updated_pht_counter = Wire(UInt(2.W))
  when(io.train_valid) {
    when(io.train_taken) {
      updated_pht_counter := Mux(pht_table(train_index) === 3.U, 3.U, pht_table(train_index) + 1.U)
    }.otherwise {
      updated_pht_counter := Mux(pht_table(train_index) === 0.U, 0.U, pht_table(train_index) - 1.U)
    }
    pht_table(train_index) := updated_pht_counter
  }

  // Compute corrected GHR
  val corrected_ghr = (io.train_history << 1) | io.train_taken
  val next_ghr_training = WireDefault(ghr)

  // Task 4: GHR Update Conflict Resolution
  when(io.train_valid && io.train_mispredicted) {
    next_ghr_training := corrected_ghr
  }.elsewhen(io.train_valid) {
    next_ghr_training := (io.train_history << 1) | io.train_taken
  }.otherwise {
    when(io.predict_valid) {
      next_ghr_training := next_ghr_prediction
    }
  }

  // Task 5: Synchronous PHT and GHR Updates
  ghr := next_ghr_training

  // The GHR update conflicts should ensure training takes precedence

  // ** Additional Testing Tips: **
  // Use testbenches to verify the GHR update takes effect at the right time, and PHT updates correctly on training.
}

/*
object dutMain extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
