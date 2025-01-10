import chisel3._
import chisel3.util._

// Module definition for a 64-bit pipelined ripple carry adder
class dut extends Module {
  val io = IO(new Bundle {
    val i_en  = Input(Bool())
    val adda  = Input(UInt(64.W))
    val addb  = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })
  
  val enableReg = RegNext(io.i_en, false.B)
  val inputAReg = RegNext(io.adda, 0.U)
  val inputBReg = RegNext(io.addb, 0.U)
  
  // Intermediate registers for pipeline stages
  val sumRegs = RegInit(VecInit(Seq.fill(4)(0.U(16.W))))
  val carryRegs = RegInit(VecInit(Seq.fill(4)(false.B)))
  val enableRegs = RegInit(VecInit(Seq.fill(4)(false.B)))
  
  // Stage 1: Add first 16 bits
  val (sum0, carry0) = inputAReg(15, 0) +& inputBReg(15, 0)
  sumRegs(0) := sum0(15, 0)
  carryRegs(0) := carry0
  enableRegs(0) := enableReg
  
  // Stage 2: Add second 16 bits
  val (sum1, carry1) = inputAReg(31, 16) +& inputBReg(31, 16) + carryRegs(0)
  sumRegs(1) := sum1(15, 0)
  carryRegs(1) := carry1
  enableRegs(1) := enableRegs(0)
  
  // Stage 3: Add third 16 bits
  val (sum2, carry2) = inputAReg(47, 32) +& inputBReg(47, 32) + carryRegs(1)
  sumRegs(2) := sum2(15, 0)
  carryRegs(2) := carry2
  enableRegs(2) := enableRegs(1)
  
  // Stage 4: Add fourth 16 bits
  val (sum3, carry3) = inputAReg(63, 48) +& inputBReg(63, 48) + carryRegs(2)
  sumRegs(3) := sum3(15, 0)
  carryRegs(3) := carry3
  enableRegs(3) := enableRegs(2)
  
  // Concatenate the summed results and carry outs
  io.result := Cat(carryRegs(3), sumRegs(3), sumRegs(2), sumRegs(1), sumRegs(0))
  io.o_en := enableRegs(3)
}

