import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en  = Input(Bool())
    val adda  = Input(UInt(64.W))
    val addb  = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en  = Output(Bool())
  })

  // Pipeline registers
  val stage1_en = RegInit(false.B)
  val stage2_en = RegInit(false.B)
  val stage3_en = RegInit(false.B)
  val stage4_en = RegInit(false.B)

  val stage1_adda = Reg(UInt(16.W))
  val stage1_addb = Reg(UInt(16.W))
  val stage2_adda = Reg(UInt(16.W))
  val stage2_addb = Reg(UInt(16.W))
  val stage3_adda = Reg(UInt(16.W))
  val stage3_addb = Reg(UInt(16.W))
  val stage4_adda = Reg(UInt(16.W))
  val stage4_addb = Reg(UInt(16.W))

  val stage1_carry = Reg(UInt(1.W))
  val stage2_carry = Reg(UInt(1.W))
  val stage3_carry = Reg(UInt(1.W))
  val stage4_carry = Reg(UInt(1.W))

  val stage1_sum = Reg(UInt(16.W))
  val stage2_sum = Reg(UInt(16.W))
  val stage3_sum = Reg(UInt(16.W))
  val stage4_sum = Reg(UInt(16.W))

  // Pipeline stage 1
  when(io.i_en) {
    stage1_en := true.B
    stage1_adda := io.adda(15, 0)
    stage1_addb := io.addb(15, 0)
    stage1_carry := 0.U
  }.otherwise {
    stage1_en := false.B
  }

  // Pipeline stage 2
  when(stage1_en) {
    stage2_en := true.B
    stage2_adda := io.adda(31, 16)
    stage2_addb := io.addb(31, 16)
    stage2_carry := stage1_carry
    stage1_sum := stage1_adda + stage1_addb + stage1_carry
  }.otherwise {
    stage2_en := false.B
  }

  // Pipeline stage 3
  when(stage2_en) {
    stage3_en := true.B
    stage3_adda := io.adda(47, 32)
    stage3_addb := io.addb(47, 32)
    stage3_carry := stage2_carry
    stage2_sum := stage2_adda + stage2_addb + stage2_carry
  }.otherwise {
    stage3_en := false.B
  }

  // Pipeline stage 4
  when(stage3_en) {
    stage4_en := true.B
    stage4_adda := io.adda(63, 48)
    stage4_addb := io.addb(63, 48)
    stage4_carry := stage3_carry
    stage3_sum := stage3_adda + stage3_addb + stage3_carry
  }.otherwise {
    stage4_en := false.B
  }

  // Final stage
  when(stage4_en) {
    io.o_en := true.B
    stage4_sum := stage4_adda + stage4_addb + stage4_carry
    io.result := Cat(stage4_sum, stage3_sum, stage2_sum, stage1_sum)
  }.otherwise {
    io.o_en := false.B
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), Array("--target-dir", "generated"))
}
*/
