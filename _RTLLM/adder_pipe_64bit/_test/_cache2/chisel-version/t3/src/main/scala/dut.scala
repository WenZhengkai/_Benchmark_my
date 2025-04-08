import chisel3._
import chisel3.util._

// Define a 16-bit Ripple Carry Adder
class RCA16 extends Module {
  val io = IO(new Bundle {
    val a = Input(UInt(16.W))
    val b = Input(UInt(16.W))
    val cin = Input(Bool())
    val sum = Output(UInt(16.W))
    val cout = Output(Bool())
  })

  // Generate 16 full adders chain
  val c = Wire(Vec(16, Bool()))
  val s = VecInit((0 until 16).map { i =>
    val fullAdder = Module(new FullAdder)
    fullAdder.io.a := io.a(i)
    fullAdder.io.b := io.b(i)
    fullAdder.io.cin := if (i == 0) io.cin else c(i - 1)
    c(i) := fullAdder.io.cout
    fullAdder.io.sum
  })

  io.sum := s.asUInt
  io.cout := c(15)
}

// A simple Full Adder Module
class FullAdder extends Module {
  val io = IO(new Bundle {
    val a = Input(Bool())
    val b = Input(Bool())
    val cin = Input(Bool())
    val sum = Output(Bool())
    val cout = Output(Bool())
  })
  
  val sum = io.a ^ io.b ^ io.cin
  val cout = (io.a & io.b) | (io.a & io.cin) | (io.b & io.cin)

  io.sum := sum
  io.cout := cout
}

// Module for 64-bit pipelined adder
class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Task 1: Input Registering and Enable Pipeline
  val adda_reg = RegEnable(io.adda, 0.U(64.W), io.i_en)
  val addb_reg = RegEnable(io.addb, 0.U(64.W), io.i_en)

  val en_pipeline = RegInit(VecInit(Seq.fill(4)(false.B)))
  en_pipeline(0) := io.i_en
  (1 until 4).foreach { i => en_pipeline(i) := en_pipeline(i - 1) }

  // Task 2 & 3: Implement 16-bit RCA and pipeline stages
  val rcas = Seq.fill(4)(Module(new RCA16))
  val carry = Wire(Vec(4, Bool()))
  val sum_segs = Wire(Vec(4, UInt(16.W)))

  // Stage 1
  rcas(0).io.a := adda_reg(15, 0)
  rcas(0).io.b := addb_reg(15, 0)
  rcas(0).io.cin := false.B
  sum_segs(0) := RegNext(rcas(0).io.sum)
  carry(0) := RegNext(rcas(0).io.cout)

  // Stage 2
  rcas(1).io.a := adda_reg(31, 16)
  rcas(1).io.b := addb_reg(31, 16)
  rcas(1).io.cin := carry(0)
  sum_segs(1) := RegNext(rcas(1).io.sum)
  carry(1) := RegNext(rcas(1).io.cout)

  // Stage 3
  rcas(2).io.a := adda_reg(47, 32)
  rcas(2).io.b := addb_reg(47, 32)
  rcas(2).io.cin := carry(1)
  sum_segs(2) := RegNext(rcas(2).io.sum)
  carry(2) := RegNext(rcas(2).io.cout)

  // Stage 4
  rcas(3).io.a := adda_reg(63, 48)
  rcas(3).io.b := addb_reg(63, 48)
  rcas(3).io.cin := carry(2)
  sum_segs(3) := RegNext(rcas(3).io.sum)
  carry(3) := RegNext(rcas(3).io.cout)

  // Task 4: Result Aggregation Logic
  val result_reg = RegNext(Cat(carry(3), sum_segs(3), sum_segs(2), sum_segs(1), sum_segs(0)))
  io.result := result_reg

  // Task 5: Output Enable Generation
  io.o_en := RegNext(en_pipeline(3))
}

// Usage example in a Chisel test or other module would follow
