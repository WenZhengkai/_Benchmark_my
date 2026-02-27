// package npc

import chisel3._
import chisel3.util._

class dut extends NPCModule with HasNPCParameter with TYPE_INST {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))    // Input from instruction decode unit
    val to_wbu = Decoupled(new ExuToWbuIO)             // Output to write-back unit
    val to_mem = new ToMem                             // Output to memory
    val from_mem = new FromMem                         // Input from memory
    val redirect = Output(new Redirect)                // Redirection signal
  })

  // Connect control flow, control signals, and data from input to output
  io.to_wbu.bits.cf := io.from_isu.bits.cf
  io.to_wbu.bits.ctrl := io.from_isu.bits.ctrl
  io.to_wbu.bits.data := io.from_isu.bits.data

  // Instantiate functional units
  val alu0 = Module(new ALU)
  val lsu0 = Module(new LSU)
  val csr0 = Module(new CSR)

  // Connect ALU
  alu0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  alu0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  alu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.alu)
  alu0.io.out.ready := io.to_wbu.ready
  io.to_wbu.bits.data.Alu0Res.bits := alu0.io.out.bits
  io.to_wbu.bits.data.Alu0Res.valid := alu0.io.out.valid

  // Connect LSU
  lsu0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  lsu0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  lsu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  lsu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.lsu)
  lsu0.io.out.ready := io.to_wbu.ready
  lsu0.io.ctrl := io.from_isu.bits.ctrl
  lsu0.io.data := io.from_isu.bits.data
  lsu0.io.from_mem := io.from_mem
  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits
  io.to_mem := lsu0.io.to_mem

  // Connect CSR
  csr0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  csr0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  csr0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  csr0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.csr)
  csr0.io.out.ready := io.to_wbu.ready
  io.to_wbu.bits.data.csrRdata := csr0.io.out.bits

  // Branch execution result handling
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  // Prediction error detection
  val predictError = bruRes.valid && (bruRes.targetPc =/= io.from_isu.bits.cf.next_pc)
  
  // Redirect signal generation
  io.redirect.valid := io.from_isu.valid && bruRes.valid && predictError
  io.redirect.target := bruRes.targetPc
  
  // Update next_pc in case of prediction error
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

// Helper method to calculate branch result
object CalBruRes {
  def apply(inBits: DecodeIO, alu: ALU, csr: CSR): BruRes = {
    val bruRes = Wire(new BruRes)
    
    // Default values
    bruRes.valid := false.B
    bruRes.targetPc := 0.U
    
    // Check if this is a branch instruction
    when(inBits.cf.isBranch) {
      bruRes.valid := true.B
      
      // Branch target depends on ALU result
      when(alu.io.out.bits === 1.U) {
        bruRes.targetPc := inBits.data.imm
      }.otherwise {
        bruRes.targetPc := inBits.cf.pc + 4.U
      }
    }
    
    // JAL and JALR instructions always redirect
    when(inBits.ctrl.fuOpType === FuOpType.jal || inBits.ctrl.fuOpType === FuOpType.jalr) {
      bruRes.valid := true.B
      bruRes.targetPc := inBits.data.imm
    }
    
    // CSR exceptions may also cause redirection
    when(csr.io.exceptionRedirect.valid) {
      bruRes.valid := true.B
      bruRes.targetPc := csr.io.exceptionRedirect.target
    }
    
    bruRes
  }
}

// Handshake signal processing function
object HandShakeDeal {
  def apply[T <: Data](
    in: DecoupledIO[T], 
    out: DecoupledIO[T], 
    AnyInvalidCondition: Bool, 
    AnyStopCondition: Bool
  ): Unit = {
    // Transfer validity from input to output if no stop condition
    out.valid := in.valid && !AnyStopCondition
    
    // Input is ready when output is ready or we have a stop condition
    in.ready := out.ready || AnyStopCondition
    
    // When invalid condition, force output to be invalid
    when(AnyInvalidCondition) {
      out.valid := false.B
    }
  }
}

// Additional required classes
class ExuToWbuIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

class BruRes extends NPCBundle {
  val valid = Bool()
  val targetPc = UInt(XLen.W)
}

class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid = Bool()
}
