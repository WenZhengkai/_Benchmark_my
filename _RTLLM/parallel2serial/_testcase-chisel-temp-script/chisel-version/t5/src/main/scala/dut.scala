import chisel3._
import chisel3.util._

// Define the Adder Module
class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Four-stage pipeline: each stage handles a 16-bit sum and carry
  val pipe1_sum = Wire(UInt(17.W))
  val pipe1_carry = RegInit(0.U(1.W))
  val pipe1_en = RegInit(false.B)

  val pipe2_sum = Wire(UInt(17.W))
  val pipe2_carry = RegInit(0.U(1.W))
  val pipe2_en = RegInit(false.B)

  val pipe3_sum = Wire(UInt(17.W))
  val pipe3_carry = RegInit(0.U(1.W))
  val pipe3_en = RegInit(false.B)

  val pipe4_sum = Wire(UInt(17.W))
  val pipe4_en = RegInit(false.B)

  // Stage 1: Add lower 16 bits
  when(io.i_en) {
    pipe1_sum := io.adda(15, 0) + io.addb(15, 0)
    pipe1_carry := pipe1_sum(16)
    pipe1_en := io.i_en
  }.otherwise {
    pipe1_sum := 0.U
    pipe1_carry := 0.U
    pipe1_en := false.B
  }

  // Stage 2: Add second 16 bits with previous carry
  when(pipe1_en) {
    pipe2_sum := io.adda(31, 16) + io.addb(31, 16) + pipe1_carry
    pipe2_carry := pipe2_sum(16)
    pipe2_en := pipe1_en
  }.otherwise {
    pipe2_sum := 0.U
    pipe2_carry := 0.U
    pipe2_en := false.B
  }

  // Stage 3: Add third 16 bits with previous carry
  when(pipe2_en) {
    pipe3_sum := io.adda(47, 32) + io.addb(47, 32) + pipe2_carry
    pipe3_carry := pipe3_sum(16)
    pipe3_en := pipe2_en
  }.otherwise {
    pipe3_sum := 0.U
    pipe3_carry := 0.U
    pipe3_en := false.B
  }

  // Stage 4: Add highest 16 bits with previous carry
  when(pipe3_en) {
    pipe4_sum := io.adda(63, 48) + io.addb(63, 48) + pipe3_carry
    pipe4_en := pipe3_en
  }.otherwise {
    pipe4_sum := 0.U
    pipe4_en := false.B
  }

  // Concatenate results from all stages to form the final output
  io.result := Cat(pipe4_sum(16), pipe4_sum(15, 0), pipe3_sum(15, 0), pipe2_sum(15, 0), pipe1_sum(15, 0))
  io.o_en := pipe4_en
}

