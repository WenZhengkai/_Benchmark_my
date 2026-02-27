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
  val reg_en_1 = RegInit(false.B)
  val reg_en_2 = RegInit(false.B)
  val reg_en_3 = RegInit(false.B)
  val reg_en_4 = RegInit(false.B)
  
  // Pipeline enable signal propagation
  reg_en_1 := io.i_en
  reg_en_2 := reg_en_1
  reg_en_3 := reg_en_2
  reg_en_4 := reg_en_3
  
  // Output enable signal
  io.o_en := reg_en_4
  
  // Split inputs into 4 parts (16-bits each)
  val adda_parts = Wire(Vec(4, UInt(16.W)))
  val addb_parts = Wire(Vec(4, UInt(16.W)))
  
  for (i <- 0 until 4) {
    adda_parts(i) := io.adda((i+1)*16-1, i*16)
    addb_parts(i) := io.addb((i+1)*16-1, i*16)
  }
  
  // Stage 1: First 16 bits
  val sum_stage1 = Wire(UInt(16.W))
  val carry_stage1 = Wire(Bool())
  val temp_sum_stage1 = adda_parts(0) +& addb_parts(0)
  sum_stage1 := temp_sum_stage1(15, 0)
  carry_stage1 := temp_sum_stage1(16)
  
  // Pipeline registers for Stage 1 results
  val reg_sum_stage1 = RegInit(0.U(16.W))
  val reg_carry_stage1 = RegInit(false.B)
  val reg_adda_parts_1 = RegInit(VecInit(Seq.fill(3)(0.U(16.W))))
  val reg_addb_parts_1 = RegInit(VecInit(Seq.fill(3)(0.U(16.W))))
  
  when (io.i_en) {
    reg_sum_stage1 := sum_stage1
    reg_carry_stage1 := carry_stage1
    for (i <- 0 until 3) {
      reg_adda_parts_1(i) := adda_parts(i+1)
      reg_addb_parts_1(i) := addb_parts(i+1)
    }
  }
  
  // Stage 2: Second 16 bits + carry from stage 1
  val sum_stage2 = Wire(UInt(16.W))
  val carry_stage2 = Wire(Bool())
  val temp_sum_stage2 = reg_adda_parts_1(0) +& reg_addb_parts_1(0) + reg_carry_stage1
  sum_stage2 := temp_sum_stage2(15, 0)
  carry_stage2 := temp_sum_stage2(16)
  
  // Pipeline registers for Stage 2 results
  val reg_sum_stage1_2 = RegInit(0.U(16.W))
  val reg_sum_stage2 = RegInit(0.U(16.W))
  val reg_carry_stage2 = RegInit(false.B)
  val reg_adda_parts_2 = RegInit(VecInit(Seq.fill(2)(0.U(16.W))))
  val reg_addb_parts_2 = RegInit(VecInit(Seq.fill(2)(0.U(16.W))))
  
  when (reg_en_1) {
    reg_sum_stage1_2 := reg_sum_stage1
    reg_sum_stage2 := sum_stage2
    reg_carry_stage2 := carry_stage2
    for (i <- 0 until 2) {
      reg_adda_parts_2(i) := reg_adda_parts_1(i+1)
      reg_addb_parts_2(i) := reg_addb_parts_1(i+1)
    }
  }
  
  // Stage 3: Third 16 bits + carry from stage 2
  val sum_stage3 = Wire(UInt(16.W))
  val carry_stage3 = Wire(Bool())
  val temp_sum_stage3 = reg_adda_parts_2(0) +& reg_addb_parts_2(0) + reg_carry_stage2
  sum_stage3 := temp_sum_stage3(15, 0)
  carry_stage3 := temp_sum_stage3(16)
  
  // Pipeline registers for Stage 3 results
  val reg_sum_stage1_3 = RegInit(0.U(16.W))
  val reg_sum_stage2_3 = RegInit(0.U(16.W))
  val reg_sum_stage3 = RegInit(0.U(16.W))
  val reg_carry_stage3 = RegInit(false.B)
  val reg_adda_parts_3 = RegInit(0.U(16.W))
  val reg_addb_parts_3 = RegInit(0.U(16.W))
  
  when (reg_en_2) {
    reg_sum_stage1_3 := reg_sum_stage1_2
    reg_sum_stage2_3 := reg_sum_stage2
    reg_sum_stage3 := sum_stage3
    reg_carry_stage3 := carry_stage3
    reg_adda_parts_3 := reg_adda_parts_2(1)
    reg_addb_parts_3 := reg_addb_parts_2(1)
  }
  
  // Stage 4: Fourth 16 bits + carry from stage 3
  val sum_stage4 = Wire(UInt(16.W))
  val carry_stage4 = Wire(Bool())
  val temp_sum_stage4 = reg_adda_parts_3 +& reg_addb_parts_3 + reg_carry_stage3
  sum_stage4 := temp_sum_stage4(15, 0)
  carry_stage4 := temp_sum_stage4(16)
  
  // Pipeline registers for final result
  val reg_result = RegInit(0.U(65.W))
  
  when (reg_en_3) {
    reg_result := Cat(carry_stage4, sum_stage4, reg_sum_stage3, reg_sum_stage2_3, reg_sum_stage1_3)
  }
  
  // Connect the result to the output
  io.result := reg_result
}
