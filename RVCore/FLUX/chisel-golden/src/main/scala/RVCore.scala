import chisel3._
import chisel3.util._

trait HasNPCParameter{
  val XLen = 32
  val CONFIG_RVE = true     // Support Riscv E extension
  val NR_GPR = if(CONFIG_RVE) 16 else 32
  val IndependentBru = false

}

abstract class NPCConfig extends HasNPCParameter

object MyNPCConfig extends NPCConfig

abstract class NPCBundle extends Bundle
with HasNPCParameter

abstract class NPCModule extends Module
with HasNPCParameter

class FromMem extends NPCBundle {
  //val inst = Input(UInt(32.W))
  val data = Input(UInt(XLen.W))
}
class ToMem extends NPCBundle {
  val data = Output(UInt(XLen.W))
  val addr = Output(UInt(XLen.W))
  val Wmask= Output(UInt(8.W))
  val MemWrite = Output(Bool())
  //val MemRead = Output(Bool())
}

object StageConnect {
  def apply[T <: Data](left: DecoupledIO[T], right: DecoupledIO[T], right_producer_fire: Bool, isFlush: Bool = false.B )   = {
    val arch = "pipeline"
    // 为展示抽象的思想, 此处代码省略了若干细节
    if      (arch == "single")   { 
      right.bits := left.bits 
      right.valid := left.valid
      left.ready := right.ready
    }
    else if (arch == "multi")    { right <> left }
    else if (arch == "pipeline") {
      
      // left.valid : output from combinational
      // right.valid : input from a reg
      val valid = RegInit(false.B)
      when(isFlush) {valid := false.B}
      .elsewhen(right.ready && left.valid) {valid := left.valid}
      .elsewhen(right_producer_fire) {valid := false.B}
      .otherwise {valid := valid}

      right.valid := valid
      left.ready := right.ready
      //right.valid <> RegEnable(left.valid, false.B, right.ready) // Justify it with `wbu_to_reg_valid_reg` at same time
      right.bits <> RegEnable(left.bits, left.valid && right.ready) 
    
    }    // TODO: correct connect
    else if (arch == "ooo")      { right <> Queue(left, 16) }
  }
}

object HandShakeDeal {
  def apply [T1 <: Data,T2 <: Data](consumer: DecoupledIO[T1], producer: DecoupledIO[T2], AnyInvalidCondition: Bool, AnyStopCodition: Bool = false.B) = {
      consumer.ready :=  ((false.B === consumer.valid) || producer.fire) && (false.B === AnyStopCodition ) // TODO: finish it
      producer.valid := consumer.valid && (false.B === AnyInvalidCondition) // TODO: finish it
  }

}

class Commit extends NPCBundle {
  val valid = Bool()
  val pc    = UInt(XLen.W)
  val next_pc    = UInt(XLen.W)   // Todo: abjust it according to jump result
  val inst  = UInt(32.W)
}

class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid  = Bool()
}

class RVCore2 extends Module 
with HasNPCParameter
{
  val io = IO(new Bundle {
    val from_mem = new FromMem
    val to_mem = new ToMem
    val inst = Input(UInt(32.W))
    val pc = Output(UInt((XLen).W))

    //for debug
    val commit =  Output(new Commit)
  })
  // val ifu = Module(new IFU_LLM)
  // val idu = Module(new IDU_LLM)
  // val isu = Module(new ISU_LLM)
  // val exu = Module(new EXU_LLM)
  // val wbu = Module(new WBU_LLM)

  val ifu = Module(new IFU)
  val idu = Module(new IDU)
  val isu = Module(new ISU)
  val exu = Module(new EXU)
  val wbu = Module(new WBU)

  
  ifu.io.inst := io.inst
  exu.io.from_mem <> io.from_mem
  io.pc := ifu.io.pc

  //>>>TODO:To Mem>>>//
  io.to_mem <> exu.io.to_mem
  //<<<TODO:To Mem<<<//

  val redirect = exu.io.redirect.valid

  StageConnect(ifu.io.to_idu, idu.io.from_ifu, idu.io.to_isu.fire, redirect)
  StageConnect(idu.io.to_isu, isu.io.from_idu, isu.io.to_exu.fire, redirect)
  StageConnect(isu.io.to_exu, exu.io.from_isu, exu.io.to_wbu.fire, isFlush = false.B)   // Don't flush Exu itself. Using HandShakeDeal to stop front pipeline
  StageConnect(exu.io.to_wbu, wbu.io.from_exu, wbu.io.to_reg.valid && true.B, isFlush = false.B)
  //StageConnect(exu.io.to_lsu, lsu.io.from_exu, lsu.io.to_wbu.fire)
  //StageConnect(lsu.io.to_wbu, wbu.io.from_lsu, wbu.io.to_reg.valid && true.B)

  ifu.io.redirect <> exu.io.redirect

  isu.io.wb <> wbu.io.to_reg.bits

  wbu.io.to_reg.ready := true.B

  //ifu.io.from_exu_bruRes <> exu.io.bruRes     // calculated branch result

  // for debug: commit
  
  io.commit.valid := RegNext(wbu.io.to_reg.valid, false.B)
  //io.commit.valid := wbu_to_reg_valid_reg
  io.commit.pc := RegNext(wbu.io.to_commit.pc)
  io.commit.next_pc := RegNext(wbu.io.to_commit.next_pc)
  io.commit.inst := RegNext(wbu.io.to_commit.inst)

      //>>> RegFile
  val regfile = Module(new ysyx_23060228_RegFile_BlackBox)
  regfile.io.clk := clock
  val (rs1, rs2) = isu.rs1_rs2(regfile.io.src1, regfile.io.src2)
  regfile.io.rs1 := rs1
  regfile.io.rs2 := rs2
  regfile.io.rd   := wbu.io.to_reg.bits.rd 
  regfile.io.dest := wbu.io.to_reg.bits.Res
  regfile.io.RegWrite :=  wbu.io.to_reg.bits.RegWrite
  //<<< RegFile

}

