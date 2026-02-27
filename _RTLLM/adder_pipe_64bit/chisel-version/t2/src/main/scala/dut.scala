import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    // Input ports
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    
    // Output ports
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })
  
  // Pipeline registers for enable signal
  val en_reg1 = RegInit(false.B)
  val en_reg2 = RegInit(false.B)
  val en_reg3 = RegInit(false.B)
  val en_reg4 = RegInit(false.B)
  
  // Pipeline stage 1: Process bits 0-15
  val adda_reg1 = RegInit(0.U(16.W))
  val addb_reg1 = RegInit(0.U(16.W))
  val carry_reg1 = RegInit(0.U(1.W))
  
  // Pipeline stage 2: Process bits 16-31
  val adda_reg2 = RegInit(0.U(16.W))
  val addb_reg2 = RegInit(0.U(16.W))
  val carry_reg2 = RegInit(0.U(1.W))
  val sum_reg1 = RegInit(0.U(16.W))
  
  // Pipeline stage 3: Process bits 32-47
  val adda_reg3 = RegInit(0.U(16.W))
  val addb_reg3 = RegInit(0.U(16.W))
  val carry_reg3 = RegInit(0.U(1.W))
  val sum_reg2 = RegInit(0.U(16.W))
  
  // Pipeline stage 4: Process bits 48-63
  val adda_reg4 = RegInit(0.U(16.W))
  val addb_reg4 = RegInit(0.U(16.W))
  val sum_reg3 = RegInit(0.U(16.W))
  
  // Final result registers
  val sum_reg4 = RegInit(0.U(16.W))
  val final_carry = RegInit(0.U(1.W))
  
  // Pipeline stage 1
  when (io.i_en) {
    adda_reg1 := io.adda(15, 0)
    addb_reg1 := io.addb(15, 0)
    adda_reg2 := io.adda(31, 16)
    addb_reg2 := io.addb(31, 16)
    adda_reg3 := io.adda(47, 32)
    addb_reg3 := io.addb(47, 32)
    adda_reg4 := io.adda(63, 48)
    addb_reg4 := io.addb(63, 48)
    en_reg1 := true.B
  }.otherwise {
    en_reg1 := false.B
  }
  
  // Calculate first stage
  val sum1 = adda_reg1 +& addb_reg1  // +& includes carry
  
  // Pipeline stage 2
  when (en_reg1) {
    sum_reg1 := sum1(15, 0)
    carry_reg2 := sum1(16)
    en_reg2 := true.B
  }.otherwise {
    en_reg2 := false.B
  }
  
  // Calculate second stage
  val sum2 = adda_reg2 +& addb_reg2 + carry_reg2
  
  // Pipeline stage 3
  when (en_reg2) {
    sum_reg2 := sum2(15, 0)
    carry_reg3 := sum2(16)
    en_reg3 := true.B
  }.otherwise {
    en_reg3 := false.B
  }
  
  // Calculate third stage
  val sum3 = adda_reg3 +& addb_reg3 + carry_reg3
  
  // Pipeline stage 4
  when (en_reg3) {
    sum_reg3 := sum3(15, 0)
    carry_reg1 := sum3(16)
    en_reg4 := true.B
  }.otherwise {
    en_reg4 := false.B
  }
  
  // Calculate fourth stage
  val sum4 = adda_reg4 +& addb_reg4 + carry_reg1
  
  // Final stage
  when (en_reg4) {
    sum_reg4 := sum4(15, 0)
    final_carry := sum4(16)
  }
  
  // Assemble final result
  io.result := Cat(
    final_carry,
    sum_reg4,
    sum_reg3,
    sum_reg2,
    sum_reg1
  )
  
  // Output enable signal
  io.o_en := en_reg4
}
