import chisel3._
import chisel3.util._

class dut extends NPCModule with HasNPCParameter with TYPE_INST {
  val io = IO(new Bundle{
    val from_isu = Flipped(Decoupled(new DecodeIO)) // Input from the instruction decoding unit
    val to_wbu = Decoupled(new ExuToWbuIO) // Output to the write-back unit
    val to_mem = new ToMem // Output from the LSU functional unit to the memory
    val from_mem = new FromMem // Input from the memory to the LSU
    val redirect = Output(new Redirect) // Output redirection signal
  })

  // Shorthand for input/output
  val in = io.from_isu
  val out = io.to_wbu
  val inBits = in.bits

  // 1. Output Connection - Connect cf/ctrl/data from from_isu to to_wbu
  out.bits.cf := inBits.cf
  out.bits.ctrl := inBits.ctrl
  out.bits.data := inBits.data

  // 2. Functional unit distribution
  
  // Instantiate ALU
  val alu0 = Module(new ALU)
  alu0.io.in.bits.srca := inBits.data.fuSrc1
  alu0.io.in.bits.srcb := inBits.data.fuSrc2
  alu0.io.in.bits.fuOpType := inBits.ctrl.fuOpType
  alu0.io.out.ready := out.ready
  alu0.io.in.valid := in.valid && (inBits.ctrl.fuType === FuType.alu)
  out.bits.data.Alu0Res.bits := alu0.io.out.bits

  // Instantiate LSU
  val lsu0 = Module(new LSU)
  lsu0.io.in.bits.srca := inBits.data.fuSrc1
  lsu0.io.in.bits.srcb := inBits.data.fuSrc2
  lsu0.io.in.bits.fuOpType := inBits.ctrl.fuOpType
  lsu0.io.out.ready := out.ready
  lsu0.io.in.valid := in.valid && (inBits.ctrl.fuType === FuType.lsu)
  
  // LSU specific connections
  lsu0.io.from_mem := io.from_mem
  lsu0.io.ctrl := inBits.ctrl
  lsu0.io.data := inBits.data
  
  // LSU outputs
  out.bits.data.data_from_mem := lsu0.io.out.bits
  io.to_mem := lsu0.io.to_mem

  // Instantiate CSR
  val csr0 = Module(new CSR)
  csr0.io.in.bits.srca := inBits.data.fuSrc1
  csr0.io.in.bits.srcb := inBits.data.fuSrc2
  csr0.io.in.bits.fuOpType := inBits.ctrl.fuOpType
  csr0.io.out.ready := out.ready
  csr0.io.in.valid := in.valid && (inBits.ctrl.fuType === FuType.csr)
  
  // CSR output
  out.bits.data.csrRdata := csr0.io.out.bits

  // 3. Branch jump processing
  
  // Instantiate BruRes
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(inBits, alu0, csr0)
  
  // Generate redirection signal
  val predictionError = bruRes.targetPc =/= inBits.cf.next_pc
  io.redirect.valid := in.valid && bruRes.valid && predictionError
  io.redirect.target := bruRes.targetPc
  
  // Update next_pc to correct target PC value when prediction error occurs
  when(bruRes.valid && predictionError) {
    out.bits.cf.next_pc := bruRes.targetPc
  }

  // 4. Handshake signal processing
  HandShakeDeal(
    io.from_isu, 
    io.to_wbu,
    AnyInvalidCondition = false.B,
    AnyStopCodition = io.redirect.valid && in.valid
  )
}

// Supporting classes (if not already defined elsewhere)

class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid = Bool()
}

class DecodeIO extends NPCBundle {
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

class ExuToWbuIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}
