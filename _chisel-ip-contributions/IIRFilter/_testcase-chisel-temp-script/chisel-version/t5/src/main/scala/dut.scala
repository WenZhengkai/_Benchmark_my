import chisel3._
import chisel3.util._

class dut(
  inputWidth: Int,
  coefWidth: Int,
  coefDecimalWidth: Int,
  outputWidth: Int,
  numeratorNum: Int,
  denominatorNum: Int
) extends Module {
  require(coefWidth >= coefDecimalWidth, "coefWidth must be greater than or equal to coefDecimalWidth.")
  require(
    outputWidth >= inputWidth + coefWidth + log2Ceil(numeratorNum + denominatorNum) + 1,
    "outputWidth must meet the minimum width requirement to prevent overflow."
  )

  // I/O Definitions
  val io = IO(new Bundle {
    val input = Flipped(Decoupled(SInt(inputWidth.W)))
    val num = Input(Vec(numeratorNum, SInt(coefWidth.W)))
    val den = Input(Vec(denominatorNum, SInt(coefWidth.W)))
    val output = Decoupled(SInt(outputWidth.W))
  })

  // FSM States
  val sIdle :: sComputeNum :: sComputeDen :: sStoreLast :: sValid :: Nil = Enum(5)
  val state = RegInit(sIdle)

  // Registers and Wires
  val coefNum = RegInit(0.U(log2Ceil(numeratorNum max denominatorNum).W))
  val inputSum = RegInit(0.S((inputWidth + coefWidth + 1).W))
  val outputSum = RegInit(0.S((inputWidth + coefWidth + 1).W))
  val inputMem = Mem(numeratorNum, SInt(inputWidth.W))
  val outputMem = Mem(denominatorNum, SInt(outputWidth.W))
  val inputMemAddr = RegInit(0.U(log2Ceil(numeratorNum).W))
  val outputMemAddr = RegInit(0.U(log2Ceil(denominatorNum).W))
  val multIn = Wire(SInt(inputWidth.W))
  val multCoef = Wire(SInt(coefWidth.W))
  val multOut = Wire(SInt((inputWidth + coefWidth).W))

  // Multiplier Logic
  multIn := 0.S
  multCoef := 0.S
  multOut := multIn * multCoef

  // FSM Logic
  switch(state) {
    is(sIdle) {
      when(io.input.valid) {
        // Accept new input
        inputMem(inputMemAddr) := io.input.bits
        inputMemAddr := inputMemAddr + 1.U
        when(inputMemAddr === (numeratorNum - 1).U) {
          inputMemAddr := 0.U
        }
        
        inputSum := 0.S
        coefNum := 0.U
        state := sComputeNum
      }
    }

    is(sComputeNum) {
      when(coefNum < numeratorNum.U) {
        multIn := Mux(coefNum === 0.U, io.input.bits, inputMem(coefNum - 1.U))
        multCoef := io.num(coefNum)
        inputSum := inputSum + multOut
        coefNum := coefNum + 1.U
      }.otherwise {
        coefNum := 0.U
        outputSum := 0.S
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
      val finalOutput = (inputSum - outputSum) >> coefDecimalWidth.U
      outputMem(outputMemAddr) := finalOutput
      outputMemAddr := outputMemAddr + 1.U
      when(outputMemAddr === (denominatorNum - 1).U) {
        outputMemAddr := 0.U
      }
      state := sValid
    }

    is(sValid) {
      when(io.output.ready) {
        state := sIdle
      }
    }
  }

  // Ready/Valid Handshaking
  io.input.ready := (state === sIdle)
  io.output.valid := (state === sValid)
  io.output.bits := Mux(state === sValid, outputMem(outputMemAddr - 1.U), 0.S)
}
