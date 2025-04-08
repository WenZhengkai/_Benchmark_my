import chisel3._
import chisel3.util._

class RCA16 extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(16.W))
    val b = Input(UInt(16.W))
    val cin = Input(UInt(1.W))
    val sum = Output(UInt(16.W))
    val cout = Output(UInt(1.W))
  })

  val sum = Wire(UInt(17.W))  // 16 bits for sum and 1 bit for carry
  sum := io.a + io.b + io.cin
  io.sum := sum(15, 0)
  io.cout := sum(16)
}

class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))

    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Task 1: Input Registering and Enable Pipeline
  val adda_reg = RegEnable(io.adda, 0.U, io.i_en)
  val addb_reg = RegEnable(io.addb, 0.U, io.i_en)

  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))
  when (io.i_en) {
    en_pipeline(0) := true.B
  }
  .otherwise {
    en_pipeline(0) := false.B
  }

  for (i <- 1 until 4) {
    en_pipeline(i) := en_pipeline(i-1)
  }

  // Task 2 & 3: 16-bit RCAs and Pipeline Stages
  val rca0 = Module(new RCA16)
  rca0.io.a := adda_reg(15, 0)
  rca0.io.b := addb_reg(15, 0)
  rca0.io.cin := 0.U

  val stage1_sum = RegNext(rca0.io.sum)
  val stage1_cout = RegNext(rca0.io.cout)

  val rca1 = Module(new RCA16)
  rca1.io.a := adda_reg(31, 16)
  rca1.io.b := addb_reg(31, 16)
  rca1.io.cin := stage1_cout

  val stage2_sum = RegNext(rca1.io.sum)
  val stage2_cout = RegNext(rca1.io.cout)

  val rca2 = Module(new RCA16)
  rca2.io.a := adda_reg(47, 32)
  rca2.io.b := addb_reg(47, 32)
  rca2.io.cin := stage2_cout

  val stage3_sum = RegNext(rca2.io.sum)
  val stage3_cout = RegNext(rca2.io.cout)

  val rca3 = Module(new RCA16)
  rca3.io.a := adda_reg(63, 48)
  rca3.io.b := addb_reg(63, 48)
  rca3.io.cin := stage3_cout

  val stage4_sum = RegNext(rca3.io.sum)
  val final_carry = RegNext(rca3.io.cout)

  // Task 4: Result Aggregation Logic
  val result_reg = RegNext(Cat(final_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum))

  // Task 5: Output Enable Generation
  io.result := result_reg
  io.o_en := en_pipeline(3)
}

/*
object dutApp extends App {
  chisel3.Driver.execute(Array[String](), () => new dut)
}
*/
