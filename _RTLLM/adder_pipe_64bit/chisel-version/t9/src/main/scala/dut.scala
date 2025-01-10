import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Pipeline registers for partial sums and carry
  val stage1Sum = RegInit(0.U(17.W))
  val stage1Carry = RegInit(0.U(1.W))
  val stage1En = RegInit(false.B)

  val stage2Sum = RegInit(0.U(17.W))
  val stage2Carry = RegInit(0.U(1.W))
  val stage2En = RegInit(false.B)
  
  val stage3Sum = RegInit(0.U(17.W))
  val stage3Carry = RegInit(0.U(1.W))
  val stage3En = RegInit(false.B)
  
  val stage4Sum = RegInit(0.U(17.W))
  val stage4Carry = RegInit(0.U(1.W))
  val stage4En = RegInit(false.B)

  when(reset.asBool() || !io.i_en) {
    // Reset the pipeline registers
    stage1Sum := 0.U
    stage1Carry := 0.U
    stage1En := false.B
    
    stage2Sum := 0.U
    stage2Carry := 0.U
    stage2En := false.B

    stage3Sum := 0.U
    stage3Carry := 0.U
    stage3En := false.B
    
    stage4Sum := 0.U
    stage4Carry := 0.U
    stage4En := false.B
    
    io.result := 0.U
    io.o_en := false.B
  }.otherwise {
    // Stage 1: Add the lower 16 bits
    val (s1_sum, s1_carry) = io.adda(15, 0) +& io.addb(15, 0)
    stage1Sum := s1_sum
    stage1Carry := s1_carry
    stage1En := true.B

    // Stage 2: Add the next 16 bits with carry from previous stage
    val (s2_sum, s2_carry) = io.adda(31, 16) +& io.addb(31, 16) + stage1Carry
    stage2Sum := Cat(s2_carry, s2_sum)
    stage2Carry := s2_carry
    stage2En := stage1En

    // Stage 3: Add the next 16 bits with carry from previous stage
    val (s3_sum, s3_carry) = io.adda(47, 32) +& io.addb(47, 32) + stage2Carry
    stage3Sum := Cat(s3_carry, s3_sum)
    stage3Carry := s3_carry
    stage3En := stage2En

    // Stage 4: Add the upper 16 bits with carry from previous stage
    val (s4_sum, s4_carry) = io.adda(63, 48) +& io.addb(63, 48) + stage3Carry 
    stage4Sum := Cat(s4_carry, s4_sum)
    stage4Carry := 0.U
    stage4En := stage3En

    // Assemble the result from all stages
    io.result := Cat(stage4Sum, stage3Sum(15, 0), stage2Sum(15, 0), stage1Sum)
    io.o_en := stage4En
  }
}
