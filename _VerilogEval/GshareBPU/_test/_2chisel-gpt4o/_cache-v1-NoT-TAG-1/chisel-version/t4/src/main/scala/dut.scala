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

  // Task 1: I/O Ports and Core Registers
  val phtTable = RegInit(VecInit(Seq.fill(128)(2.U(2.W))))
  val ghr = RegInit(0.U(7.W))

  // Task 2: Prediction Interface Logic
  val predictIndex = io.predict_pc ^ ghr
  val predictCounter = phtTable(predictIndex)
  io.predict_taken := predictCounter(1)  // MSB gives the prediction
  io.predict_history := ghr
  val nextGHRPrediction = (ghr << 1) | io.predict_taken

  // Task 3: Training Interface Logic
  val trainIndex = io.train_pc ^ io.train_history
  val updatedPHT = WireInit(phtTable)

  when(io.train_valid) {
    // Update the PHT counter for training
    when(io.train_taken) {
      updatedPHT(trainIndex) := Mux(phtTable(trainIndex) === 3.U, 3.U, phtTable(trainIndex) + 1.U)
    }.otherwise {
      updatedPHT(trainIndex) := Mux(phtTable(trainIndex) === 0.U, 0.U, phtTable(trainIndex) - 1.U)
    }
  }

  val correctedGHR = (io.train_history << 1) | io.train_taken
  val nextGHRTraining = Wire(UInt(7.W))
  nextGHRTraining := Mux(io.train_mispredicted, correctedGHR, nextGHRPrediction)

  // Task 4: GHR Update Conflict Resolution
  val nextGHR = Wire(UInt(7.W))
  nextGHR := ghr  // Default to current GHR
  when(io.train_valid && io.train_mispredicted) {
    nextGHR := correctedGHR
  }.elsewhen(io.predict_valid) {
    nextGHR := nextGHRPrediction
  }

  // Task 5: Synchronous PHT and GHR Updates
  when(io.train_valid) {
    phtTable := updatedPHT
  }
  ghr := nextGHR

  // This structure ensures that updates to GHR and PHT occur synchronously.

}

/*
object dut extends App {
  // Generate the Verilog
  chisel3.Driver.execute(args, () => new dut)
}
*/
