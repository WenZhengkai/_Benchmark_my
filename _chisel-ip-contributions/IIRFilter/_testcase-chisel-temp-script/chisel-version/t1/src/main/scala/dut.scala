import chisel3._
import chisel3.util._

class dut(inputWidth: Int, coefWidth: Int, coefDecimalWidth: Int, outputWidth: Int, numeratorNum: Int, denominatorNum: Int) extends Module {
  require(outputWidth >= inputWidth + coefWidth + log2Ceil(numeratorNum + denominatorNum) + 1, 
    "outputWidth is insufficient to prevent overflow.")
  require(coefWidth >= coefDecimalWidth, 
    "Coefficient width must accommodate the specified fractional precision.")

  val io = IO(new Bundle {
    val input = Flipped(Decoupled(SInt(inputWidth.W)))
    val num = Input(Vec(numeratorNum, SInt(coefWidth.W)))
    val den = Input(Vec(denominatorNum, SInt(coefWidth.W)))
    val output = Decoupled(SInt(outputWidth.W))
  })

  // FSM States
  val idle :: computeNum :: computeDen :: storeLast :: valid :: Nil = Enum(5)
  val state = RegInit(idle)

  // Buffers
  val inputMem = SyncReadMem(numeratorNum, SInt(inputWidth.W))
  val outputMem = SyncReadMem(denominatorNum, SInt(outputWidth.W))

  // Memory Indexes
  val inputMemAddr = RegInit(0.U(log2Ceil(numeratorNum).W))
  val outputMemAddr = RegInit(0.U(log2Ceil(denominatorNum).W))

  // Accumulators
  val inputSum = RegInit(0.S((outputWidth + 1).W)) // +1 for intermediate overflow
  val outputSum = RegInit(0.S((outputWidth + 1).W)) // +1 for intermediate overflow
  
  // Multiplier Datapath
  val multIn = Wire(SInt(inputWidth.W))
  val multCoef = Wire(SInt(coefWidth.W))
  val multOut = multIn * multCoef

  // Input/Output Ready/Valid Signals
  io.input.ready := state === idle
  io.output.valid := state === valid

  // Registers for storing the input and address of coefficients
  val coefNum = RegInit(0.U(log2Ceil(numeratorNum max denominatorNum + 1).W))
  val inputReg = RegInit(0.S(inputWidth.W))
  
  // Control FSM
  switch(state) {
    is(idle) {
      when(io.input.valid) {
        inputReg := io.input.bits
        inputSum := 0.S
        outputSum := 0.S
        coefNum := 0.U
        state := computeNum
      }
    }

    is(computeNum) {
      when(coefNum < numeratorNum.U) {
        multIn := Mux(coefNum === 0.U, inputReg, inputMem(coefNum - 1.U))
        multCoef := io.num(coefNum)
        inputSum := inputSum + (multOut >> coefDecimalWidth.U)
        coefNum := coefNum + 1.U
      }.otherwise {
        coefNum := 0.U
        state := computeDen
      }
    }

    is(computeDen) {
      when(coefNum < denominatorNum.U) {
        multIn := outputMem(coefNum)
        multCoef := io.den(coefNum)
        outputSum := outputSum + (multOut >> coefDecimalWidth.U)
        coefNum := coefNum + 1.U
      }.otherwise {
        state := storeLast
      }
    }

    is(storeLast) {
      // Storing the current input and output in their respective memories
      when(numeratorNum.U > 1.U) {
        inputMem.write(numeratorNum.U - 2.U, inputReg)
      }
      when(denominatorNum.U > 0.U) {
        outputMem.write(denominatorNum.U - 1.U, inputSum - outputSum)
      }
      state := valid
    }

    is(valid) {
      when(io.output.ready) {
        io.output.bits := (inputSum - outputSum).asSInt
        state := idle
      }
    }
  }

  // Output computation
  io.output.bits := (inputSum - outputSum).asSInt
}
