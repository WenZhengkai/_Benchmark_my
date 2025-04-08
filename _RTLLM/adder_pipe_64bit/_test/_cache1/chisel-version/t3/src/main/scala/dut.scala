import chisel3._
import chisel3.util._

class RCA16 extends Module {
  val io = IO(new Bundle {
    val a    = Input(UInt(16.W))
    val b    = Input(UInt(16.W))
    val cin  = Input(UInt(1.W))
    val sum  = Output(UInt(16.W))
    val cout = Output(UInt(1.W))
  })

  // Define full-adder logic
  val (sum, carry) = (0 until 16).foldLeft((0.U(16.W), io.cin)) { case ((sumAcc, carryIn), i) =>
    val aBit = io.a(i)
    val bBit = io.b(i)
    val sumBit = aBit ^ bBit ^ carryIn
    val carryOut = (aBit & bBit) | (aBit & carryIn) | (bBit & carryIn)
    (sumAcc | (sumBit << i), carryOut)
  }

  io.sum := sum
  io.cout := carry
}

class dut extends Module {
  val io = IO(new Bundle {
    val i_en  = Input(Bool())
    val adda  = Input(UInt(64.W))
    val addb  = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en  = Output(Bool())
  })

  // Task 1: Input Registering and Enable Pipeline
  val adda_reg  = RegEnable(io.adda, 0.U, io.i_en)
  val addb_reg  = RegEnable(io.addb, 0.U, io.i_en)
  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))
  en_pipeline(0) := io.i_en
  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i-1)
  }

  // Task 3: Pipeline Stage Implementation
  // Stage 1
  val stage1 = Module(new RCA16)
  stage1.io.a := adda_reg(15, 0)
  stage1.io.b := addb_reg(15, 0)
  stage1.io.cin := 0.U

  val stage1_sum = RegNext(stage1.io.sum)
  val stage1_cout = RegNext(stage1.io.cout)
  val stage1_en = RegNext(en_pipeline(0))

  // Stage 2
  val stage2 = Module(new RCA16)
  stage2.io.a := adda_reg(31, 16)
  stage2.io.b := addb_reg(31, 16)
  stage2.io.cin := stage1_cout

  val stage2_sum = RegNext(stage2.io.sum)
  val stage2_cout = RegNext(stage2.io.cout)
  val stage2_en = RegNext(stage1_en)

  // Stage 3
  val stage3 = Module(new RCA16)
  stage3.io.a := adda_reg(47, 32)
  stage3.io.b := addb_reg(47, 32)
  stage3.io.cin := stage2_cout

  val stage3_sum = RegNext(stage3.io.sum)
  val stage3_cout = RegNext(stage3.io.cout)
  val stage3_en = RegNext(stage2_en)

  // Stage 4
  val stage4 = Module(new RCA16)
  stage4.io.a := adda_reg(63, 48)
  stage4.io.b := addb_reg(63, 48)
  stage4.io.cin := stage3_cout

  val stage4_sum = RegNext(stage4.io.sum)
  val final_carry = RegNext(stage4.io.cout)
  val stage4_en = RegNext(stage3_en)

  // Task 4: Result Aggregation Logic
  val result_reg = RegNext(Cat(final_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum))

  io.result := result_reg

  // Task 5: Output Enable Generation
  io.o_en := en_pipeline(3)
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
