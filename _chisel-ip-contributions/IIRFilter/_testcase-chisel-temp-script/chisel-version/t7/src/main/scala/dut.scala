import chisel3._
import chisel3.util._

class dut(val inputWidth: Int, val coefWidth: Int, val coefDecimalWidth: Int, 
                val outputWidth: Int, val numeratorNum: Int, val denominatorNum: Int) extends Module {

  require(coefWidth >= coefDecimalWidth, "Coefficient fractional precision must be less than or equal to coefficient width")
  require(outputWidth >= inputWidth + coefWidth + log2Ceil(numeratorNum + denominatorNum) + 1,
          "Output width does not meet minimum required to prevent overflow")

  val io = IO(new Bundle {
    val input = Flipped(Decoupled(SInt(inputWidth.W)))
    val num = Input(Vec(numeratorNum, SInt(coefWidth.W)))
    val den = Input(Vec(denominatorNum, SInt(coefWidth.W)))
    val output = Decoupled(SInt(outputWidth.W))
  })

  // State Enum
  val sIdle :: sComputeNum :: sComputeDen :: sStoreLast :: sValid :: Nil = Enum(5)
  val state = RegInit(sIdle)

  val inputMem = Reg(Vec(numeratorNum, SInt(inputWidth.W)))
  val outputMem = Reg(Vec(denominatorNum, SInt(outputWidth.W)))
  val inputSum = RegInit(0.S(outputWidth.W))
  val outputSum = RegInit(0.S(outputWidth.W))
  val coefNum = RegInit(0.U(log2Ceil(numeratorNum max denominatorNum).W))

  val multIn = Wire(SInt(outputWidth.W))
  val multCoef = Wire(SInt(coefWidth.W))
  val multOut = Wire(SInt(outputWidth.W))

  multOut := (multIn * multCoef) >> coefDecimalWidth

  when(io.input.valid && state === sIdle) {
    inputMem(0) := io.input.bits
    coefNum := 1.U
    inputSum := 0.S
    outputSum := 0.S
    state := sComputeNum
  }

  switch(state) {
    is(sComputeNum) {
      when(coefNum < numeratorNum.U) {
        multIn := inputMem(coefNum)
        multCoef := io.num(coefNum)
        inputSum := inputSum + multOut
        coefNum := coefNum + 1.U
      } .otherwise {
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
      } .otherwise {
        state := sStoreLast
      }
    }
    is(sStoreLast) {
      io.output.bits := inputSum - outputSum
      io.output.valid := true.B
      when(io.output.ready) {
        for(i <- denominatorNum-1 to 1 by -1) {
          outputMem(i) := outputMem(i-1)
        }
        outputMem(0) := io.output.bits
        for(i <- numeratorNum-1 to 1 by -1) {
          inputMem(i) := inputMem(i-1)
        }
        state := sIdle
      } .otherwise {
        state := sValid
      }
    }
    is(sValid) {
      when(io.output.ready) {
        io.output.valid := false.B
        state := sIdle
      }
    }
  }

  io.input.ready := (state === sIdle)
}

