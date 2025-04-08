import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())         // Enable signal for addition operation
    val adda   = Input(UInt(64.W))    // 64-bit input operand A
    val addb   = Input(UInt(64.W))    // 64-bit input operand B
    val result = Output(UInt(65.W))   // 65-bit output (sum of A, B, and carry)
    val o_en   = Output(Bool())       // Output enable signal
  })

  // Registers for pipeline stages
  val enaReg1 = RegInit(false.B)      // Pipeline enable register: stage 1
  val enaReg2 = RegInit(false.B)      // Pipeline enable register: stage 2
  val enaReg3 = RegInit(false.B)      // Pipeline enable register: stage 3
  val enaReg4 = RegInit(false.B)      // Pipeline enable register: stage 4

  val addaReg1 = Reg(UInt(64.W))      // Operand A: pipeline register stage 1
  val addaReg2 = Reg(UInt(64.W))      // Operand A: pipeline register stage 2
  val addaReg3 = Reg(UInt(64.W))      // Operand A: pipeline register stage 3
  val addaReg4 = Reg(UInt(64.W))      // Operand A: pipeline register stage 4

  val addbReg1 = Reg(UInt(64.W))      // Operand B: pipeline register stage 1
  val addbReg2 = Reg(UInt(64.W))      // Operand B: pipeline register stage 2
  val addbReg3 = Reg(UInt(64.W))      // Operand B: pipeline register stage 3
  val addbReg4 = Reg(UInt(64.W))      // Operand B: pipeline register stage 4

  val carryOut1 = RegInit(false.B)    // Carry out register stage 1
  val carryOut2 = RegInit(false.B)    // Carry out register stage 2
  val carryOut3 = RegInit(false.B)    // Carry out register stage 3

  val sumReg1 = Reg(UInt(17.W))       // Sum register stage 1
  val sumReg2 = Reg(UInt(17.W))       // Sum register stage 2
  val sumReg3 = Reg(UInt(17.W))       // Sum register stage 3
  val finalSum = Reg(UInt(65.W))      // Final sum register

  // Pipeline stage 1: Add lower 16 bits (0 to 15)
  when(io.i_en) {
    val lowerAdd = io.adda(15, 0) +& io.addb(15, 0)
    sumReg1 := lowerAdd // Sum of lower 16 bits (17 bits with carry)
    carryOut1 := lowerAdd(16) // Extract carry-out bit
    enaReg1 := io.i_en // Propagate enable signal
    addaReg1 := io.adda
    addbReg1 := io.addb
  }

  // Pipeline stage 2: Add next 16 bits (16 to 31) with carry from stage 1
  when(enaReg1) {
    val middleAdd = addaReg1(31, 16) +& addbReg1(31, 16) + carryOut1
    sumReg2 := middleAdd // Sum of middle 16 bits (17 bits with carry)
    carryOut2 := middleAdd(16) // Extract carry-out bit
    enaReg2 := enaReg1 // Propagate enable signal
    addaReg2 := addaReg1
    addbReg2 := addbReg1
  }

  // Pipeline stage 3: Add next 16 bits (32 to 47) with carry from stage 2
  when(enaReg2) {
    val upperAdd = addaReg2(47, 32) +& addbReg2(47, 32) + carryOut2
    sumReg3 := upperAdd // Sum of upper 16 bits (17 bits with carry)
    carryOut3 := upperAdd(16) // Extract carry-out bit
    enaReg3 := enaReg2 // Propagate enable signal
    addaReg3 := addaReg2
    addbReg3 := addbReg2
  }

  // Pipeline stage 4: Add top 16 bits (48 to 63) with carry from stage 3
  when(enaReg3) {
    val topAdd = addaReg3(63, 48) +& addbReg3(63, 48) + carryOut3
    finalSum := Cat(topAdd, sumReg3(15, 0), sumReg2(15, 0), sumReg1(15, 0)) // Concatenate the sums
    enaReg4 := enaReg3 // Propagate enable signal
  }

  // Connect final outputs
  io.result := finalSum
  io.o_en := enaReg4
}

