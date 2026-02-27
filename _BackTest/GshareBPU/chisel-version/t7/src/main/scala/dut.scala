// package gshare

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
    val train_valid        = Input(Bool())
    val train_taken        = Input(Bool())
    val train_mispredicted = Input(Bool())
    val train_history      = Input(UInt(7.W))
    val train_pc           = Input(UInt(7.W)

    // Reset signal
    val reset = Input(Bool())
  })

  // Internal variables
  val historyRegister = RegInit(0.U(7.W)) // 7-bit global branch history register
  val pht = RegInit(VecInit(Seq.fill(128)(1.U(2.W)))) // 128-entry PHT initialized to 2-bit weakly taken (1)

  // XOR to generate hash index
  def hash(pc: UInt, history: UInt): UInt = pc ^ history // XOR the PC with global history

  // Prediction logic
  val predict_index = hash(io.predict_pc, historyRegister)
  val predict_counter = pht(predict_index)

  io.predict_taken := predict_counter(1) // MSB determines taken/not-taken
  io.predict_history := historyRegister

  when(io.predict_valid) {
    historyRegister := Cat(historyRegister(5, 0), io.predict_taken) // Update history with predicted result
  }

  // Training logic
  when(io.train_valid) {
    val train_index = hash(io.train_pc, io.train_history)
    val train_counter = pht(train_index)

    // Update PHT based on actual branch outcome
    when(io.train_taken) {
      when(train_counter =/= "b11".U) { // If not strongly taken
        pht(train_index) := train_counter + 1.U
      }
    }.otherwise {
      when(train_counter =/= "b00".U) { // If not strongly not taken
        pht(train_index) := train_counter - 1.U
      }
    }

    // Recover history register in case of misprediction
    when(io.train_mispredicted) {
      historyRegister := io.train_history // Restore history register
    }
  }

  // Reset
  when(io.reset) {
    historyRegister := 0.U
    pht.foreach(entry => entry := 1.U) // Reset PHT to weakly taken
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
