import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en: Bool = Input(Bool())
    val adda: UInt = Input(UInt(64.W))
    val addb: UInt = Input(UInt(64.W))
    val result: UInt = Output(UInt(65.W))
    val o_en: Bool = Output(Bool())
  })

  // Pipeline Registers for enable and carry
  val en_pipe = RegInit(VecInit(Seq.fill(4)(false.B)))
  val carry_pipe = RegInit(VecInit(Seq.fill(4)(0.U(1.W))))

  // Partial sum registers
  val sum_stage = Reg(Vec(4, UInt(17.W))) // 16 bits + 1 for carry

  // Stage 1: Add the lower 16 bits
  when(io.i_en) {
    val sum0 = io.adda(15, 0) + io.addb(15, 0)
    val carry0 = sum0(16)
    sum_stage(0) := sum0
    carry_pipe(0) := carry0
    en_pipe(0) := io.i_en
  }.otherwise {
    en_pipe(0) := false.B
  }

  // Stage 2: Add bits 16 to 31 with carry from Stage 1
  when(en_pipe(0)) {
    val sum1 = io.adda(31, 16) + io.addb(31, 16) + carry_pipe(0)
    val carry1 = sum1(16)
    sum_stage(1) := sum1
    carry_pipe(1) := carry1
    en_pipe(1) := en_pipe(0)
  }.otherwise {
    en_pipe(1) := false.B
  }

  // Stage 3: Add bits 32 to 47 with carry from Stage 2
  when(en_pipe(1)) {
    val sum2 = io.adda(47, 32) + io.addb(47, 32) + carry_pipe(1)
    val carry2 = sum2(16)
    sum_stage(2) := sum2
    carry_pipe(2) := carry2
    en_pipe(2) := en_pipe(1)
  }.otherwise {
    en_pipe(2) := false.B
  }

  // Stage 4: Add bits 48 to 63 with carry from Stage 3
  when(en_pipe(2)) {
    val sum3 = io.adda(63, 48) + io.addb(63, 48) + carry_pipe(2)
    val carry3 = sum3(16)
    sum_stage(3) := sum3
    carry_pipe(3) := carry3
    en_pipe(3) := en_pipe(2)
  }.otherwise {
    en_pipe(3) := false.B
  }

  // Combine the partial sums and the final carry
  io.result := Cat(carry_pipe(3), sum_stage(3)(15, 0), sum_stage(2)(15, 0), sum_stage(1)(15, 0), sum_stage(0)(15, 0))
  io.o_en := en_pipe(3)
}

