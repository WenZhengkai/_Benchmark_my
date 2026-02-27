// package npc

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

  // Instantiate functional units
  val alu0 = Module(new ALU)
  val lsu0 = Module(new LSU)
  val csr0 = Module(new CSR)

  // Connect control flow information
  io.to_wbu.bits.cf := io.from_isu.bits.cf
  io.to_wbu.bits.ctrl := io.from_isu.bits.ctrl
  io.to_wbu.bits.data := io.from_isu.bits.data

  // Connect ALU
  alu0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  alu0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  alu0.io.out.ready := io.to_wbu.ready
  alu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.alu)
  io.to_wbu.bits.data.Alu0Res.bits := alu0.io.out.bits
  io.to_wbu.bits.data.Alu0Res.valid := alu0.io.out.valid

  // Connect LSU
  lsu0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  lsu0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  lsu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  lsu0.io.from_mem := io.from_mem
  lsu0.io.ctrl := io.from_isu.bits.ctrl
  lsu0.io.data := io.from_isu.bits.data
  lsu0.io.out.ready := io.to_wbu.ready
  lsu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.lsu)
  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits
  io.to_mem := lsu0.io.to_mem

  // Connect CSR
  csr0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  csr0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  csr0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  csr0.io.in.bits.rs1 := io.from_isu.bits.ctrl.rs1
  csr0.io.in.bits.rd := io.from_isu.bits.ctrl.rd
  csr0.io.out.ready := io.to_wbu.ready
  csr0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.csr)
  io.to_wbu.bits.data.csrRdata := csr0.io.out.bits

  // Branch jump processing
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  // Prediction error detection
  val predictionError = bruRes.valid && (bruRes.targetPc =/= io.from_isu.bits.cf.next_pc)

  // Generate redirection signal
  io.redirect.valid := io.from_isu.valid && bruRes.valid && predictionError
  io.redirect.target := bruRes.targetPc

  // Update next_pc if there's a redirection
  when(io.redirect.valid) {
    io.to_wbu.bits.cf.next_pc := bruRes.targetPc
  }

  // Handshake signal processing
  HandShakeDeal(
    io.from_isu, 
    io.to_wbu,
    AnyInvalidCondition = false.B,
    AnyStopCodition = io.redirect.valid && io.from_isu.valid
  )
}

// Required companion classes and traits (presumed to be defined elsewhere)
class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid = Bool()
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

// For a complete implementation, the following utility function would be defined elsewhere
object CalBruRes {
  def apply(inBits: DecodeIO, alu: ALU, csr: CSR): BruRes = {
    val res = Wire(new BruRes)
    
    // Logic to determine if this is a branch/jump instruction
    val isBranch = inBits.cf.isBranch
    val isJump = (inBits.ctrl.fuType === FuType.alu) && 
                (inBits.ctrl.fuOpType === AluOpType.jal || inBits.ctrl.fuOpType === AluOpType.jalr)
    val isTrap = (inBits.ctrl.fuType === FuType.csr) && 
                (inBits.ctrl.fuOpType === CsrOpType.trap)
    
    // Determine if branch is taken based on ALU result (assuming ALU outputs 1 for taken)
    val branchTaken = alu.io.out.bits =/= 0.U && alu.io.out.valid && isBranch
    
    // Set valid if this is a branch, jump, or trap instruction
    res.valid := branchTaken || isJump || isTrap
    
    // Determine target PC
    when(isTrap) {
      // For traps, get target from CSR (e.g., mtvec)
      res.targetPc := csr.io.trapTarget
    }.elsewhen(isJump && inBits.ctrl.fuOpType === AluOpType.jalr) {
      // For JALR, target comes from reg + imm
      res.targetPc := (inBits.data.fuSrc1 + inBits.data.imm) & ~(1.U(XLen.W))
    }.otherwise {
      // For branches and JAL, target is PC + imm
      res.targetPc := inBits.cf.pc + inBits.data.imm
    }
    
    res
  }
}

// Handshake signal processing helper
object HandShakeDeal {
  def apply[T <: Data](in: DecoupledIO[T], out: DecoupledIO[T], 
                      AnyInvalidCondition: Bool, AnyStopCodition: Bool): Unit = {
    // Propagate valid signal from input to output
    out.valid := in.valid && !AnyInvalidCondition
    
    // Propagate ready signal from output to input, unless we need to stop
    in.ready := out.ready && !AnyStopCodition
    
    // Propagate bits directly
    out.bits := in.bits
  }
}
