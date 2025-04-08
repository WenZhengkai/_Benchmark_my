import chisel3._
import chisel3.util._

class dut_IO extends Bundle {
  val predict_valid = Input(Bool())
  val predict_pc = Input(UInt(7.W))
  val predict_taken = Output(Bool())
  val predict_history = Output(UInt(7.W))

  val train_valid = Input(Bool())
  val train_taken = Input(Bool())
  val train_mispredicted = Input(Bool())
  val train_history = Input(UInt(7.W))
  val train_pc = Input(UInt(7.W))
}

class dut extends Module {
  val io = IO(new dut_IO)

  // Task 1: Define I/O Ports and Core Registers
  val pht_table = RegInit(VecInit(Seq.fill(128)(1.U(2.W)))) // 2'01 = weak not taken
  val ghr = RegInit(0.U(7.W))

  // Task 2: Prediction Interface Logic
  val predict_index = io.predict_pc ^ ghr
  val pht_entry = pht_table(predict_index)
  io.predict_taken := pht_entry(1) // MSB indicates taken/not taken
  io.predict_history := ghr // Current global history register
  val next_ghr_prediction = (ghr << 1) | io.predict_taken

  // Task 3: Training Interface Logic
  val train_index = io.train_pc ^ io.train_history
  val pht_updated = WireDefault(pht_table)

  when(io.train_valid) {
    when(io.train_taken) {
      when(pht_table(train_index) =/= 3.U) {
        pht_updated(train_index) := pht_table(train_index) + 1.U
      }
    } .otherwise {
      when(pht_table(train_index) =/= 0.U) {
        pht_updated(train_index) := pht_table(train_index) - 1.U
      }
    }
  }

  val corrected_ghr = (io.train_history << 1) | io.train_taken
  val next_ghr_training = WireDefault(0.U(7.W))

  // Task 4: GHR Update Conflict Resolution
  next_ghr_training := Mux(io.train_mispredicted, corrected_ghr, next_ghr_prediction)

  when(io.train_valid && io.train_mispredicted) {
    ghr := corrected_ghr
  } .elsewhen(io.train_valid) {
    // Optional: defer training update, or customize here
  } .elsewhen(io.predict_valid) {
    ghr := next_ghr_prediction
  }

  // Task 5: Synchronous PHT and GHR Updates
  when(io.train_valid) {
    pht_table := pht_updated
  }

  // Task 6: Asynchronous Reset Handling
  // Reset handling is implicit in RegInit as shown in the initial definition

  // Task 7: Concurrent Training/Prediction Edge Cases
  // Explicitly handled by using pht_table directly for prediction
}

// Generate the Verilog code
/*
object dutTest extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
