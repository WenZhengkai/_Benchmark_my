import chisel3._
import chisel3.util._

// Top-level IIRFilter module
class dut(
  inputWidth: Int,
  coefWidth: Int,
  coefDecimalWidth: Int,
  outputWidth: Int,
  numeratorNum: Int,
  denominatorNum: Int
) extends Module {
  
  require(coefWidth >= coefDecimalWidth, "coefWidth must be greater than or equal to coefDecimalWidth")
  require(outputWidth >= inputWidth + coefWidth + log2Ceil(numeratorNum + denominatorNum) + 1, 
          "outputWidth must meet the minimum width requirement")

  // I/O Declaration
  val io = IO(new Bundle {
    val input  = Flipped(Decoupled(SInt(inputWidth.W)))
    val num    = Input(Vec(numeratorNum, SInt(coefWidth.W)))  // Numerator coefficients (b)
    val den    = Input(Vec(denominatorNum, SInt(coefWidth.W))) // Denominator coefficients (a1, a2, ...)
    val output = Decoupled(SInt(outputWidth.W)) // Filtered output samples
  })

  // States of FSM
  val idle :: computeNum :: computeDen :: storeLast :: validOutput :: Nil = Enum(5)
  val state = RegInit(idle)

  // Registers for accumulations and intermediate values
  val inputReg = Reg(SInt(inputWidth.W))
  val inputSum = Reg(SInt((inputWidth + coefWidth + log2Ceil(numeratorNum) + 1).W))
  val outputSum = Reg(SInt((inputWidth + coefWidth + log2Ceil(denominatorNum) + 1).W))
  val coefNum = RegInit(0.U(log2Ceil(math.max(numeratorNum, denominatorNum)).W))

  // Input & Output Memories (for storing past samples)
  val inputMem = Reg(Vec(numeratorNum, SInt(inputWidth.W))) // Past input samples
  val outputMem = Reg(Vec(denominatorNum, SInt(outputWidth.W))) // Past output samples

  val inputMemAddr = RegInit(0.U(log2Ceil(numeratorNum).W))
  val outputMemAddr = RegInit(0.U(log2Ceil(denominatorNum).W))

  // Multiplicand and Multiplier
  val multIn = Wire(SInt(inputWidth.W))
  val multCoef = Wire(SInt(coefWidth.W))
  val multOut = Wire(SInt((inputWidth + coefWidth).W))
  multOut := multIn * multCoef

  // Default values
  io.input.ready := false.B
  io.output.valid := false.B
  io.output.bits := 0.S
  multIn := 0.S
  multCoef := 0.S

  // FSM Logic
  switch(state) {
    is(idle) {
      inputSum := 0.S
      outputSum := 0.S
      coefNum := 0.U
      when(io.input.valid) {
        io.input.ready := true.B
        inputReg := io.input.bits
        state := computeNum
      }
    }

    is(computeNum) {
      when(coefNum < numeratorNum.U) {
        multIn := Mux(coefNum === 0.U, inputReg, inputMem(coefNum - 1.U))
        multCoef := io.num(coefNum)
        inputSum := inputSum + multOut
        coefNum := coefNum + 1.U
      } .otherwise {
        coefNum := 0.U
        state := computeDen
      }
    }

    is(computeDen) {
      when(coefNum < denominatorNum.U) {
        multIn := outputMem(coefNum)
        multCoef := io.den(coefNum)
        outputSum := outputSum + multOut
        coefNum := coefNum + 1.U
      } .otherwise {
        state := storeLast
      }
    }

    is(storeLast) {
      // Store current input into the input memory
      for (i <- (numeratorNum - 1) until 0 by -1) {
        inputMem(i) := inputMem(i - 1)
      }
      inputMem(0) := inputReg

      // Store current output into the output memory
      for (i <- (denominatorNum - 1) until 0 by -1) {
        outputMem(i) := outputMem(i - 1)
      }
      val finalOutput = (inputSum - outputSum) >> coefDecimalWidth.U
      outputMem(0) := finalOutput.asSInt

      // Transition to the Valid state
      io.output.bits := finalOutput.asSInt
      state := validOutput
    }

    is(validOutput) {
      io.output.valid := true.B
      when(io.output.ready) {
        state := idle
      }
    }
  }
}

