
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

  // Number of pipeline stages
  val stages = 4

  // Registers for pipeline stages
  val aRegs = Reg(Vec(stages, UInt(16.W)))
  val bRegs = Reg(Vec(stages, UInt(16.W)))
  val carryRegs = Reg(Vec(stages + 1, Bool()))
  val enRegs = Reg(Vec(stages, Bool()))

  // Split input operands into 16-bit parts
  val aParts = VecInit(io.adda.asTypeOf(Vec(stages, UInt(16.W))))
  val bParts = VecInit(io.addb.asTypeOf(Vec(stages, UInt(16.W))))

  // Initiate the carry input as 0
  carryRegs(0) := false.B

  // Ripple carry adder implementation
  for (i <- 0 until stages) {
    // Pipeline registers
    aRegs(i) := Mux(io.i_en, aParts(i), aRegs(i))
    bRegs(i) := Mux(io.i_en, bParts(i), bRegs(i))

    // Combinatorial addition of each stage
    val fullAdder = Module(new FullAdder(16))
    fullAdder.io.a := aRegs(i)
    fullAdder.io.b := bRegs(i)
    fullAdder.io.carryIn := carryRegs(i)

    // Capture outputs in registers for next stages
    carryRegs(i + 1) := fullAdder.io.carryOut
    enRegs(i) := Mux(io.i_en, true.B, false.B)
  }

  // Assemble the final 65-bit result using the adds and carry of the last stage
  io.result := Cat(carryRegs(stages), VecInit((0 until stages).map(i => aRegs(i) + bRegs(i) + carryRegs(i))).asUInt)
  io.o_en := enRegs.last

  // Define a FullAdder module for 16-bit numbers
  class FullAdder(width: Int) extends Module {
    val io = IO(new Bundle {
      val a = Input(UInt(width.W))
      val b = Input(UInt(width.W))
      val carryIn = Input(Bool())
      val sum = Output(UInt(width.W))
      val carryOut = Output(Bool())
    })

    // Perform the addition
    val result = io.a +& io.b +& io.carryIn
    io.sum := result(width - 1, 0)
    io.carryOut := result(width)
  }
}

