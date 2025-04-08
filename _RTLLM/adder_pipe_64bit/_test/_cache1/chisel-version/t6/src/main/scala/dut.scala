import chisel3._
import chisel3.util._

class RCA16 extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(16.W))
    val b = Input(UInt(16.W))
    val cin = Input(Bool())
    val sum = Output(UInt(16.W))
    val cout = Output(Bool())
  })

  val (sum, cout) = (0 until 16).foldLeft((0.U(16.W), io.cin)) { case ((s, c), i) =>
    val fullAdder = Module(new FullAdder)
    fullAdder.io.a := io.a(i)
    fullAdder.io.b := io.b(i)
    fullAdder.io.cin := c
    (s | (fullAdder.io.sum << i), fullAdder.io.cout)
  }
  
  io.sum := sum
  io.cout := cout
}

class FullAdder extends Module {
  val io = IO(new Bundle {
    val a = Input(Bool())
    val b = Input(Bool())
    val cin = Input(Bool())
    val sum = Output(Bool())
    val cout = Output(Bool())
  })

  io.sum := io.a ^ io.b ^ io.cin
  io.cout := (io.a & io.b) | (io.b & io.cin) | (io.a & io.cin)
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
    en_pipeline(i) := en_pipeline(i - 1)
  }

  // Task 2: 16-bit Ripple Carry Adder
  def makeRCA16(a: UInt, b: UInt, cin: Bool): (UInt, Bool) = {
    val rca = Module(new RCA16)
    rca.io.a := a
    rca.io.b := b
    rca.io.cin := cin
    (rca.io.sum, rca.io.cout)
  }

  // Task 3: Pipeline Stage Implementation
  val (stage1_sum, stage1_cout) = makeRCA16(adda_reg(15, 0), addb_reg(15, 0), false.B)
  val (stage2_sum, stage2_cout) = makeRCA16(RegEnable(adda_reg(31, 16), en_pipeline(0)), RegEnable(addb_reg(31, 16), en_pipeline(0)), RegEnable(stage1_cout, en_pipeline(0)))
  val (stage3_sum, stage3_cout) = makeRCA16(RegEnable(adda_reg(47, 32), en_pipeline(1)), RegEnable(addb_reg(47, 32), en_pipeline(1)), RegEnable(stage2_cout, en_pipeline(1)))
  val (stage4_sum, stage4_cout) = makeRCA16(RegEnable(adda_reg(63, 48), en_pipeline(2)), RegEnable(addb_reg(63, 48), en_pipeline(2)), RegEnable(stage3_cout, en_pipeline(2)))

  // Task 4: Result Aggregation Logic
  val result_reg = RegEnable(Cat(stage4_cout, stage4_sum, stage3_sum, stage2_sum, stage1_sum), en_pipeline(3))
  io.result := result_reg

  // Task 5: Output Enable Generation
  io.o_en := en_pipeline(3)
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
