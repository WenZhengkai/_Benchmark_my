// package core

import chisel3._
import chisel3.util._
import common._

class dut extends NPCModule with HasNPCParameter with TYPE_INST {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))       // Input from instruction decoding unit
    val to_wbu = Decoupled(new ExuToWbuIO)                // Output to write-back unit
    val to_mem = new ToMem                                // Output to memory
    val from_mem = new FromMem                            // Input from memory
    val redirect = Output(new Redirect)                   // Output redirection signal
  })

  // Connect control flow, control signals, and data from input to output
  io.to_wbu.bits.cf := io.from_isu.bits.cf
  io.to_wbu.bits.ctrl := io.from_isu.bits.ctrl
  io.to_wbu.bits.data := io.from_isu.bits.data

  // Instantiate ALU
  val alu0 = Module(new ALU)
  alu0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  alu0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  alu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.alu)
  alu0.io.out.ready := io.to_wbu.ready
  io.to_wbu.bits.data.Alu0Res.bits := alu0.io.out.bits
  io.to_wbu.bits.data.Alu0Res.valid := alu0.io.out.valid

  // Instantiate LSU
  val lsu0 = Module(new LSU)
  lsu0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  lsu0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  lsu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  lsu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.lsu)
  lsu0.io.out.ready := io.to_wbu.ready
  lsu0.io.from_mem := io.from_mem
  lsu0.io.ctrl := io.from_isu.bits.ctrl
  lsu0.io.data := io.from_isu.bits.data
  
  // Connect LSU outputs
  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits
  io.to_mem := lsu0.io.to_mem

  // Instantiate CSR
  val csr0 = Module(new CSR)
  csr0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  csr0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  csr0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  csr0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.csr)
  csr0.io.out.ready := io.to_wbu.ready
  io.to_wbu.bits.data.csrRdata := csr0.io.out.bits

  // Branch handling
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  // Generate redirection signal when prediction error occurs
  val predictionError = bruRes.valid && (bruRes.targetPc =/= io.from_isu.bits.cf.next_pc)
  io.redirect.valid := io.from_isu.valid && bruRes.valid && predictionError
  io.redirect.target := bruRes.targetPc

  // Update next_pc if there's a redirection
  when(io.redirect.valid) {
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

// Helper classes and definitions that should be defined elsewhere
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

// Helper function to calculate branch results
def CalBruRes(inBits: DecodeIO, alu: ALU, csr: CSR): BruRes = {
  val result = Wire(new BruRes)
  val isBranch = inBits.cf.isBranch
  
  // Default values
  result.valid := isBranch
  result.targetPc := Mux(isBranch, alu.io.out.bits, inBits.cf.next_pc)
  
  // Additional branch handling logic would go here
  // For example, checking branch condition based on ALU result
  
  result
}

// HandShake signal processing function
def HandShakeDeal(in: DecoupledIO[_], out: DecoupledIO[_], 
                  AnyInvalidCondition: Bool, AnyStopCondition: Bool): Unit = {
  // Default behavior
  out.valid := in.valid && !AnyInvalidCondition
  in.ready := out.ready && !AnyStopCondition
}
