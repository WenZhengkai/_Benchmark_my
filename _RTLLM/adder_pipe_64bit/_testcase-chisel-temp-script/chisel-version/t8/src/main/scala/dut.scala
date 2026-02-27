import chisel3._
import chisel3.util._

class RippleCarryAdder(width: Int) extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(width.W))
    val addb = Input(UInt(width.W))
    val result = Output(UInt((width + 1).W))
    val o_en = Output(Bool())
  })
  
  // Enable signal pipeline registers
  val en_reg1 = RegInit(false.B)
  val en_reg2 = RegInit(false.B)
  val en_reg3 = RegInit(false.B)
  val en_reg4 = RegInit(false.B)
  
  // Input data registers for stage 1
  val adda_reg = RegInit(0.U(width.W))
  val addb_reg = RegInit(0.U(width.W))
  
  // Update input registers when enabled
  when (io.i_en) {
    adda_reg := io.adda
    addb_reg := io.addb
  }
  
  // Update enable pipeline registers
  en_reg1 := io.i_en
  en_reg2 := en_reg1
  en_reg3 := en_reg2
  en_reg4 := en_reg3
  
  // Define width for each pipeline segment (16 bits)
  val segmentWidth = width / 4
  
  // Stage 1: Process first 16 bits
  val sum1 = Wire(UInt((segmentWidth + 1).W))
  sum1 := adda_reg(segmentWidth-1, 0) +& addb_reg(segmentWidth-1, 0)
  val sum1_reg = RegInit(0.U((segmentWidth + 1).W))
  val adda_stage2 = RegInit(0.U(width.W))
  val addb_stage2 = RegInit(0.U(width.W))
  
  when (en_reg1) {
    sum1_reg := sum1
    adda_stage2 := adda_reg
    addb_stage2 := addb_reg
  }
  
  // Stage 2: Process second 16 bits with carry from stage 1
  val sum2 = Wire(UInt((segmentWidth + 1).W))
  sum2 := adda_stage2(segmentWidth*2-1, segmentWidth) +& 
          addb_stage2(segmentWidth*2-1, segmentWidth) + 
          sum1_reg(segmentWidth)
  
  val sum2_reg = RegInit(0.U((segmentWidth + 1).W))
  val sum1_final_reg = RegInit(0.U(segmentWidth.W))
  val adda_stage3 = RegInit(0.U(width.W))
  val addb_stage3 = RegInit(0.U(width.W))
  
  when (en_reg2) {
    sum2_reg := sum2
    sum1_final_reg := sum1_reg(segmentWidth-1, 0)
    adda_stage3 := adda_stage2
    addb_stage3 := addb_stage2
  }
  
  // Stage 3: Process third 16 bits with carry from stage 2
  val sum3 = Wire(UInt((segmentWidth + 1).W))
  sum3 := adda_stage3(segmentWidth*3-1, segmentWidth*2) +& 
          addb_stage3(segmentWidth*3-1, segmentWidth*2) + 
          sum2_reg(segmentWidth)
  
  val sum3_reg = RegInit(0.U((segmentWidth + 1).W))
  val sum2_final_reg = RegInit(0.U(segmentWidth.W))
  val sum1_final_reg2 = RegInit(0.U(segmentWidth.W))
  val adda_stage4 = RegInit(0.U(width.W))
  val addb_stage4 = RegInit(0.U(width.W))
  
  when (en_reg3) {
    sum3_reg := sum3
    sum2_final_reg := sum2_reg(segmentWidth-1, 0)
    sum1_final_reg2 := sum1_final_reg
    adda_stage4 := adda_stage3
    addb_stage4 := addb_stage3
  }
  
  // Stage 4: Process fourth 16 bits with carry from stage 3
  val sum4 = Wire(UInt((segmentWidth + 1).W))
  sum4 := adda_stage4(width-1, segmentWidth*3) +& 
          addb_stage4(width-1, segmentWidth*3) + 
          sum3_reg(segmentWidth)
  
  val sum4_reg = RegInit(0.U((segmentWidth + 1).W))
  val sum3_final_reg = RegInit(0.U(segmentWidth.W))
  val sum2_final_reg2 = RegInit(0.U(segmentWidth.W))
  val sum1_final_reg3 = RegInit(0.U(segmentWidth.W))
  
  when (en_reg4) {
    sum4_reg := sum4
    sum3_final_reg := sum3_reg(segmentWidth-1, 0)
    sum2_final_reg2 := sum2_final_reg
    sum1_final_reg3 := sum1_final_reg2
  }
  
  // Combine all segments to form the final result
  val final_result = Cat(
    sum4_reg, 
    sum3_final_reg, 
    sum2_final_reg2, 
    sum1_final_reg3
  )
  
  // Connect outputs
  io.result := final_result
  io.o_en := en_reg4
}

// Optional object for generating Verilog
/*
object RippleCarryAdderDriver extends App {
  chisel3.Driver.execute(args, () => new RippleCarryAdder(64))
}
*/
