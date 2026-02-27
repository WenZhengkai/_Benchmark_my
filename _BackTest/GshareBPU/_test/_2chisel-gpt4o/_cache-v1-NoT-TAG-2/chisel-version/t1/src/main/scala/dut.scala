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

  // Task 1: Define Core Registers
  val pht_table = RegInit(VecInit(Seq.fill(128)(1.U(2.W)))) // 2'b01 is "weak not taken"
  val ghr = RegInit(0.U(7.W))

  // Task 2: Prediction Interface Logic
  val predict_index = io.predict_pc ^ ghr
  val pht_entry = pht_table(predict_index)

  io.predict_taken := pht_entry(1) // MSB of the counter
  io.predict_history := ghr
  val next_ghr_prediction = (ghr << 1) | io.predict_taken

  // Task 3: Training Interface Logic
  val train_index = io.train_pc ^ io.train_history

  val updated_pht_table = Wire(Vec(128, UInt(2.W)))
  updated_pht_table := pht_table

  when(io.train_valid) {
    when(io.train_taken) {
      when(pht_table(train_index) =/= 3.U) {
        updated_pht_table(train_index) := pht_table(train_index) + 1.U
      }
    }.otherwise {
      when(pht_table(train_index) =/= 0.U) {
        updated_pht_table(train_index) := pht_table(train_index) - 1.U
      }
    }
  }

  val corrected_ghr = (io.train_history << 1) | io.train_taken
  val next_ghr_training = Mux(io.train_mispredicted, corrected_ghr, next_ghr_prediction)

  // Task 4: GHR Update Conflict Resolution
  val next_ghr = Wire(UInt(7.W))
  when(io.train_valid && io.train_mispredicted) {
    next_ghr := corrected_ghr
  }.elsewhen(io.train_valid) {
    next_ghr := next_ghr_training
  }.elsewhen(io.predict_valid) {
    next_ghr := next_ghr_prediction
  }.otherwise {
    next_ghr := ghr // default to ghr
  }

  // Task 5: Synchronous PHT and GHR Updates
  pht_table := RegNext(updated_pht_table)
  ghr := RegNext(next_ghr)

  // Task 6: Asynchronous Reset Handling
  when(reset.asBool()) {
    ghr := 0.U
    for (i <- 0 until 128) {
      pht_table(i) := 1.U
    }
  }

  // Task 7: Ensure PHT reads correctly in prediction uses
  // Already handled: pht_entry reads directly from pht_table
}

// Test harness (scaffold code, real tester would require more details)
/*
object dutTop extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
