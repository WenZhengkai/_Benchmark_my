// package npc

import chisel3._
import chisel3.util._

// Main execution unit module
class dut extends NPCModule with HasNPCParameter with TYPE_INST {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))     // Input from instruction decode unit
    val to_wbu = Decoupled(new ExuToWbuIO)              // Output to write-back unit
    val to_mem = new ToMem                              // Output to memory
    val from_mem = new FromMem                          // Input from memory
    val redirect = Output(new Redirect)                 // Redirection signal for branch mispredictions
  })

  // Connect control flow, control signals and data between from_isu and to_wbu
  io.to_wbu.bits.cf := io.from_isu.bits.cf
  io.to_wbu.bits.ctrl := io.from_isu.bits.ctrl
  io.to_wbu.bits.data := io.from_isu.bits.data

  // Instantiate ALU module
  val alu0 = Module(new ALU)
  alu0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  alu0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  alu0.io.out.ready := io.to_wbu.ready
  alu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.alu)
  io.to_wbu.bits.data.Alu0Res.bits := alu0.io.out.bits
  io.to_wbu.bits.data.Alu0Res.valid := alu0.io.out.valid

  // Instantiate LSU module
  val lsu0 = Module(new LSU)
  lsu0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  lsu0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  lsu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  lsu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.lsu)
  lsu0.io.from_mem := io.from_mem
  lsu0.io.ctrl := io.from_isu.bits.ctrl
  lsu0.io.data := io.from_isu.bits.data
  lsu0.io.out.ready := io.to_wbu.ready
  
  // Connect LSU outputs
  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits
  io.to_mem := lsu0.io.to_mem

  // Instantiate CSR module
  val csr0 = Module(new CSR)
  csr0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  csr0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  csr0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  csr0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.csr)
  csr0.io.out.ready := io.to_wbu.ready
  io.to_wbu.bits.data.csrRdata := csr0.io.out.bits

  // Branch resolution logic
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  // Check if branch prediction was incorrect
  val predictionError = bruRes.valid && (bruRes.targetPc =/= io.from_isu.bits.cf.next_pc)
  
  // Set up redirect signal
  io.redirect.valid := io.from_isu.valid && bruRes.valid && predictionError
  io.redirect.target := bruRes.targetPc

  // Update next_pc if prediction was incorrect
  when(predictionError) {
    io.to_wbu.bits.cf.next_pc := bruRes.targetPc
  }

  // Handle handshake signals
  HandShakeDeal(
    io.from_isu, 
    io.to_wbu,
    AnyInvalidCondition = false.B,
    AnyStopCondition = io.redirect.valid && io.from_isu.valid
  )
}

// Redirect signal class for branch mispredictions
class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid = Bool()
}

// Module to calculate branch resolution results
object CalBruRes {
  def apply(inBits: DecodeIO, alu: ALU, csr: CSR): BruRes = {
    val result = Wire(new BruRes)
    
    // Default values
    result.valid := false.B
    result.targetPc := 0.U
    
    // Logic to determine if this is a branch instruction that was taken
    when(inBits.cf.isBranch && alu.io.out.valid) {
      result.valid := true.B
      result.targetPc := alu.io.branchTarget
    }
    
    // Handle jumps from CSR (like MRET)
    when(csr.io.jumpValid) {
      result.valid := true.B
      result.targetPc := csr.io.jumpTarget
    }
    
    result
  }
}

// Branch resolution result class
class BruRes extends NPCBundle {
  val valid = Bool()          // Whether this is a valid branch result
  val targetPc = UInt(XLen.W) // Target PC address
}

// ExuToWbuIO bundle for execution results
class ExuToWbuIO extends NPCBundle {
  val cf = new CtrlFlow       // Control flow information
  val ctrl = new CtrlSignal   // Control signals
  val data = new DataSrc      // Data signals
}

// HandShakeDeal helper for managing valid/ready signals
object HandShakeDeal {
  def apply[T <: Data](in: DecoupledIO[T], out: DecoupledIO[T], 
                      AnyInvalidCondition: Bool, AnyStopCondition: Bool): Unit = {
    // Set output valid when input is valid and no invalid condition
    out.valid := in.valid && !AnyInvalidCondition
    
    // Set input ready when output is ready and no stop condition
    in.ready := out.ready && !AnyStopCondition
  }
}
