import chisel3._
import chisel3.util._

class dut(val inputWidth: Int, val coefWidth: Int, val coefDecimalWidth: Int, val outputWidth: Int, val numeratorNum: Int, val denominatorNum: Int) extends Module {
  require(coefWidth >= coefDecimalWidth, "Coefficient width must be greater than or equal to the decimal width.")
  require(outputWidth >= inputWidth + coefWidth + log2Ceil(numeratorNum + denominatorNum) + 1, "Output width does not meet the minimum width requirement to prevent overflow.")

  val io = IO(new Bundle {
    val input = Flipped(Decoupled(SInt(inputWidth.W)))
    val num = Input(Vec(numeratorNum, SInt(coefWidth.W)))
    val den = Input(Vec(denominatorNum, SInt(coefWidth.W)))
    val output = Decoupled(SInt(outputWidth.W))
  })

  // States definition
  val sIdle :: sComputeNum :: sComputeDen :: sStoreLast :: sValid :: Nil = Enum(5)
  val state = RegInit(sIdle)

  // Internal registers/memories
  val inputMem = Mem(numeratorNum, SInt(inputWidth.W))
  val outputMem = Mem(denominatorNum, SInt(outputWidth.W))

  val inputSum = Reg(SInt(outputWidth.W))
  val outputSum = Reg(SInt(outputWidth.W))
  val inputReg = Reg(SInt(inputWidth.W))

  val coefNum = RegInit(0.U(log2Ceil(math.max(numeratorNum, denominatorNum)).W))

  // Multiplier wires
  val multIn = Wire(SInt(outputWidth.W))
  val multCoef = Wire(SInt(coefWidth.W))
  val multOut = Wire(SInt(outputWidth.W))

  multOut := (multIn * multCoef) >> coefDecimalWidth

  // Control logic
  io.input.ready := (state === sIdle)
  io.output.valid := (state === sValid)

  io.output.bits := inputSum - outputSum

  switch(state) {
    is(sIdle) {
      when(io.input.fire()) {
        inputReg := io.input.bits
        state := sComputeNum
      }
    }
    is(sComputeNum) {
      when(coefNum < numeratorNum.U) {
        multIn := Mux(coefNum === 0.U, inputReg, inputMem(coefNum - 1.U))
        multCoef := io.num(coefNum)
        inputSum := inputSum + multOut
        coefNum := coefNum + 1.U
      }.otherwise {
        coefNum := 0.U
        state := sComputeDen
      }
    }
    is(sComputeDen) {
      when(coefNum < denominatorNum.U) {
        multIn := outputMem(coefNum)
        multCoef := io.den(coefNum)
        outputSum := outputSum + multOut
        coefNum := coefNum + 1.U
      }.otherwise {
        coefNum := 0.U
        state := sStoreLast
      }
    }
    is(sStoreLast) {
      for (i <- numeratorNum - 1 to 1 by -1) {
        inputMem(i) := inputMem(i - 1)
      }
      for (i <- denominatorNum - 1 to 1 by -1) {
        outputMem(i) := outputMem(i - 1)
      }
      inputMem(0) := inputReg
      outputMem(0) := io.output.bits
      state := sValid
    }
    is(sValid) {
      when(io.output.fire()) {
        inputSum := 0.S
        outputSum := 0.S
        state := sIdle
      }
    }
  }
}
