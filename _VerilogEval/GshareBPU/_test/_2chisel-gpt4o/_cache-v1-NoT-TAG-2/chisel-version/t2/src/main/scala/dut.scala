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

  // Task 1: Define I/O Ports and Core Registers
  val pht_table = RegInit(VecInit(Seq.fill(128)(1.U(2.W))))  // 2-bit "weak not taken"
  val ghr = RegInit(0.U(7.W))

  // Task 2: Prediction Interface Logic
  val predict_index = io.predict_pc ^ ghr
  val pht_counter = pht_table(predict_index)

  io.predict_taken := pht_counter(1)  // MSB of the counter
  io.predict_history := ghr

  val next_ghr_prediction = (ghr << 1) | io.predict_taken

  // Task 3: Training Interface Logic
  val train_index = io.train_pc ^ io.train_history
  val updated_pht = Wire(Vec(128, UInt(2.W)))
  
  for (i <- 0 until 128) {
    updated_pht(i) := pht_table(i)
  }

  when(io.train_valid) {
    when(io.train_taken) {
      when(pht_table(train_index) =/= 3.U) {
        updated_pht(train_index) := pht_table(train_index) + 1.U
      }
    } .otherwise {
      when(pht_table(train_index) =/= 0.U) {
        updated_pht(train_index) := pht_table(train_index) - 1.U
      }
    }
  }

  val corrected_ghr = (io.train_history << 1) | io.train_taken
  val next_ghr_training = Mux(io.train_mispredicted, corrected_ghr, (io.train_history << 1) | io.train_taken)

  // Task 4: GHR Update Conflict Resolution
  val next_ghr = Wire(UInt(7.W))
  when(io.train_valid && io.train_mispredicted) {
    next_ghr := corrected_ghr
  } .elsewhen(io.train_valid) {
    next_ghr := next_ghr_training
  } .elsewhen(io.predict_valid) {
    next_ghr := next_ghr_prediction
  } .otherwise {
    next_ghr := ghr
  }

  // Task 5: Synchronous PHT and GHR Updates
  pht_table := updated_pht
  ghr := RegNext(next_ghr)

  // Task 6: Asynchronous Reset Handling
  when(reset.asBool) {
    ghr := 0.U
    pht_table := VecInit(Seq.fill(128)(1.U(2.W)))
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
