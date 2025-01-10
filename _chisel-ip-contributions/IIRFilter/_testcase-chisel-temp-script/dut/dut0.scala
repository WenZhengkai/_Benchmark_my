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
  require(coefWidth >= coefDecimalWidth, "Coefficient width must be >= coefficient decimal width.")
  require(outputWidth >= inputWidth + coefWidth + log2Ceil(numeratorNum + denominatorNum) + 1, 
    "Output width must satisfy the constraint to prevent overflow.")

  val io = IO(new Bundle {
    val input = Flipped(Decoupled(SInt(inputWidth.W)))
    val num = Input(Vec(numeratorNum, SInt(coefWidth.W)))
    val den = Input(Vec(denominatorNum, SInt(coefWidth.W)))
    val output = Decoupled(SInt(outputWidth.W))
  })

  // State definitions
  val sIdle :: sComputeNum :: sComputeDen :: sStoreLast :: sValid :: Nil = Enum(5)
  val state = RegInit(sIdle)

  // Memories to store previous inputs and outputs
  val inputMem = Reg(Vec(numeratorNum, SInt(inputWidth.W)))
  val outputMem = Reg(Vec(denominatorNum, SInt(outputWidth.W)))

  // Address counters
  val coefNum = RegInit(0.U(log2Ceil(math.max(numeratorNum, denominatorNum)).W))

  // Accumulators
  val inputSum = RegInit(0.S((outputWidth + 1).W)) // Hold intermediate numerator contribution
  val outputSum = RegInit(0.S((outputWidth + 1).W)) // Hold intermediate denominator contribution

  // Wires for multiplier
  val multIn = Wire(SInt(outputWidth.W))
  val multCoef = Wire(SInt(coefWidth.W))
  val multOut = Wire(SInt((outputWidth + coefWidth).W))

  // Multiplier logic
  multIn := 0.S
  multCoef := 0.S
  multOut := multIn * multCoef

  // Ready/valid default signals
  io.input.ready := false.B
  io.output.valid := false.B
  io.output.bits := 0.S

  // State machine
  switch(state) {
    is(sIdle) {
      when(io.input.valid) {
        io.input.ready := true.B
        // Shift input samples in memory for the numerator
        for (i <- (numeratorNum - 1) to 1 by -1) {
          inputMem(i) := inputMem(i - 1)
        }
        inputMem(0) := io.input.bits
        inputSum := 0.S
        coefNum := 0.U
        state := sComputeNum
      }
    }

    is(sComputeNum) {
      multIn := inputMem(coefNum)
      multCoef := io.num(coefNum)
      inputSum := inputSum + (multOut >> coefDecimalWidth.U).asSInt
      coefNum := coefNum + 1.U
      when(coefNum === (numeratorNum - 1).U) {
        coefNum := 0.U
        outputSum := 0.S
        state := sComputeDen
      }
    }

    is(sComputeDen) {
      when(coefNum < denominatorNum.U) {
        multIn := outputMem(coefNum)
        multCoef := io.den(coefNum)
        outputSum := outputSum + (multOut >> coefDecimalWidth.U).asSInt
        coefNum := coefNum + 1.U
      }.otherwise {
        state := sStoreLast
      }
    }

    is(sStoreLast) {
      // Calculate final output: numContrib - denContrib
      val result = inputSum - outputSum
      io.output.bits := result
      io.output.valid := true.B
      when(io.output.ready) {
        // Shift output samples in memory for the denominator
        for (i <- (denominatorNum - 1) to 1 by -1) {
          outputMem(i) := outputMem(i - 1)
        }
        outputMem(0) := result
        state := sIdle
      }
    }
  }
}
