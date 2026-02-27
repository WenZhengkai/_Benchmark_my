import chisel3._
import chisel3.util._
import freechips.rocketchip.config.Parameters
import freechips.rocketchip.tile._

class dut(implicit p: Parameters) extends Module with HasNPCParameters {
  val io = IO(new Bundle {
    val from_isu = Flipped(Decoupled(new DecodeIO)) // Input from the instruction decoding unit
    val to_wbu = Decoupled(new ExuToWbuIO) // Output to the write-back unit
    val to_mem = new ToMem // Output to memory (LSU)
    val from_mem = new FromMem // Input from memory (LSU)
    val redirect = Output(new Redirect) // Redirection signal for branch correction
  })

  // Internal signals and functional units
  val alu0 = Module(new ALU)
  val lsu0 = Module(new LSU)
  val csr0 = Module(new CSR)

  // Wire for branch result
  val bruRes = Wire(new BruRes)
  bruRes := CalBruRes(io.from_isu.bits, alu0.io.out.bits, csr0.io.out.bits)

  // Connect from_isu to functional units
  alu0.io.in.bits.srca := io.from_isu.bits.data.fuSrc1
  alu0.io.in.bits.srcb := io.from_isu.bits.data.fuSrc2
  alu0.io.in.bits.fuOpType := io.from_isu.bits.ctrl.fuOpType
  alu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.alu)
  alu0.io.out.ready := io.to_wbu.ready

  lsu0.io.from_mem := io.from_mem
  lsu0.io.ctrl := io.from_isu.bits.ctrl
  lsu0.io.data := io.from_isu.bits.data
  lsu0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.lsu)
  lsu0.io.out.ready := io.to_wbu.ready

  csr0.io.in.bits := io.from_isu.bits.data
  csr0.io.in.valid := io.from_isu.valid && (io.from_isu.bits.ctrl.fuType === FuType.csr)
  csr0.io.out.ready := io.to_wbu.ready

  // Connect functional unit outputs to to_wbu
  io.to_wbu.bits.data.Alu0Res.bits := alu0.io.out.bits
  io.to_wbu.bits.data.data_from_mem := lsu0.io.out.bits
  io.to_wbu.bits.data.csrRdata := csr0.io.out.bits

  // Connect LSU to memory
  io.to_mem := lsu0.io.to_mem

  // Branch jump processing
  val isPredictionError = io.from_isu.bits.cf.next_pc =/= bruRes.targetPc
  io.redirect.valid := io.from_isu.valid && bruRes.valid && isPredictionError
  io.redirect.target := Mux(isPredictionError, bruRes.targetPc, io.from_isu.bits.cf.next_pc)

  // Update next_pc in to_wbu
  io.to_wbu.bits.cf.next_pc := Mux(isPredictionError, bruRes.targetPc, io.from_isu.bits.cf.next_pc)

  // Handshake signal processing
  HandShakeDeal(
    in = io.from_isu,
    out = io.to_wbu,
    AnyInvalidCondition = false.B,
    AnyStopCondition = io.redirect.valid && io.from_isu.valid
  )
}

// Helper function for handshake signal processing
object HandShakeDeal {
  def apply(
      in: DecoupledIO[DecodeIO],
      out: DecoupledIO[ExuToWbuIO],
      AnyInvalidCondition: Bool,
      AnyStopCondition: Bool
  ): Unit = {
    out.valid := in.valid && !AnyInvalidCondition && !AnyStopCondition
    in.ready := out.ready && !AnyInvalidCondition && !AnyStopCondition
  }
}

// Function to calculate branch result
object CalBruRes {
  def apply(inBits: DecodeIO, aluRes: UInt, csrRes: UInt): BruRes = {
    val res = Wire(new BruRes)
    res.valid := inBits.cf.isBranch
    res.targetPc := Mux(inBits.ctrl.fuType === FuType.alu, aluRes, csrRes)
    res
  }
}

// Define the BruRes bundle
class BruRes extends NPCBundle {
  val valid = Bool()
  val targetPc = UInt(XLen.W)
}

// Define the ALU, LSU, and CSR modules (stubs for demonstration)
class ALU extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Decoupled(new ALUInput))
    val out = Decoupled(UInt(XLen.W))
  })
  // ALU logic (not implemented here)
}

class LSU extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Decoupled(new LSUInput))
    val out = Decoupled(UInt(XLen.W))
    val from_mem = Input(new FromMem)
    val to_mem = Output(new ToMem)
  })
  // LSU logic (not implemented here)
}

class CSR extends Module {
  val io = IO(new Bundle {
    val in = Flipped(Decoupled(new CSRInput))
    val out = Decoupled(UInt(XLen.W))
  })
  // CSR logic (not implemented here)
}

// Define input/output bundles for ALU, LSU, and CSR (stubs for demonstration)
class ALUInput extends Bundle {
  val srca = UInt(XLen.W)
  val srcb = UInt(XLen.W)
  val fuOpType = FuOpType()
}

class LSUInput extends Bundle {
  val data = new DataSrc
  val ctrl = new CtrlSignal
}

class CSRInput extends Bundle {
  val data = new DataSrc
}

// Define memory interface bundles (stubs for demonstration)
class ToMem extends Bundle {
  // Memory output signals
}

class FromMem extends Bundle {
  // Memory input signals
}
