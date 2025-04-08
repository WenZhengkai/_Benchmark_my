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

  // Define PHT (Pattern History Table) and GHR (Global History Register)
  val pht = RegInit(VecInit(Seq.fill(128)(1.U(2.W)))) // Initialize to "weakly not taken" (01)
  val ghr = RegInit(0.U(7.W))

  // Task 2: Prediction Interface Logic
  when(io.predict_valid) {
    // Compute prediction index from XOR of PC and GHR
    val predict_index = io.predict_pc ^ ghr
    // Read the PHT counter
    val pht_counter = pht(predict_index)

    // Set predict_taken based on the MSB of the counter
    io.predict_taken := pht_counter(1)
    // Pass the current GHR to the prediction history
    io.predict_history := ghr

    // Generate next GHR for prediction
    val next_ghr_prediction = (ghr << 1) | io.predict_taken
  } .otherwise {
    io.predict_taken := false.B
    io.predict_history := 0.U
  }

  // Task 3: Training Interface Logic
  when(io.train_valid) {
    val train_index = io.train_pc ^ io.train_history
    // Update the PHT counter based on train_taken
    when(io.train_taken) {
      pht(train_index) := Mux(pht(train_index) === 3.U, 3.U, pht(train_index) + 1.U)
    } .otherwise {
      pht(train_index) := Mux(pht(train_index) === 0.U, 0.U, pht(train_index) - 1.U)
    }

    // Compute corrected GHR if branch was mispredicted
    val corrected_ghr = (io.train_history << 1) | io.train_taken
    // Generate next GHR for training
    val next_ghr_training = Mux(io.train_mispredicted, corrected_ghr, (io.train_history << 1) | io.train_taken)
  }

  // Task 4: GHR Update Conflict Resolution
  when(io.train_valid && io.train_mispredicted) {
    ghr := (io.train_history << 1) | io.train_taken
  } .elsewhen(io.train_valid) {
    // Optional based on spec clarification
    ghr := (io.train_history << 1) | io.train_taken
  } .elsewhen(io.predict_valid) {
    ghr := (ghr << 1) | io.predict_taken
  }

  // Task 5: Synchronous PHT and GHR Updates
  // The PHT updates already inherently happen on the next clock edge
  // Connect ghr to resolved next_ghr using the logic above

  // Task 6: Asynchronous Reset Handling
  // Reset logic is handled by RegInit above, initializing ghr to 0
  // and pht to weak not taken (01) on reset.
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
