// package processor

import chisel3._
import chisel3.util._
import processor.parameters._
import processor.types._

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

  // ALU connections
  alu0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  alu0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  alu0.io.out.ready := io.to_wbu.ready
  alu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.alu)
  io.to_wbu.bits.data.Alu0Res.bits := alu0.io.out.bits
  io.to_wbu.bits.data.Alu0Res.valid := alu0.io.out.valid

  // LSU connections
  lsu0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  lsu0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  lsu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  lsu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.lsu)
  lsu0.io.out.ready := io.to_wbu.ready
  lsu0.io.from_mem := io.from_mem
  lsu0.io.ctrl := io.from_isu.bits.ctrl
  lsu0.io.data := io.from_isu.bits.data
  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits
  io.to_mem := lsu0.io.to_mem

  // CSR connections
  csr0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  csr0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  csr0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  csr0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.csr)
  csr0.io.out.ready := io.to_wbu.ready
  io.to_wbu.bits.data.csrRdata := csr0.io.out.bits

  // Branch resolution
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  // Redirection logic for branch prediction errors
  val predictionError = bruRes.valid && (bruRes.targetPc =/= io.from_isu.bits.cf.next_pc)
  io.redirect.valid := io.from_isu.valid && bruRes.valid && predictionError
  io.redirect.target := bruRes.targetPc

  // Update next_pc if there's a prediction error
  when(predictionError) {
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

// Class definitions for interfaces and bundles
class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid = Bool()
}

class ExuToWbuIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

class BruRes extends NPCBundle {
  val valid = Bool()
  val targetPc = UInt(XLen.W)
}

// CalBruRes function to calculate branch resolution
object CalBruRes {
  def apply(inBits: DecodeIO, alu: ALU, csr: CSR): BruRes = {
    val res = Wire(new BruRes)
    val inst = inBits.cf.inst
    val pc = inBits.cf.pc
    val isBranch = inBits.cf.isBranch
    
    res.valid := isBranch
    
    // Calculate target PC based on branch type
    when(isBranch) {
      when(FuType.isBru(inBits.ctrl.fuType)) {
        // Use ALU result for regular branches
        res.targetPc := alu.io.out.bits
      }.elsewhen(FuType.isCsr(inBits.ctrl.fuType)) {
        // Use CSR result for special jumps (like MRET)
        res.targetPc := csr.io.out.bits
      }.otherwise {
        // Default case, shouldn't reach here if isBranch is true
        res.targetPc := pc + 4.U
      }
    }.otherwise {
      res.targetPc := pc + 4.U
    }
    
    res
  }
}

// Handshake processing function
object HandShakeDeal {
  def apply[T <: Data](in: DecoupledIO[T], out: DecoupledIO[T], 
                       AnyInvalidCondition: Bool, AnyStopCondition: Bool): Unit = {
    // Pass valid signal if not invalid
    out.valid := in.valid && !AnyInvalidCondition
    
    // Pass ready signal if not stopped
    in.ready := out.ready && !AnyStopCondition
    
    // If stop condition, don't pass valid signal to output
    when(AnyStopCondition) {
      out.valid := false.B
    }
  }
}
