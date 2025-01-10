import chisel3._
import chisel3.util._

class dut(inputWidth: Int, coefWidth: Int, coefDecimalWidth: Int, outputWidth: Int, numeratorNum: Int, denominatorNum: Int) extends Module {
  require(coefWidth >= coefDecimalWidth, "Coefficient width must be greater than or equal to coefficient decimal width")
  require(outputWidth >= inputWidth + coefWidth + log2Ceil(numeratorNum + denominatorNum) + 1, 
    "Output width must be sufficient to prevent overflow")

  val io = IO(new Bundle {
    val input = Flipped(Decoupled(SInt(inputWidth.W)))
    val num = Input(Vec(numeratorNum, SInt(coefWidth.W)))
    val den = Input(Vec(denominatorNum, SInt(coefWidth.W)))
    val output = Decoupled(SInt(outputWidth.W))
  })

  // State Definitions
  val sIdle :: sComputeNum :: sComputeDen :: sStoreLast :: sValid :: Nil = Enum(5)
  val state = RegInit(sIdle)

  // Registers and Wires
  val inputSum = Reg(SInt((outputWidth + coefDecimalWidth).W))
  val outputSum = Reg(SInt((outputWidth + coefDecimalWidth).W))
  val multIn = Wire(SInt(outputWidth.W))
  val multCoef = Wire(SInt(coefWidth.W))
  val multOut = Wire(SInt((outputWidth + coefWidth).W))
  
  multOut := multIn * multCoef

  // State Variables
  val coefNum = RegInit(0.U(log2Ceil(math.max(numeratorNum, denominatorNum)).W))
  val inputMem = SyncReadMem(numeratorNum, SInt(inputWidth.W))
  val outputMem = SyncReadMem(denominatorNum, SInt(outputWidth.W))

  // FSM Logic
  io.input.ready := (state === sIdle)
  io.output.valid := (state === sValid)
  io.output.bits := (inputSum.asSInt() - outputSum.asSInt()).asSInt() >> coefDecimalWidth

  switch(state) {
    is(sIdle) {
      when(io.input.valid) {
        state := sComputeNum
        coefNum := 0.U
        inputSum := 0.S
      }
    }
    is(sComputeNum) {
      when(coefNum < numeratorNum.U) {
        multIn := Mux(coefNum === 0.U, io.input.bits, inputMem.read(coefNum - 1.U))
        multCoef := io.num(coefNum)
        inputSum := inputSum + multOut.asSInt()
        coefNum := coefNum + 1.U
      }.otherwise {
        state := sComputeDen
        coefNum := 0.U
        outputSum := 0.S
      }
    }
    is(sComputeDen) {
      when(coefNum < denominatorNum.U) {
        multIn := outputMem.read(coefNum)
        multCoef := io.den(coefNum)
        outputSum := outputSum + multOut.asSInt()
        coefNum := coefNum + 1.U
      }.otherwise {
        state := sStoreLast
      }
    }
    is(sStoreLast) {
      inputMem.write(numeratorNum.U - 1.U, io.input.bits)
      outputMem.write(denominatorNum.U - 1.U, io.output.bits)
      state := sValid
    }
    is(sValid) {
      when(io.output.ready) {
        state := sIdle
      }
    }
  }
}
