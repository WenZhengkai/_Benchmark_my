// package core

import chisel3._
import chisel3.util._
import common._

class dut extends NPCModule with HasNPCParameter with TYPE_INST {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))    // Input from the instruction decoding unit
    val to_wbu = Decoupled(new ExuToWbuIO)             // Output to the write-back unit
    val to_mem = new ToMem                            // Output from the LSU functional unit to the memory
    val from_mem = new FromMem                        // Input from the memory to the LSU
    val redirect = Output(new Redirect)               // Output redirection signal
  })

  // Instantiate functional units
  val alu0 = Module(new ALU)
  val lsu0 = Module(new LSU)
  val csr0 = Module(new CSR)

  // Connect control flow, control signals, and data from input to output
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
  lsu0.io.out.ready := io.to_wbu.ready
  lsu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.lsu)
  lsu0.io.from_mem <> io.from_mem
  lsu0.io.ctrl := io.from_isu.bits.ctrl
  lsu0.io.data := io.from_isu.bits.data
  io.to_mem <> lsu0.io.to_mem
  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits

  // Connect CSR
  csr0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  csr0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  csr0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  csr0.io.out.ready := io.to_wbu.ready
  csr0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.csr)
  io.to_wbu.bits.data.csrRdata := csr0.io.out.bits

  // Branch handling
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  // Generate redirection signal
  val predictionError = io.from_isu.bits.cf.isBranch && 
                        bruRes.valid && 
                        (io.from_isu.bits.cf.next_pc =/= bruRes.targetPc)

  io.redirect.valid := io.from_isu.valid && bruRes.valid && predictionError
  io.redirect.target := bruRes.targetPc

  // Update next_pc if prediction error occurs
  when (predictionError) {
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

// Helper function to calculate branch result
object CalBruRes {
  def apply(inBits: DecodeIO, alu: ALU, csr: CSR): BruRes = {
    val res = Wire(new BruRes)
    
    // Default values
    res.valid := false.B
    res.targetPc := 0.U
    
    when (inBits.cf.isBranch) {
      when (inBits.ctrl.fuType === FuType.alu) {
        // Branch instruction handled by ALU (conditional branches)
        res.valid := alu.io.out.valid && alu.io.out.bits(0) // Assuming bit 0 indicates whether to take the branch
        res.targetPc := inBits.data.imm + inBits.cf.pc
      } .elsewhen (inBits.ctrl.fuType === FuType.csr) {
        // Branch instruction handled by CSR (e.g., MRET)
        res.valid := csr.io.out.valid
        res.targetPc := csr.io.out.bits
      } .otherwise {
        // Direct jumps (JAL, JALR)
        res.valid := true.B
        
        when (inBits.ctrl.fuOpType === FuOpType.jalr) {
          // JALR: PC = rs1 + imm
          res.targetPc := (inBits.data.fuSrc1 + inBits.data.imm) & (~1.U(XLen.W))
        } .otherwise {
          // JAL: PC = pc + imm
          res.targetPc := inBits.cf.pc + inBits.data.imm
        }
      }
    }
    res
  }
}

// Definition of the Redirect bundle
class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid = Bool()
}

// Definition of the interface between Execution Unit and Writeback Unit
class ExuToWbuIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// Function to handle handshake signals
object HandShakeDeal {
  def apply(
    in: DecoupledIO[DecodeIO], 
    out: DecoupledIO[ExuToWbuIO],
    AnyInvalidCondition: Bool,
    AnyStopCondition: Bool
  ): Unit = {
    // Handle valid signal
    out.valid := in.valid && !AnyInvalidCondition && !AnyStopCondition
    
    // Handle ready signal
    in.ready := out.ready && !AnyStopCondition
  }
}
