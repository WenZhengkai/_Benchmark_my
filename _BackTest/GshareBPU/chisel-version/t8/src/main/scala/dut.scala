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

    // Async reset
    val reset = Input(Bool())
  })

  // Global history register
  val globalHistory = RegInit(0.U(7.W))

  // Pattern history table (128 entries of 2-bit saturating counters)
  val patternHistoryTable = RegInit(VecInit(Seq.fill(128)(1.U(2.W)))) // Initialize counters to weakly taken

  // Compute index for prediction and training (using XOR of PC and history)
  def computeIndex(pc: UInt, history: UInt): UInt = {
    pc ^ history
  }

  // Prediction logic
  val predictionIndex = computeIndex(io.predict_pc, globalHistory)
  val predictionCounter = patternHistoryTable(predictionIndex)
  io.predict_taken := predictionCounter(1) // Taken if the MSB of the saturating counter is 1
  io.predict_history := globalHistory

  // Training logic
  val trainIndex = computeIndex(io.train_pc, io.train_history)

  when(io.train_valid) {
    val counter = patternHistoryTable(trainIndex)
    val updatedCounter = Mux(io.train_taken,
      Mux(counter === 3.U, 3.U, counter + 1.U), // Increment counter if taken
      Mux(counter === 0.U, 0.U, counter - 1.U)  // Decrement counter if not taken
    )
    patternHistoryTable(trainIndex) := updatedCounter

    // Update global history
    when(io.train_mispredicted) {
      globalHistory := io.train_history // Recover global history on misprediction
    }.otherwise {
      globalHistory := Cat(globalHistory(5, 0), io.train_taken) // Update history
    }
  }.elsewhen(io.predict_valid) {
    globalHistory := Cat(globalHistory(5, 0), io.predict_taken) // Update history on prediction
  }

  // Async reset
  when(io.reset) {
    globalHistory := 0.U
    for (i <- 0 until 128) {
      patternHistoryTable(i) := 1.U // Reset counters to weakly taken
    }
  }
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
