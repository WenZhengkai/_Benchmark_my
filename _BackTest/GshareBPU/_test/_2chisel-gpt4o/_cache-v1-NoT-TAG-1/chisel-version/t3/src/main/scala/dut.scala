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
    val train_valid        = Input(Bool())
    val train_taken        = Input(Bool())
    val train_mispredicted = Input(Bool())
    val train_history      = Input(UInt(7.W))
    val train_pc           = Input(UInt(7.W))
  })

  // Define PHT table, initialized to 2'b10 (weak taken)
  val pht_table = RegInit(VecInit(Seq.fill(128)(2.U(2.W))))
  // Define GHR (Global History Register)
  val ghr = RegInit(0.U(7.W))

  // Task 2: Prediction Interface Logic
  val predict_index = io.predict_pc ^ ghr
  val predict_counter = pht_table(predict_index)

  io.predict_taken := predict_counter(1) // MSB of the counter
  io.predict_history := ghr

  val next_ghr_prediction = (ghr << 1) | io.predict_taken

  // Task 3: Training Interface Logic
  val train_index = io.train_pc ^ io.train_history
  val updated_counter = Wire(UInt(2.W))

  when(io.train_valid) {
    when(io.train_taken) {
      updated_counter := Mux(pht_table(train_index) === 3.U, 3.U, pht_table(train_index) + 1.U)
    } .otherwise {
      updated_counter := Mux(pht_table(train_index) === 0.U, 0.U, pht_table(train_index) - 1.U)
    }
  } .otherwise {
    updated_counter := pht_table(train_index)
  }

  when(io.train_valid) {
    pht_table(train_index) := updated_counter
  }

  val corrected_ghr = (io.train_history << 1) | io.train_taken
  val next_ghr_training = Mux(io.train_mispredicted, corrected_ghr, (io.train_history << 1) | io.train_taken)

  // Task 4: GHR Update Conflict Resolution
  when(io.train_valid && io.train_mispredicted) {
    ghr := corrected_ghr
  } .elsewhen(io.train_valid) {
    ghr := next_ghr_training
  } .elsewhen(io.predict_valid) {
    ghr := next_ghr_prediction
  }

  // Task 5: Synchronous PHT and GHR Updates
  // Already incorporated by handling updates in clocked always blocks

  // Task 6: Asynchronous Reset Handling
  // These are handled in RegInit definitions

  // Implementation of additional tasks like testing would typically follow here.
}
