// package npc

import chisel3._
import chisel3.util._

class dut extends NPCModule with HasNPCParameter with TYPE_INST {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))  // Input from the instruction decoding unit
    val to_wbu = Decoupled(new ExuToWbuIO)           // Output to the write-back unit
    val to_mem = new ToMem                          // Output from the LSU functional unit to the memory
    val from_mem = new FromMem                      // Input from the memory to the LSU
    val redirect = Output(new Redirect)             // Output redirection signal
  })

  // Instantiate functional units
  val alu0 = Module(new ALU)
  val lsu0 = Module(new LSU)
  val csr0 = Module(new CSR)

  // Connect control flow and control signals from ISU to WBU
  io.to_wbu.bits.cf := io.from_isu.bits.cf
  io.to_wbu.bits.ctrl := io.from_isu.bits.ctrl

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
  lsu0.io.out.ready := io.to_wbu.ready
  lsu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.lsu)
  
  // Connect LSU to memory interface
  lsu0.io.from_mem := io.from_mem
  io.to_mem := lsu0.io.to_mem
  
  // Connect LSU to control signals
  lsu0.io.ctrl := io.from_isu.bits.ctrl
  lsu0.io.data := io.from_isu.bits.data
  
  // Connect LSU output to WBU
  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits

  // Connect CSR
  csr0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  csr0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  csr0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  csr0.io.out.ready := io.to_wbu.ready
  csr0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.csr)
  io.to_wbu.bits.data.csrRdata := csr0.io.out.bits

  // Branch jump processing
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  // Detect prediction errors and generate redirect signals
  val predictionError = bruRes.valid && io.from_isu.bits.cf.next_pc =/= bruRes.targetPc
  io.redirect.valid := io.from_isu.valid && bruRes.valid && predictionError
  io.redirect.target := bruRes.targetPc

  // Update next_pc if there's a prediction error
  when(io.redirect.valid) {
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

class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid = Bool()
}

class ExuToWbuIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new WbuData
}

class WbuData extends NPCBundle {
  val Alu0Res = Decoupled(UInt(XLen.W))
  val data_from_mem = UInt(XLen.W)
  val csrRdata = UInt(XLen.W)
}

// This is a helper function for handling the handshake protocol
object HandShakeDeal {
  def apply[T <: Data, U <: Data](
    in: DecoupledIO[T],
    out: DecoupledIO[U],
    AnyInvalidCondition: Bool,
    AnyStopCondition: Bool
  ): Unit = {
    // Set valid if input is valid and no invalid condition
    out.valid := in.valid && !AnyInvalidCondition
    
    // Set ready if output is ready or if we need to stop
    in.ready := out.ready || AnyStopCondition
  }
}

// This is a helper function for calculating branch results
object CalBruRes {
  def apply(inBits: DecodeIO, alu: ALU, csr: CSR): BruRes = {
    val res = Wire(new BruRes)
    res.valid := inBits.cf.isBranch
    
    // Determine target PC based on branch condition
    when(alu.io.out.bits === 1.U) {
      res.targetPc := inBits.data.imm + inBits.cf.pc
    }.otherwise {
      res.targetPc := inBits.cf.pc + 4.U
    }
    
    // Special handling for CSR jumps if needed
    when(inBits.ctrl.fuType === FuType.csr && csr.io.jumpEn) {
      res.targetPc := csr.io.jumpTarget
    }
    
    res
  }
}

class BruRes extends NPCBundle {
  val valid = Bool()
  val targetPc = UInt(XLen.W)
}
