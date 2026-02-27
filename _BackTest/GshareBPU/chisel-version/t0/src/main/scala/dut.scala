import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Prediction Interface
    val predict_valid   = Input(Bool())
    val predict_pc      = Input(UInt(7.W))
    val predict_taken   = Output(Bool())
    val predict_history = Output(UInt(7.W))

    // Training Interface
    val train_valid        = Input(Bool())
    val train_taken        = Input(Bool())
    val train_mispredicted = Input(Bool())
    val train_history      = Input(UInt(7.W))
    val train_pc           = Input(UInt(7.W))

    // Reset (asynchronous active-high)
    val reset = Input(Bool())
  })

  val PHT = RegInit(VecInit(Seq.fill(128)(0.U(2.W)))) // 128-entry 2-bit saturating counters 
  val globalHistory = RegInit(0.U(7.W)) // 7-bit global history register

  // Reset logic for the asynchronous active-high reset
  when(io.reset) {
    globalHistory := 0.U
    PHT.foreach(counter => counter := 0.U)
  }

  // Hashing: XOR the PC and the global history to get the index
  def getIndex(pc: UInt, history: UInt): UInt = {
    pc ^ history
  }

  // Prediction logic
  val predict_index = getIndex(io.predict_pc, globalHistory)
  val predict_counter = PHT(predict_index) 

  // Based on the saturating counter (2 bits): Threshold is 2 (10b)
  io.predict_taken := predict_counter >= 2.U
  io.predict_history := globalHistory

  // Training logic
  when(io.train_valid) {
    val train_index = getIndex(io.train_pc, io.train_history)

    // Update PHT based on actual outcome (train_taken)
    when(io.train_taken) {
      when(PHT(train_index) =/= 3.U) {
        PHT(train_index) := PHT(train_index) + 1.U // Increment counter
      }
    }.otherwise {
      when(PHT(train_index) =/= 0.U) {
        PHT(train_index) := PHT(train_index) - 1.U // Decrement counter
      }
    }

    // Handle misprediction
    when(io.train_mispredicted) {
      globalHistory := io.train_history // Recover history after misprediction
    }.otherwise {
      // Non-mispredicted branches: Update the global history for next predictions
      globalHistory := Cat(globalHistory(5, 0), io.train_taken)
    }
  }.elsewhen(io.predict_valid) {
    // When prediction is valid but training is not ongoing
    globalHistory := Cat(globalHistory(5, 0), io.predict_taken)
  }

}
