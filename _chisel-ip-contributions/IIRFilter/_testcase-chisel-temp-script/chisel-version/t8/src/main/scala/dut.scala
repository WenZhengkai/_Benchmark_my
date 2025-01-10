import chisel3._
import chisel3.util._
import chisel3.experimental.FixedPoint
import chisel3.util.log2Ceil

class dut(
    inputWidth: Int,
    coefWidth: Int,
    coefDecimalWidth: Int,
    outputWidth: Int,
    numeratorNum: Int,
    denominatorNum: Int
) extends Module {
  require(outputWidth >= inputWidth + coefWidth + log2Ceil(numeratorNum + denominatorNum) + 1, "Output width must meet minimum requirements.")
  require(coefWidth >= coefDecimalWidth, "Coefficient width must accommodate coefficient precision.")

  val io = IO(new Bundle {
    val input = Flipped(Decoupled(SInt(inputWidth.W)))
    val num   = Input(Vec(numeratorNum, SInt(coefWidth.W)))
    val den   = Input(Vec(denominatorNum, SInt(coefWidth.W)))
    val output = Decoupled(SInt(outputWidth.W))
  })

  // State machine
  val idle :: computeNum :: computeDen :: storeLast :: valid :: Nil = Enum(5)
  val stateReg = RegInit(idle)

  // Coefficient tracking
  val coefNum = RegInit(0.U(log2Ceil(numeratorNum max denominatorNum).W))

  // Buffers for historical data
  val inputMem = Reg(Vec(numeratorNum, SInt(inputWidth.W)))
  val outputMem = Reg(Vec(denominatorNum, SInt(outputWidth.W)))

  // Registers for accumulation
  val inputSum = RegInit(0.S(outputWidth.W))
  val outputSum = RegInit(0.S(outputWidth.W))

  // Multiplier inputs and output
  val multIn = Wire(SInt(inputWidth.W))
  val multCoef = Wire(SInt(coefWidth.W))
  val multOut = multIn *& multCoef

  // Default states of signals
  io.input.ready := false.B
  io.output.valid := false.B
  io.output.bits := 0.S

  // State machine logic
  switch(stateReg) {
    is(idle) {
      io.input.ready := true.B
      inputSum := 0.S
      outputSum := 0.S
      coefNum := 0.U
      when(io.input.fire) {
        inputMem.reverse.foreach((_, idx) => if (idx > 0) inputMem(idx) := inputMem(idx - 1))
        inputMem(0) := io.input.bits
        stateReg := computeNum
      }
    }
    is(computeNum) {
      when(coefNum < numeratorNum.U) {
        multIn := inputMem(coefNum)
        multCoef := io.num(coefNum)
        inputSum := inputSum + (multOut >> coefDecimalWidth.U)
        coefNum := coefNum + 1.U
      } .otherwise {
        coefNum := 0.U
        stateReg := computeDen
      }
    }
    is(computeDen) {
      when(coefNum < denominatorNum.U) {
        multIn := outputMem(coefNum)
        multCoef := io.den(coefNum)
        outputSum := outputSum + (multOut >> coefDecimalWidth.U)
        coefNum := coefNum + 1.U
      } .otherwise {
        stateReg := storeLast
      }
    }
    is(storeLast) {
      outputMem.reverse.foreach((_, idx) => if (idx > 0) outputMem(idx) := outputMem(idx - 1))
      outputMem(0) := inputSum - outputSum
      stateReg := valid
    }
    is(valid) {
      io.output.valid := true.B
      io.output.bits := outputMem(0)
      when(io.output.fire) {
        stateReg := idle
      }
    }
  }
}
