import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Prediction interface
    val predict_valid    = Input(Bool())
    val predict_pc       = Input(UInt(7.W))
    val predict_taken    = Output(Bool())
    val predict_history  = Output(UInt(7.W))

    // Training interface
    val train_valid       = Input(Bool())
    val train_taken       = Input(Bool())
    val train_mispredicted = Input(Bool())
    val train_history     = Input(UInt(7.W))
    val train_pc          = Input(UInt(7.W))

    // Reset signal
    val reset = Input(Bool())
  })

  // Constants and state
  val PHT_SIZE = 128
  val globalHistoryReg = RegInit(0.U(7.W))  // 7-bit global history register
  val PHT = RegInit(VecInit(Seq.fill(PHT_SIZE)(2.U(2.W)))) // 128-entry table of 2-bit saturating counters

  // Hash function for index calculation
  def getIndex(pc: UInt, history: UInt): UInt = {
    pc ^ history // XOR PC and global history to create the index
  }

  // Calculate index during prediction
  val predictIndex = getIndex(io.predict_pc, globalHistoryReg)
  val predictCounter = PHT(predictIndex)

  // Prediction logic
  when (io.predict_valid) {
    io.predict_taken := predictCounter >= 2.U // 2-bit saturating counter predicts taken if value is 2 or 3
    io.predict_history := globalHistoryReg   // Output the current global history
  } .otherwise {
    io.predict_taken := false.B
    io.predict_history := 0.U
  }

  // Training logic
  when (io.train_valid) {
    val trainIndex = getIndex(io.train_pc, io.train_history)
    val trainCounter = PHT(trainIndex)

    // Update the saturating counter based on `train_taken`
    when (io.train_taken) {
      when (trainCounter =/= 3.U) {
        PHT(trainIndex) := trainCounter + 1.U // Increment saturating counter
      }
    } .otherwise {
      when (trainCounter =/= 0.U) {
        PHT(trainIndex) := trainCounter - 1.U // Decrement saturating counter
      }
    }

    // Recover global history if mispredicted
    when (io.train_mispredicted) {
      globalHistoryReg := io.train_history
    } .otherwise {
      globalHistoryReg := io.train_history
    }
  } .elsewhen (io.predict_valid) {
    globalHistoryReg := Cat(globalHistoryReg(6, 1), io.predict_taken) // Shift history and include prediction
  }

  // Reset logic
  when (io.reset) {
    globalHistoryReg := 0.U
    for (i <- 0 until PHT_SIZE) {
      PHT(i) := 2.U // Initialize all counters to weakly taken (2)
    }
  }
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
