import chisel3._
import chisel3.util._

// Module implementation
class dut extends NPCModule with HasNPCParameter with TYPE_INST {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO))   // Input from instruction decode unit
    val to_wbu = Decoupled(new ExuToWbuIO)            // Output to write-back unit
    val to_mem = new ToMem                            // Output to memory
    val from_mem = Flipped(new FromMem)               // Input from memory
    val redirect = Output(new Redirect)               // Redirection signal for prediction errors
  })

  // Connect control flow, control signals, and data between from_isu and to_wbu
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
  alu0.io.out.ready := io.to_wbu.ready
  alu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.alu)
  io.to_wbu.bits.data.Alu0Res.bits := alu0.io.out.bits
  io.to_wbu.bits.data.Alu0Res.valid := alu0.io.out.valid

  // Connect LSU
  lsu0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  lsu0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  lsu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  lsu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.lsu)
  lsu0.io.in.ready := io.to_wbu.ready
  lsu0.io.ctrl := io.from_isu.bits.ctrl
  lsu0.io.data := io.from_isu.bits.data
  lsu0.io.from_mem := io.from_mem
  io.to_mem := lsu0.io.to_mem
  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits

  // Connect CSR
  csr0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  csr0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  csr0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  csr0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.csr)
  csr0.io.in.ready := io.to_wbu.ready
  io.to_wbu.bits.data.csrRdata := csr0.io.out.bits

  // Branch jump processing
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(io.from_isu.bits, alu0, csr0)

  // Generate redirection signal
  val predictionError = bruRes.valid && (bruRes.targetPc =/= io.from_isu.bits.cf.next_pc)
  io.redirect.valid := io.from_isu.valid && bruRes.valid && predictionError
  io.redirect.target := bruRes.targetPc

  // Update next_pc in case of redirection
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

// Redirect class definition
class Redirect extends NPCBundle {
  val target = UInt(XLen.W)
  val valid = Bool()
}

// ExuToWbuIO definition (assuming similar structure to DecodeIO but with execution results)
class ExuToWbuIO extends NPCBundle {
  val cf = new CtrlFlow
  val ctrl = new CtrlSignal
  val data = new DataSrc
}

// BruRes definition for branch results
class BruRes extends NPCBundle {
  val valid = Bool()
  val targetPc = UInt(XLen.W)
}

// CalBruRes helper function for branch calculations
object CalBruRes {
  def apply(inBits: DecodeIO, alu: ALU, csr: CSR): BruRes = {
    val res = Wire(new BruRes)
    // Default values
    res.valid := false.B
    res.targetPc := 0.U
    
    // Calculate branch target based on instruction type
    when(inBits.ctrl.fuType === FuType.bru) {
      res.valid := true.B
      // Branch target calculation logic here
      // This would depend on the specific instruction and ALU result
      when(alu.io.out.bits.asBool && inBits.cf.isBranch) {
        res.targetPc := inBits.data.fuSrc1 + inBits.data.imm
      }.otherwise {
        res.targetPc := inBits.cf.pc + 4.U
      }
    }
    
    // Handle jumps and other special control flow
    when(inBits.ctrl.fuType === FuType.jmp) {
      res.valid := true.B
      res.targetPc := inBits.data.fuSrc1 + inBits.data.imm
    }
    
    // Handle CSR-based control flow changes (like exceptions)
    when(csr.io.jumpTarget.valid) {
      res.valid := true.B
      res.targetPc := csr.io.jumpTarget.bits
    }
    
    res
  }
}

// Handshake handling function (assuming implementation)
object HandShakeDeal {
  def apply[T <: Data](in: DecoupledIO[T], out: DecoupledIO[T], 
                      AnyInvalidCondition: Bool, AnyStopCondition: Bool): Unit = {
    // Handshake logic implementation
    out.valid := in.valid && !AnyInvalidCondition
    in.ready := out.ready && !AnyStopCondition
  }
}
