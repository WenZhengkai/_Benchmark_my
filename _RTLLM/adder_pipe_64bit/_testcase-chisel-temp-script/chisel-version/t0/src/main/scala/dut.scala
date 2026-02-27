// package adder

import chisel3._
import chisel3.util._

class PipelinedRippleCarryAdder extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Pipeline registers for enable signal
  val en_reg1 = RegInit(false.B)
  val en_reg2 = RegInit(false.B)
  val en_reg3 = RegInit(false.B)
  val en_reg4 = RegInit(false.B)

  // Pipeline registers for input data
  val adda_reg = RegInit(0.U(64.W))
  val addb_reg = RegInit(0.U(64.W))

  // Propagate enable signal through pipeline
  en_reg1 := io.i_en
  en_reg2 := en_reg1
  en_reg3 := en_reg2
  en_reg4 := en_reg3

  // Register inputs when enabled
  when(io.i_en) {
    adda_reg := io.adda
    addb_reg := io.addb
  }

  // Split inputs into 4 chunks of 16-bit each
  val adda_chunks = Wire(Vec(4, UInt(16.W)))
  val addb_chunks = Wire(Vec(4, UInt(16.W)))

  for (i <- 0 until 4) {
    adda_chunks(i) := adda_reg(16 * (i + 1) - 1, 16 * i)
    addb_chunks(i) := addb_reg(16 * (i + 1) - 1, 16 * i)
  }

  // Pipeline stage 1 - compute first chunk
  val sum1 = RegInit(0.U(16.W))
  val carry1 = RegInit(false.B)
  
  when(en_reg1) {
    val result = adda_chunks(0) +& addb_chunks(0)
    sum1 := result(15, 0)
    carry1 := result(16)
  }

  // Pipeline stage 2 - compute second chunk
  val sum2 = RegInit(0.U(16.W))
  val carry2 = RegInit(false.B)
  
  when(en_reg2) {
    val result = adda_chunks(1) +& addb_chunks(1) + carry1
    sum2 := result(15, 0)
    carry2 := result(16)
  }

  // Pipeline stage 3 - compute third chunk
  val sum3 = RegInit(0.U(16.W))
  val carry3 = RegInit(false.B)
  
  when(en_reg3) {
    val result = adda_chunks(2) +& addb_chunks(2) + carry2
    sum3 := result(15, 0)
    carry3 := result(16)
  }

  // Pipeline stage 4 - compute fourth chunk and final result
  val sum4 = RegInit(0.U(16.W))
  val carry4 = RegInit(false.B)
  
  when(en_reg4) {
    val result = adda_chunks(3) +& addb_chunks(3) + carry3
    sum4 := result(15, 0)
    carry4 := result(16)
  }

  // Combine results from all stages
  io.result := Cat(carry4, sum4, sum3, sum2, sum1)
  io.o_en := en_reg4
}

/*
object PipelinedRippleCarryAdderMain extends App {
  chisel3.Driver.execute(args, () => new PipelinedRippleCarryAdder)
}
*/
