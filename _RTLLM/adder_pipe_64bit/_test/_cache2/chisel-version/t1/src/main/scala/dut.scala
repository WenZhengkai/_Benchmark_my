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

  val carry = Wire(Vec(16, Bool()))
  carry(0) := io.cin

  val sum = Wire(Vec(16, Bool()))

  for (i <- 0 until 16) {
    val a_bit = io.a(i)
    val b_bit = io.b(i)
    sum(i) := a_bit ^ b_bit ^ carry(i)
    carry(i + 1) := (a_bit & b_bit) | (a_bit & carry(i)) | (b_bit & carry(i))
  }

  io.sum := sum.asUInt()
  io.cout := carry(16)
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
  when(io.i_en) {
    en_pipeline(0) := true.B
  } .otherwise {
    en_pipeline(0) := false.B
  }
  for (i <- 1 until 4) {
    en_pipeline(i) := RegNext(en_pipeline(i - 1), false.B)
  }

  // Task 2 and 3: 16-bit RCA Implementation and Pipeline Stage Implementation
  val rca16_1 = Module(new RCA16)
  rca16_1.io.a := adda_reg(15, 0)
  rca16_1.io.b := addb_reg(15, 0)
  rca16_1.io.cin := 0.U

  val stage1_sum    = RegEnable(rca16_1.io.sum, 0.U, en_pipeline(0))

  val rca16_2 = Module(new RCA16)
  rca16_2.io.a := adda_reg(31, 16)
  rca16_2.io.b := addb_reg(31, 16)
  rca16_2.io.cin := RegEnable(rca16_1.io.cout, 0.U, en_pipeline(0))

  val stage2_sum    = RegEnable(rca16_2.io.sum, 0.U, en_pipeline(1))

  val rca16_3 = Module(new RCA16)
  rca16_3.io.a := adda_reg(47, 32)
  rca16_3.io.b := addb_reg(47, 32)
  rca16_3.io.cin := RegEnable(rca16_2.io.cout, 0.U, en_pipeline(1))

  val stage3_sum    = RegEnable(rca16_3.io.sum, 0.U, en_pipeline(2))

  val rca16_4 = Module(new RCA16)
  rca16_4.io.a := adda_reg(63, 48)
  rca16_4.io.b := addb_reg(63, 48)
  rca16_4.io.cin := RegEnable(rca16_3.io.cout, 0.U, en_pipeline(2))

  val stage4_sum    = RegEnable(rca16_4.io.sum, 0.U, en_pipeline(3))
  val final_carry   = RegEnable(rca16_4.io.cout, 0.U, en_pipeline(3))

  // Task 4: Result Aggregation Logic
  io.result := Cat(final_carry, stage4_sum, stage3_sum, stage2_sum, stage1_sum)

  // Task 5: Output Enable Generation
  io.o_en := en_pipeline(3)
}

/*
object dutMain extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
