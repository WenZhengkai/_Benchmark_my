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
    val train_valid       = Input(Bool())
    val train_taken       = Input(Bool())
    val train_mispredicted = Input(Bool())
    val train_history     = Input(UInt(7.W))
    val train_pc          = Input(UInt(7.W))

    // Reset (asynchronous active-high)
  })

  // 7-bit global history register
  val globalHistoryReg = RegInit(0.U(7.W))

  // 128-entry table of 2-bit saturating counters
  val pht = RegInit(VecInit(Seq.fill(128)(3.U(2.W)))) // Initialize all to strongly taken (11)

  // Helper function to get index based on XOR hashing
  def computeIndex(pc: UInt, history: UInt): UInt = {
    pc ^ history
  }

  // Prediction logic
  val predictIndex = computeIndex(io.predict_pc, globalHistoryReg)
  io.predict_taken := io.predict_valid && (pht(predictIndex) === 2.U || pht(predictIndex) === 3.U)
  io.predict_history := globalHistoryReg

  // Training logic
  when(io.train_valid) {
    val trainIndex = computeIndex(io.train_pc, io.train_history)

    // Update PHT based on actual outcome
    when(io.train_taken) {
      when(pht(trainIndex) =/= 3.U) { // Saturating increment
        pht(trainIndex) := pht(trainIndex) + 1.U
      }
    }.otherwise {
      when(pht(trainIndex) =/= 0.U) { // Saturating decrement
        pht(trainIndex) := pht(trainIndex) - 1.U
      }
    }

    // Update global branch history
    when(io.train_mispredicted) {
      // Recover global history to state after mispredicting branch
      globalHistoryReg := io.train_history
    }.otherwise {
      // Update for the actual branch outcome
      globalHistoryReg := Cat(globalHistoryReg(5, 0), io.train_taken)
    }
  }.otherwise {
    // Update global branch history in the prediction phase
    when(io.predict_valid) {
      globalHistoryReg := Cat(globalHistoryReg(5, 0), io.predict_taken)
    }
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
