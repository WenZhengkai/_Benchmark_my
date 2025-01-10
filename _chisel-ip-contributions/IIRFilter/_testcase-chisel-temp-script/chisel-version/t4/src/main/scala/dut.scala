import chisel3._
import chisel3.util._

class dut(val inputWidth: Int, val coefWidth: Int, val coefDecimalWidth: Int, 
                val outputWidth: Int, val numeratorNum: Int, val denominatorNum: Int) extends Module {
  require(coefWidth >= coefDecimalWidth, "Coefficient width must be greater than or equal to the decimal width")
  require(outputWidth >= inputWidth + coefWidth + math.ceil(math.log(numeratorNum + denominatorNum)/math.log(2)).toInt + 1, 
          "Output width does not meet the minimum width requirement to prevent overflow")
          
  val io = IO(new Bundle {
    val input = Flipped(Decoupled(SInt(inputWidth.W)))
    val num   = Input(Vec(numeratorNum, SInt(coefWidth.W)))
    val den   = Input(Vec(denominatorNum, SInt(coefWidth.W)))
    val output = Decoupled(SInt(outputWidth.W))
  })

  // Define state machine states
  object State extends ChiselEnum {
    val Idle, ComputeNum, ComputeDen, StoreLast, Valid = Value
  }

  val state = RegInit(State.Idle)

  // Registers and Wires
  val coefNum = RegInit(0.U(log2Ceil(math.max(numeratorNum, denominatorNum)).W))
  val inputSum = RegInit(0.S(outputWidth.W))
  val outputSum = RegInit(0.S(outputWidth.W))
  val inputReg = Reg(SInt(inputWidth.W))
  
  val inputMem = Mem(numeratorNum, SInt(inputWidth.W))
  val outputMem = Mem(denominatorNum, SInt(outputWidth.W))

  val multIn = Wire(SInt(outputWidth.W))
  val multCoef = Wire(SInt(coefWidth.W))
  val multOut = multIn * multCoef

  // Default state machine transition
  switch(state) {
    is(State.Idle) {
      when(io.input.valid) {
        inputReg := io.input.bits
        state := State.ComputeNum
        coefNum := 0.U
        inputSum := 0.S
        outputSum := 0.S
      }
    }

    is(State.ComputeNum) {
      when(coefNum < numeratorNum.U) {
        multIn := Mux(coefNum === 0.U, inputReg, inputMem(coefNum))
        multCoef := io.num(coefNum)
        inputSum := inputSum + (multOut >> coefDecimalWidth)
        coefNum := coefNum + 1.U

        when(coefNum === (numeratorNum-1).U) {
          state := State.ComputeDen
          coefNum := 0.U
        }
      }
    }

    is(State.ComputeDen) {
      when(coefNum < denominatorNum.U) {
        multIn := outputMem(coefNum)
        multCoef := io.den(coefNum)
        outputSum := outputSum + (multOut >> coefDecimalWidth)
        coefNum := coefNum + 1.U

        when(coefNum === (denominatorNum-1).U) {
          state := State.StoreLast
        }
      }
    }

    is(State.StoreLast) {
      // Update memories
      for (i <- (numeratorNum-1) to 1 by -1) {
        inputMem(i) := inputMem(i-1)
      }
      inputMem(0) := inputReg

      for (i <- (denominatorNum-1) to 1 by -1) {
        outputMem(i) := outputMem(i-1)
      }
      outputMem(0) := io.output.bits

      state := State.Valid
    }

    is(State.Valid) {
      when(io.output.ready) {
        state := State.Idle
      }
    }
  }

  // Compute the final output
  io.output.bits := inputSum - outputSum
  io.input.ready := (state === State.Idle)
  io.output.valid := (state === State.Valid)
}


