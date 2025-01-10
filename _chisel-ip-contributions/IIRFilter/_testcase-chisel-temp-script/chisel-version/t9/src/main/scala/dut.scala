import chisel3._
import chisel3.util._

class dut(
  val inputWidth: Int,
  val coefWidth: Int,
  val coefDecimalWidth: Int,
  val outputWidth: Int,
  val numeratorNum: Int,
  val denominatorNum: Int
) extends Module {
  require(coefWidth >= coefDecimalWidth, "Coefficient width must be greater than or equal to decimal width")
  require(outputWidth >= inputWidth + coefWidth + log2Ceil(numeratorNum + denominatorNum) + 1,
    "Output width must be sufficient to handle potential overflow")

  val io = IO(new Bundle {
    val input = Flipped(Decoupled(SInt(inputWidth.W)))
    val num = Input(Vec(numeratorNum, SInt(coefWidth.W)))
    val den = Input(Vec(denominatorNum, SInt(coefWidth.W)))
    val output = Decoupled(SInt(outputWidth.W))
  })

  val inputMem = RegInit(VecInit(Seq.fill(numeratorNum)(0.S(inputWidth.W))))
  val outputMem = RegInit(VecInit(Seq.fill(denominatorNum)(0.S(outputWidth.W))))

  val state = RegInit(0.U(3.W))  // State: Idle(0), ComputeNum(1), ComputeDen(2), StoreLast(3), Valid(4)
  val coefNum = RegInit(0.U(log2Ceil(numeratorNum max denominatorNum).W))

  val inputSum = RegInit(0.S(outputWidth.W))
  val outputSum = RegInit(0.S(outputWidth.W))

  val multIn = Reg(SInt(outputWidth.W))
  val multCoef = Reg(SInt(coefWidth.W))
  val multOut = Wire(SInt(outputWidth.W))

  multOut := (multIn * multCoef).asSInt()

  switch(state) {
    is(0.U) { // Idle State
      io.input.ready := true.B
      io.output.valid := false.B
      when(io.input.valid) {
        state := 1.U
        inputMem(0) := io.input.bits
      }
    }
    is(1.U) { // ComputeNum State
      io.input.ready := false.B
      when(coefNum < numeratorNum.U) {
        multIn := Mux(coefNum === 0.U, io.input.bits, inputMem(coefNum))
        multCoef := io.num(coefNum)
        inputSum := inputSum + multOut
        inputMem := inputMem.tail :+ inputMem.head
        coefNum := coefNum + 1.U
      }.otherwise {
        coefNum := 0.U
        state := 2.U
      }
    }
    is(2.U) { // ComputeDen State
      when(coefNum < denominatorNum.U) {
        multIn := outputMem(coefNum)
        multCoef := io.den(coefNum)
        outputSum := outputSum + multOut
        outputMem := outputMem.tail :+ outputMem.head
        coefNum := coefNum + 1.U
      }.otherwise {
        coefNum := 0.U
        state := 3.U
      }
    }
    is(3.U) { // StoreLast State
      io.output.bits := ((inputSum - outputSum) >> coefDecimalWidth.U).asSInt
      outputMem(0) := io.output.bits
      inputSum := 0.S
      outputSum := 0.S
      state := 4.U
    }
    is(4.U) { // Valid State
      io.output.valid := true.B
      when(io.output.ready) {
        state := 0.U
      }
    }
  }

  io.output.valid := state === 4.U
}


