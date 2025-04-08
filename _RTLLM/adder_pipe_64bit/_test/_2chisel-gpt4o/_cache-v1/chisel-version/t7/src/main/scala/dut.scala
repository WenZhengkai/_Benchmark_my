import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en   = Input(Bool())
    val adda   = Input(UInt(64.W))
    val addb   = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // Registers for pipeline stages
  val i_en_reg  = RegNext(io.i_en, init = false.B)
  val adda_reg  = RegNext(io.adda)
  val addb_reg  = RegNext(io.addb)
  
  // Intermediate sum and carry bits
  val sum0      = Wire(UInt(16.W))
  val sum1      = Wire(UInt(16.W))
  val sum2      = Wire(UInt(16.W))
  val sum3      = Wire(UInt(16.W))
  
  val carry0    = Wire(UInt(1.W))
  val carry1    = Wire(UInt(1.W))
  val carry2    = Wire(UInt(1.W))
  
  // Stage 1: Add low 16 bits
  val stage0_sum = adda_reg(15, 0) +& addb_reg(15, 0)
  sum0 := stage0_sum(15, 0)
  carry0 := stage0_sum(16)

  // Stage 2: Add next 16 bits
  val stage1_sum = (adda_reg(31, 16) +& addb_reg(31, 16)) + carry0
  sum1 := stage1_sum(15, 0)
  carry1 := stage1_sum(16)

  // Stage 3: Add the next 16 bits
  val stage2_sum = (adda_reg(47, 32) +& addb_reg(47, 32)) + carry1
  sum2 := stage2_sum(15, 0)
  carry2 := stage2_sum(16)

  // Stage 4: Add the last 16 bits
  val stage3_sum = (adda_reg(63, 48) +& addb_reg(63, 48)) + carry2
  sum3 := stage3_sum(15, 0)
  val carry_out = stage3_sum(16)

  // Pipeline the output enable signal
  val o_en_reg = RegNext(i_en_reg, init = false.B)

  // Connect outputs
  io.result := Cat(carry_out, sum3, sum2, sum1, sum0)
  io.o_en := o_en_reg
}

