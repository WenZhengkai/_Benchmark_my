import chisel3._
import chisel3.util._

class dut extends NPCModule with HasNPCParameter with TYPE_INST {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))
    val to_wbu = Decoupled(new ExuToWbuIO)
    val to_mem = new ToMem
    val from_mem = new FromMem
    val redirect = Output(new Redirect)
  })

  // Shortcuts for convenience
  val inBits = io.from_isu.bits
  val outBits = io.to_wbu.bits

  // 1. Output Connection - Connect cf/ctrl/data from from_isu to to_wbu
  outBits.cf := inBits.cf
  outBits.ctrl := inBits.ctrl
  outBits.data := inBits.data

  // 2. Functional unit distribution
  
  // Instantiate ALU
  val alu0 = Module(new ALU)
  alu0.io.in.bits.srca := inBits.data.fuSrc1
  alu0.io.in.bits.srcb := inBits.data.fuSrc2
  alu0.io.in.bits.fuOpType := inBits.ctrl.fuOpType
  alu0.io.out.ready := io.to_wbu.ready
  alu0.io.in.valid := io.from_isu.valid && (inBits.ctrl.fuType === FuType.alu)
  outBits.data.Alu0Res.bits := alu0.io.out.bits

  // Instantiate LSU
  val lsu0 = Module(new LSU)
  lsu0.io.in.bits.srca := inBits.data.fuSrc1
  lsu0.io.in.bits.srcb := inBits.data.fuSrc2
  lsu0.io.in.bits.fuOpType := inBits.ctrl.fuOpType
  lsu0.io.out.ready := io.to_wbu.ready
  lsu0.io.in.valid := io.from_isu.valid && (inBits.ctrl.fuType === FuType.lsu)
  lsu0.io.from_mem <> io.from_mem
  lsu0.io.ctrl := inBits.ctrl
  lsu0.io.data := inBits.data
  io.to_mem <> lsu0.io.to_mem
  outBits.data.data_from_mem := lsu0.io.out.bits

  // Instantiate CSR
  val csr0 = Module(new CSR)
  csr0.io.in.bits.srca := inBits.data.fuSrc1
  csr0.io.in.bits.srcb := inBits.data.fuSrc2
  csr0.io.in.bits.fuOpType := inBits.ctrl.fuOpType
  csr0.io.out.ready := io.to_wbu.ready
  csr0.io.in.valid := io.from_isu.valid && (inBits.ctrl.fuType === FuType.csr)
  outBits.data.csrRdata := csr0.io.out.bits

  // 3. Branch jump processing
  
  // Instantiate BruRes and calculate branch result
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(inBits, alu0, csr0)

  // Generate redirection signal
  val predictionError = bruRes.valid && (inBits.cf.next_pc =/= bruRes.targetPc)
  io.redirect.valid := io.from_isu.valid && bruRes.valid && predictionError
  io.redirect.target := bruRes.targetPc

  // Update next_pc to correct target PC value when prediction error occurs
  when(predictionError) {
    outBits.cf.next_pc := bruRes.targetPc
  }

  // 4. Handshake signal processing
  HandShakeDeal(
    io.from_isu,
    io.to_wbu,
    AnyInvalidCondition = false.B,
    AnyStopCondition = io.redirect.valid && io.from_isu.valid
  )
}

// Supporting Bundle definitions (as mentioned, these are already defined)
class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid = Bool()
}

class DecodeIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

class ExuToWbuIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

class CtrlFlow extends NPCBundle {
  val inst = UInt(32.W)
  val pc = UInt(XLen.W)
  val next_pc = UInt(XLen.W)
  val isBranch = Bool()
}

class CtrlSignal extends NPCBundle {
  val MemWrite = Bool()
  val ResSrc = UInt()
  val fuSrc1Type = FuSrcType()
  val fuSrc2Type = FuSrcType()
  val fuType = FuType()
  val fuOpType = FuOpType()
  val rs1 = UInt(5.W)
  val rs2 = UInt(5.W)
  val rfWen = Bool()
  val rd = UInt(5.W)
}

class DataSrc extends NPCBundle {
  val fuSrc1 = UInt(XLen.W)
  val fuSrc2 = UInt(XLen.W)
  val imm = UInt(XLen.W)
  val Alu0Res = Decoupled(UInt(XLen.W))
  val data_from_mem = UInt(XLen.W)
  val csrRdata = UInt(XLen.W)
  val rfSrc1 = UInt(XLen.W)
  val rfSrc2 = UInt(XLen.W)
}

class BruRes extends NPCBundle {
  val valid = Bool()
  val targetPc = UInt(XLen.W)
}
