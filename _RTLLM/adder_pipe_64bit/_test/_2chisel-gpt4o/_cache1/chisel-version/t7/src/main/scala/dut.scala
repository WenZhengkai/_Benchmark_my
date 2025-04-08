
import chisel3._
import chisel3.util._

// Define the 64-bit pipelined ripple carry adder module
class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())            // Input enable signal
    val adda = Input(UInt(64.W))        // 64-bit input operand A
    val addb = Input(UInt(64.W))        // 64-bit input operand B
    val result = Output(UInt(65.W))     // 65-bit result (sum) output
    val o_en = Output(Bool())           // Output enable signal
  })

  // Registers for pipeline stages
  val stageRegs = RegInit(VecInit(Seq.fill(4)(0.U(17.W)))) // 16-bit sum + carry for each stage
  val enableRegs = RegInit(VecInit(Seq.fill(4)(false.B)))  // Enable signal for each pipeline stage

  // Split the 64-bit operands into 16-bit chunks for four pipeline stages
  val addaParts = VecInit(Seq(io.adda(15, 0), io.adda(31, 16), io.adda(47, 32), io.adda(63, 48)))
  val addbParts = VecInit(Seq(io.addb(15, 0), io.addb(31, 16), io.addb(47, 32), io.addb(63, 48)))

  // Pipeline stage 0: Initial addition of lower 16 bits and carry in
  val sum0 = RegNext(addaParts(0) +& addbParts(0))
  enableRegs(0) := RegNext(io.i_en) // Capture enable signal for stage 0

  // Pipeline stage 1
  val sum1 = RegNext(addaParts(1) +& addbParts(1) + sum0(16)) // Add carry from stage 0
  enableRegs(1) := RegNext(enableRegs(0)) // Capture enable signal for stage 1

  // Pipeline stage 2
  val sum2 = RegNext(addaParts(2) +& addbParts(2) + sum1(16)) // Add carry from stage 1
  enableRegs(2) := RegNext(enableRegs(1)) // Capture enable signal for stage 2

  // Pipeline stage 3
  val sum3 = RegNext(addaParts(3) +& addbParts(3) + sum2(16)) // Add carry from stage 2
  enableRegs(3) := RegNext(enableRegs(2)) // Capture enable signal for stage 3

  // Combine the results from each stage to form the final 65-bit result
  io.result := Cat(sum3(16), sum3(15, 0), sum2(15, 0), sum1(15, 0), sum0(15, 0))

  // Output enable is true when all stages are enabled and the last stage is ready
  io.o_en := enableRegs(3)
}

