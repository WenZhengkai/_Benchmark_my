// Import necessary Chisel packages
import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Define a 4-stage pipeline registers for partial sums and carries
  val partialSums = RegInit(VecInit(Seq.fill(4)(0.U(17.W))))
  val pipelineCarry = RegInit(VecInit(Seq.fill(4)(0.U(1.W))))
  val enablePipeline = RegInit(VecInit(Seq.fill(4)(false.B)))

  // Split the 64-bit inputs into 4 parts of 16 bits each
  val addA_parts = io.adda.asBools.grouped(16).map(Cat(_)).toList
  val addB_parts = io.addb.asBools.grouped(16).map(Cat(_)).toList

  // Initialize the carry for each stage
  pipelineCarry(0) := 0.U

  // Process each 16-bit addition with carry
  for (i <- 0 until 4) {
    val (sum, carryOut) = {
      if (i == 0) {
        val addResult = Cat(0.U, addA_parts(i)) + Cat(0.U, addB_parts(i))
        (addResult(15, 0), addResult(16))
      } else {
        val addResult = Cat(pipelineCarry(i-1), addA_parts(i)) + Cat(0.U, addB_parts(i))
        (addResult(15, 0), addResult(16))
      }
    }
    partialSums(i) := sum
    pipelineCarry(i) := carryOut
  }

  // Shift enable signal through the pipeline
  enablePipeline(0) := io.i_en
  for (i <- 1 until 4) {
    enablePipeline(i) := enablePipeline(i-1)
  }

  // Combine the partial sums into a final 65-bit result
  io.result := Cat(pipelineCarry(3), partialSums.reverse.reduce(Cat(_, _)))

  // Output enable signal is synchronized with register pipeline stages
  io.o_en := enablePipeline(3)
}