class RVCore2_LLM2 extends Module 
with HasNPCParameter
{
  val io = IO(new Bundle {
    val from_mem = new FromMem
    val to_mem = new ToMem
    val inst = Input(UInt(32.W))
    val pc = Output(UInt((XLen).W))

    //for debug
    val commit =  Output(new Commit)
  })

  val frontend = Module(new frontend)
  val exu = Module(new EXU)
  val wbu = Module(new WBU)

  //frontend.ifu.io.inst := io.inst
  frontend.io.inst := io.inst

  //io.pc := frontend.ifu.io.pc
  io.pc := frontend.io.pc

  //>>>TODO:To Mem>>>//
  exu.io.from_mem <> io.from_mem
  io.to_mem <> exu.io.to_mem
  //<<<TODO:To Mem<<<//

  val redirect = exu.io.redirect.valid

  frontend.io.redirect := redirect

  // StageConnect(ifu.io.to_idu, idu.io.from_ifu, idu.io.to_isu.fire, redirect)
  // StageConnect(idu.io.to_isu, isu.io.from_idu, isu.io.to_exu.fire, redirect)

  StageConnect(frontend.io.to_exu, exu.io.from_isu, exu.io.to_wbu.fire, isFlush = false.B)   // Don't flush Exu itself. Using HandShakeDeal to stop front pipeline
  StageConnect(exu.io.to_wbu, wbu.io.from_exu, wbu.io.to_reg.valid && true.B, isFlush = false.B)


  frontend.io.ifuredirect <> exu.io.redirect

  frontend.io.wb <> wbu.io.to_reg.bits

  wbu.io.to_reg.ready := true.B


  // for debug: commit
  
  io.commit.valid := RegNext(wbu.io.to_reg.valid, false.B)
  io.commit.pc := RegNext(wbu.io.to_commit.pc)
  io.commit.next_pc := RegNext(wbu.io.to_commit.next_pc)
  io.commit.inst := RegNext(wbu.io.to_commit.inst)

  //>>> RegFile
  val regfile = Module(new ysyx_23060228_RegFile_BlackBox)
  regfile.io.clk := clock
  val (rs1, rs2) = frontend.rs1_rs2(regfile.io.src1, regfile.io.src2)
  regfile.io.rs1 := rs1
  regfile.io.rs2 := rs2
  regfile.io.rd   := wbu.io.to_reg.bits.rd 
  regfile.io.dest := wbu.io.to_reg.bits.Res
  regfile.io.RegWrite :=  wbu.io.to_reg.bits.RegWrite
  //<<< RegFile

}

object CoreMain extends App {
  println("Generating the Core hardware")
  // emitVerilog(new RVCore2, Array("-e","verilog", "--target-dir", "generated-llm"))
  // emitVerilog(new RVCore2, Array("verilog", "--target-dir", "gen-all-llm"))
  emitVerilog(new RVCore2, Array("verilog", "--target-dir", "gen-all"))
}