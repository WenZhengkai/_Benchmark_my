// package npc

import chisel3._
import chisel3.util._

/** Execution Unit module that processes instructions from ISU and distributes them to
  * functional units (ALU, LSU, CSR) based on instruction type.
  */
class dut extends NPCModule with HasNPCParameter with TYPE_INST {
  val io = IO(new Bundle {
    // Input from instruction decode unit
    val from_isu = Flipped(Decoupled(new DecodeIO))
    // Output to write-back unit
    val to_wbu = Decoupled(new ExuToWbuIO)
    // Memory interface for LSU
    val to_mem = new ToMem
    val from_mem = new FromMem
    // Redirection signal for branch misprediction
    val redirect = Output(new Redirect)
  })

  // Pass control flow, control signals, and data from ISU to WBU
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

  // Connect LSU outputs
  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits
  io.to_mem := lsu0.io.to_mem

  // Connect CSR
  csr0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  csr0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  csr0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  csr0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.csr)
  csr0.io.out.ready := io.to_wbu.ready
  io.to_wbu.bits.data.csrRdata := csr0.io.out.bits

  // Branch resolution
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  // Detect branch misprediction
  val predictionError = bruRes.valid && (bruRes.targetPc =/= io.from_isu.bits.cf.next_pc)
  
  // Generate redirection signal
  io.redirect.valid := io.from_isu.valid && bruRes.valid && predictionError
  io.redirect.target := bruRes.targetPc
  
  // Update next_pc if branch prediction was wrong
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

/** Redirect signal for branch misprediction */
class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid = Bool()
}

/** Output from EXU to WBU */
class ExuToWbuIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

/** Helper function to calculate branch resolution */
object CalBruRes {
  def apply(inBits: DecodeIO, alu: ALU, csr: CSR): BruRes = {
    val res = Wire(new BruRes)
    
    // Default values
    res.valid := false.B
    res.targetPc := 0.U
    
    // Check if this is a branch/jump instruction
    when(inBits.cf.isBranch) {
      when(inBits.ctrl.fuType === FuType.alu) {
        // ALU handles branch instructions
        res.valid := alu.io.branchTaken
        res.targetPc := alu.io.branchTarget
      }.elsewhen(inBits.ctrl.fuType === FuType.csr) {
        // CSR handles special jumps like MRET
        res.valid := csr.io.jumpTaken
        res.targetPc := csr.io.jumpTarget
      }
    }
    
    res
  }
}

/** Branch resolution result */
class BruRes extends NPCBundle {
  val valid = Bool()      // Whether the branch is taken
  val targetPc = UInt(XLen.W)  // Target PC address
}

/** Handshake signal management helper */
object HandShakeDeal {
  def apply[T <: Data, U <: Data](
    in: DecoupledIO[T],
    out: DecoupledIO[U],
    AnyInvalidCondition: Bool,
    AnyStopCondition: Bool
  ): Unit = {
    // Handle ready/valid signals
    in.ready := out.ready && !AnyStopCondition
    out.valid := in.valid && !AnyInvalidCondition
  }
}
