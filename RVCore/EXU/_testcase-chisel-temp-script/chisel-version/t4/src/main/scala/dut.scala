// package npc

import chisel3._
import chisel3.util._
import npc.constants._

class dut extends NPCModule with HasNPCParameter with TYPE_INST {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))
    val to_wbu = Decoupled(new ExuToWbuIO))
    val to_mem = new ToMem
    val from_mem = Flipped(new FromMem)
    val redirect = Output(new Redirect)
  })

  // Instantiate functional units
  val alu0 = Module(new ALU)
  val lsu0 = Module(new LSU)
  val csr0 = Module(new CSR)

  // Connect control flow, control signals, and data from ISU to WBU
  io.to_wbu.bits.cf := io.from_isu.bits.cf
  io.to_wbu.bits.ctrl := io.from_isu.bits.ctrl
  io.to_wbu.bits.data := io.from_isu.bits.data

  // ALU connections
  alu0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  alu0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  alu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.alu)
  alu0.io.out.ready := io.to_wbu.ready
  io.to_wbu.bits.data.Alu0Res.bits := alu0.io.out.bits
  io.to_wbu.bits.data.Alu0Res.valid := alu0.io.out.valid

  // LSU connections
  lsu0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  lsu0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  lsu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  lsu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.lsu)
  lsu0.io.out.ready := io.to_wbu.ready
  
  // Connect LSU memory interface
  lsu0.io.from_mem <> io.from_mem
  io.to_mem <> lsu0.io.to_mem
  
  // Connect control and data signals to LSU
  lsu0.io.ctrl := io.from_isu.bits.ctrl
  lsu0.io.data := io.from_isu.bits.data
  
  // Connect LSU output to WBU
  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits

  // CSR connections
  csr0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  csr0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  csr0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  csr0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.csr)
  csr0.io.out.ready := io.to_wbu.ready
  io.to_wbu.bits.data.csrRdata := csr0.io.out.bits

  // Branch processing
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  // Check for prediction errors - predicted PC doesn't match calculated target
  val predictionError = bruRes.valid && (io.from_isu.bits.cf.next_pc =/= bruRes.targetPc)
  
  // Generate redirect signal
  io.redirect.valid := io.from_isu.valid && bruRes.valid && predictionError
  io.redirect.target := bruRes.targetPc
  
  // Update next_pc with correct target if there was a branch/jump
  when(bruRes.valid) {
    io.to_wbu.bits.cf.next_pc := bruRes.targetPc
  }

  // Handshake signal processing
  HandShakeDeal(
    io.from_isu, 
    io.to_wbu,
    AnyInvalidCondition = false.B,
    AnyStopCondition = io.redirect.valid && io.from_isu.valid
  )
}

// This helper function would be defined elsewhere in the codebase
// It calculates branch results based on instruction and ALU/CSR outputs
object CalBruRes {
  def apply(inBits: DecodeIO, alu: ALU, csr: CSR): BruRes = {
    val res = Wire(new BruRes)
    res.valid := false.B
    res.targetPc := 0.U
    
    when(inBits.cf.isBranch) {
      // Handle branch instructions
      when(inBits.ctrl.fuType === FuType.alu && alu.io.branchTaken) {
        res.valid := true.B
        res.targetPc := alu.io.branchTarget
      }
    }.elsewhen(inBits.ctrl.fuType === FuType.jal || inBits.ctrl.fuType === FuType.jalr) {
      // Handle jump instructions
      res.valid := true.B
      res.targetPc := Mux(inBits.ctrl.fuType === FuType.jal, 
                          inBits.cf.pc + inBits.data.imm,
                          (inBits.data.fuSrc1 + inBits.data.imm) & ~1.U)
    }.elsewhen(inBits.ctrl.fuType === FuType.csr && csr.io.exception) {
      // Handle CSR exceptions that cause PC changes
      res.valid := true.B
      res.targetPc := csr.io.exceptionTarget
    }
    
    res
  }
}

// Missing class definition from the requirements
class ExuToWbuIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// HandShakeDeal function that manages ready/valid handshaking
object HandShakeDeal {
  def apply[T <: Data, U <: Data](
    in: DecoupledIO[T],
    out: DecoupledIO[U],
    AnyInvalidCondition: Bool,
    AnyStopCondition: Bool
  ): Unit = {
    out.valid := in.valid && !AnyInvalidCondition
    in.ready := out.ready && !AnyStopCondition
  }
}
