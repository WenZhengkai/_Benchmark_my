import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val predict_valid    = Input(Bool())
    val predict_pc       = Input(UInt(7.W))
    val predict_taken    = Output(Bool())
    val predict_history  = Output(UInt(7.W))

    val train_valid      = Input(Bool())
    val train_taken      = Input(Bool())
    val train_mispredicted = Input(Bool())
    val train_history    = Input(UInt(7.W))
    val train_pc         = Input(UInt(7.W))
  })
  
  // Task 1: Define PHT and GHR
  val phtTable = RegInit(VecInit(Seq.fill(128)(2.U(2.W)))) // 128 entries x 2-bit counters
  val ghr = RegInit(0.U(7.W)) // 7-bit global history register

  // Task 2: Prediction Interface Logic
  val predictIndex = io.predict_pc ^ ghr
  val predictCounter = phtTable(predictIndex)
  io.predict_taken := predictCounter(1) // MSB of the counter
  io.predict_history := ghr
  val nextGHRPrediction = (ghr << 1) | io.predict_taken

  // Task 3: Training Interface Logic
  when(io.train_valid) {
    val trainIndex = io.train_pc ^ io.train_history
    val currentCounter = phtTable(trainIndex)
    
    val updatedCounter = Mux(io.train_taken,
      Mux(currentCounter =/= 3.U, currentCounter + 1.U, currentCounter),
      Mux(currentCounter =/= 0.U, currentCounter - 1.U, currentCounter)
    )
    
    phtTable(trainIndex) := updatedCounter
  }

  // Generate corrected GHR on potential misprediction
  val correctedGHR = (io.train_history << 1) | io.train_taken
  val nextGHRTraining = Mux(io.train_mispredicted, correctedGHR, nextGHRPrediction)

  // Task 4: GHR Update Conflict Resolution
  val nextGHR = WireDefault(ghr)
  
  when(io.train_valid && io.train_mispredicted) {
    nextGHR := correctedGHR
  }.elsewhen(io.train_valid) {
    nextGHR := nextGHRTraining
  }.elsewhen(io.predict_valid) {
    nextGHR := nextGHRPrediction
  }
  
  // Register the next GHR value
  ghr := nextGHR
  
  // PHT update happens automatically via assigned logic

  // Task 6: Asynchronous Reset Handling
  when(reset.asBool()) {
    ghr := 0.U
    for (i <- 0 until 128) {
      phtTable(i) := 2.U // Initialize all to 'weak taken', 2'b10
    }
  }
}

/*
object dutTest extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
