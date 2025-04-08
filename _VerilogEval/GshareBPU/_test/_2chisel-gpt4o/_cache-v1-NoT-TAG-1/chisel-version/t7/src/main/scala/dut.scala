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

  // Task 1: Core Registers
  val phtTable = RegInit(VecInit(Seq.fill(128)(2.U(2.W))))
  val ghr = RegInit(0.U(7.W))

  // Task 2: Prediction Logic
  val predictIndex = io.predict_pc ^ ghr
  val predictCounter = phtTable(predictIndex)
  io.predict_taken := predictCounter(1) // MSB is the prediction
  io.predict_history := ghr
  val nextGhrPrediction = Cat(ghr(5, 0), io.predict_taken)

  // Task 3: Training Logic
  val trainIndex = io.train_pc ^ io.train_history
  when (io.train_valid) {
    when (io.train_taken) {
      // Increment counter
      phtTable(trainIndex) := Mux(phtTable(trainIndex) === 3.U, 3.U, phtTable(trainIndex) + 1.U)
    } .otherwise {
      // Decrement counter
      phtTable(trainIndex) := Mux(phtTable(trainIndex) === 0.U, 0.U, phtTable(trainIndex) - 1.U)
    }
  }
  val correctedGhr = Cat(io.train_history(5, 0), io.train_taken)

  // Task 4: GHR Update Conflict Resolution
  val nextGhr = Wire(UInt(7.W))
  when (io.train_valid && io.train_mispredicted) {
    nextGhr := correctedGhr
  } .elsewhen (io.train_valid) {
    nextGhr := nextGhrPrediction
  } .elsewhen (io.predict_valid) {
    nextGhr := nextGhrPrediction
  } .otherwise {
    nextGhr := ghr
  }

  // Task 5 & 6: Synchronous Updates and Reset
  ghr := RegNext(nextGhr)
}

// Testbench would be created separately, verifying the described functionality.
