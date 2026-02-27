import chisel3._
import chisel3.util._
import scala.annotation.switch



class ALUIO extends FunctionUnitIO {
    val taken = Output(Bool())      // if Branch Taken
}

class ALU_golden extends NPCModule {
    val io = IO(new ALUIO)

    val srca = io.in.bits.srca
    val srcb = io.in.bits.srcb
    val fuOpType = io.in.bits.fuOpType
    val aluRes = WireDefault(0.U)

    io.in.ready := true.B
    io.out.valid := io.in.valid

    io.out.bits := aluRes


    val isAdderSub = !ALUOpType.isAdd(fuOpType)
    val adderRes = (srca +& (srcb ^ Fill(XLen, isAdderSub))) + isAdderSub
    val xorRes = srca ^ srcb
    val sltu = !adderRes(XLen)
    val slt = xorRes(XLen-1) ^ sltu

    val shsrc1 = MuxLookup(fuOpType, srca(XLen-1,0), Array(
      ALUOpType.srlw -> ZeroExt(srca(31,0), XLen),
      ALUOpType.sraw -> SignExt(srca(31,0), XLen)
    ))
    val shamt = Mux(ALUOpType.isWordOp(fuOpType), srcb(4, 0), if (XLen == 64) srcb(5, 0) else srcb(4, 0))
    val res = MuxLookup(fuOpType, adderRes, Array(
      ALUOpType.sll  -> ((shsrc1  << shamt)(XLen-1, 0)),
      ALUOpType.slt  -> ZeroExt(slt, XLen),
      ALUOpType.sltu -> ZeroExt(sltu, XLen),
      ALUOpType.xor  -> xorRes,
      ALUOpType.srl  -> (shsrc1  >> shamt),
      ALUOpType.or   -> (srca  |  srcb),
      ALUOpType.and  -> (srca  &  srcb),
      ALUOpType.sra  -> ((shsrc1.asSInt >> shamt).asUInt)
    ))
    aluRes := Mux(ALUOpType.isWordOp(fuOpType), SignExt(res(31,0), 64), res)

    //>>> Branch Taken
    val branchOpTable = Array(
    ALUOpType.getBranchType(ALUOpType.beq)  -> !xorRes.orR,
    ALUOpType.getBranchType(ALUOpType.blt)  -> slt,
    ALUOpType.getBranchType(ALUOpType.bltu) -> sltu
  )
    io.taken := MuxLookup(ALUOpType.getBranchType(fuOpType), false.B, branchOpTable) ^ ALUOpType.isBranchInvert(fuOpType)
    //<<< Branch Taken
}


class ExuToWbu extends NPCBundle {
    val ALURes = UInt(XLen.W)

}
class ExuToLsuIO extends NPCBundle {

    //val to_mem = new ToMem

    val cf      = new CtrlFlow
    val ctrl    = new CtrlSignal
    val data    = new DataSrc

}
class ExuToWbuIO extends NPCBundle {

    //val to_mem = new ToMem

    val cf      = new CtrlFlow
    val ctrl    = new CtrlSignal
    val data    = new DataSrc

}
class EXU_golden extends NPCModule 
with HasNPCParameter 
with TYPE_INST{
    val io = IO(new Bundle{
        val from_isu = Flipped(Decoupled(new DecodeIO))
        val to_wbu = Decoupled(new ExuToWbuIO)
        //val bruRes = Output(new BruRes)
        val to_mem = new ToMem
        val from_mem = new FromMem
        val redirect = Output(new Redirect)

    })
    //>>> io




    val MicroOp = io.from_isu.bits
    val inBits = io.from_isu.bits
    val in     = io.from_isu

    val out    = io.to_wbu

    out.bits.cf <> MicroOp.cf 
    out.bits.ctrl <> MicroOp.ctrl
    out.bits.data <> MicroOp.data

    //out.bits.data.data_from_mem := io.from_mem.data    // TODO: from lsu

    val fuSrc1 = MicroOp.data.fuSrc1
    val fuSrc2 = MicroOp.data.fuSrc2
    //<<< io

    // alu
    val alu0 = Module(new ALU_golden)
    val alu0InBits = alu0.io.in.bits
    alu0InBits.srca := fuSrc1
    alu0InBits.srcb := fuSrc2
    alu0InBits.fuOpType := MicroOp.ctrl.fuOpType

    //val ALURes0 = alu0.io.out.bits

    // lsu
    val lsu0 = Module(new LSU_golden)
    lsu0.io.in.bits.srca := fuSrc1
    lsu0.io.in.bits.srcb := fuSrc2
    lsu0.io.in.bits.fuOpType := MicroOp.ctrl.fuOpType

    lsu0.io.from_mem <> io.from_mem
    io.to_mem <> lsu0.io.to_mem

    lsu0.io.ctrl <> MicroOp.ctrl
    lsu0.io.data <> MicroOp.data

    out.bits.data.data_from_mem := lsu0.io.out.bits

    // csr
    val csr0 = Module(new CSR_golden)
    csr0.cfIn <> MicroOp.cf
    val csr0Out = csr0.access(
      in.valid && (in.bits.ctrl.fuType === FuType.csr),     // valid
      fuSrc1,
      fuSrc2,
      MicroOp.ctrl.fuOpType
    )
    out.bits.data.csrRdata := csr0Out

    //>>> ready/valid function unit //TODO : Demux
    alu0.io.out.ready := out.ready
    alu0.io.in.valid := in.valid && (in.bits.ctrl.fuType === FuType.alu)

    lsu0.io.out.ready := out.ready 
    lsu0.io.in.valid := in.valid && (in.bits.ctrl.fuType === FuType.lsu)

    csr0.io.out.ready := out.ready
    //csr0.io.in.valid := in.valid && (in.bits.ctrl.fuType === FuType.lsu)
    //<<<ready/valid function unit

    //>>> branch pc calculate
    val bruRes = Wire(new BruRes)
    val jalrBruRes = Wire(new BruRes)
    jalrBruRes.valid := in.valid && inBits.cf.isBranch && (inBits.cf.inst(6,0) === "b1100111".U)
    //jalrBruRes.valid := in.valid && inBits.cf.isBranch
    jalrBruRes.targetPc := (inBits.data.rfSrc1 + inBits.data.imm) & (~1.U(XLen.W))

    val typebBruRes = Wire(new BruRes)
    typebBruRes.valid := in.valid && inBits.cf.isBranch && (inBits.cf.inst(6,0) === "b1100011".U)   // TYPE_B
    val pcIfBranch = inBits.cf.pc + inBits.data.imm
    typebBruRes.targetPc := Mux(alu0.io.taken, pcIfBranch, inBits.cf.pc + 4.U)    //TODO

    val csrBruRes = Wire(new BruRes)
    csrBruRes.valid := in.valid && csr0.io.jmp
    csrBruRes.targetPc := csr0Out

    val defaultBruRes = Wire(new BruRes)
    defaultBruRes.valid := false.B 
    defaultBruRes.targetPc := 0.U


    bruRes := MuxCase(defaultBruRes, Array(
        jalrBruRes.valid  -> jalrBruRes,
        typebBruRes.valid   -> typebBruRes,
        csrBruRes.valid   -> csrBruRes
    ))

    // redirect
    val PredictError = bruRes.targetPc =/= MicroOp.cf.next_pc
    io.redirect.valid := in.valid && bruRes.valid && PredictError
    io.redirect.target := bruRes.targetPc

    out.bits.cf.next_pc := Mux(bruRes.valid, bruRes.targetPc, MicroOp.cf.next_pc)

    val isRedirect = io.redirect.valid

    //<<< branch pc calculate 

    // io

    //out.bits.data.Alu0Res <> alu0.io.out
    //out.bits.data.Alu0Res.valid := alu0.io.out.valid
    out.bits.data.Alu0Res.bits := alu0.io.out.bits


    // ready/valid setted here
    HandShakeDeal(io.from_isu, io.to_wbu, 
                  AnyInvalidCondition = false.B, 
                  AnyStopCodition = isRedirect && in.valid
                  )

}








class LsuToWbuIO extends NPCBundle {
    val data_from_mem = Output(UInt(XLen.W))

    val cf = new CtrlFlow
    val ctrl = new CtrlSignal
    val data = new DataSrc

}

class LSUIO extends FunctionUnitIO {
    val to_mem = new ToMem
    val from_mem = new FromMem
    val ctrl    = Input(new CtrlSignal)
    val data  = Input(new DataSrc)
}

class LSU_golden extends NPCModule 
with HasNPCParameter {
    /*
    val io = IO(new Bundle{
        val from_exu = Flipped(Decoupled(new ExuToLsuIO))
        val to_wbu = Decoupled(new LsuToWbuIO)
        val to_mem = new ToMem
        val from_mem = new FromMem
    })
    */
    val io = IO(new LSUIO)
    // io
    //>>> ready/valid
    io.out.valid := io.in.valid     // TODO: add memory response
    io.in.ready := true.B
    //<<< ready/valid
 
    io.to_mem.data := io.data.rfSrc2

    io.to_mem.addr := io.in.bits.srca + io.in.bits.srcb
    io.to_mem.Wmask := MuxLookup(io.ctrl.fuOpType, "h00".U, Array(
        LSUOpType.sb    -> "h01".U,
        LSUOpType.sh    -> "h03".U,
        LSUOpType.sw    -> "h0f".U,
        LSUOpType.sd    -> "hff".U
    ))

    io.to_mem.MemWrite := io.ctrl.MemWrite


    // signals used in LSU_golden


    // signals transport
    val from_mem_data = io.from_mem.data

    io.out.bits := MuxLookup(io.ctrl.fuOpType, 0.U, Array(
        LSUOpType.lb    -> SignExt(from_mem_data(7,0), XLen),
        LSUOpType.lh    -> SignExt(from_mem_data(15,0), XLen),
        LSUOpType.lw    -> SignExt(from_mem_data(31,0), XLen),
        //LSUOpType.ld    -> SignExt(from_mem_data(63,0), XLen),

        LSUOpType.lbu    -> ZeroExt(from_mem_data(7,0), XLen),
        LSUOpType.lhu    -> ZeroExt(from_mem_data(15,0), XLen),
        LSUOpType.lwu    -> ZeroExt(from_mem_data(31,0), XLen)    
    ))
  
    // io

}





class CSRIO extends FunctionUnitIO {
  val cfIn  = Input(new CtrlFlow)
  val jmp   = Output(Bool())

}

class CSR_golden extends NPCModule
with HasCSRConst
with HasExceptionNO
{
  val io = IO(new CSRIO)

  val (valid, srca, srcb, fuOpType) = (io.in.valid, io.in.bits.srca, io.in.bits.srcb, io.in.bits.fuOpType)
  def access(valid: Bool, src1: UInt, src2: UInt, func: UInt): UInt = {
    this.valid := valid
    this.srca := src1
    this.srcb := src2
    this.fuOpType := func
    io.out.bits
  }
  io.in.ready := true.B
  io.out.valid := valid
    val cfIn = io.cfIn
    // Machine-Level CSRs
    

    val mtvec = RegInit(UInt(XLen.W), 0.U)
    val mcause = RegInit(UInt(XLen.W), 0.U)

    val mepc = RegInit(UInt(XLen.W), 0.U)


    val mstatus_init = if(XLen == 64) "ha00001800".U else "h00001800".U
    val mstatus = RegInit(UInt(XLen.W), mstatus_init)

    val csrIndex = srcb

    val isEcall = cfIn.inst === "b000000000000_00000_000_00000_1110011".U
    val isMret  = cfIn.inst === "b0011000_00010_00000_000_00000_1110011".U
    val isEbreak = cfIn.inst === "b000000000001_00000_000_00000_1110011".U

    val csr = MuxLookup(csrIndex, 0.U, Array(
      Mtvec.U   -> mtvec,
      Mcause.U  -> mcause,
      Mepc.U    -> mepc,
      Mstatus.U  -> mstatus
    ))
    val csrUpdate = MuxLookup(fuOpType, 0.U, Array(
      CSROpType.wrt   ->  srca,
      CSROpType.set   ->  (srca | csr),
      CSROpType.clr ->  (~srca & csr)
    ))
    val csrWen = valid && (fuOpType =/= CSROpType.jmp)
    when(csrWen === true.B){
      when(csrIndex === Mtvec.U){
        mtvec := csrUpdate
      }
      when(csrIndex === Mcause.U){
        mcause := csrUpdate
      }
      when(csrIndex === Mepc.U){
        mepc  := csrUpdate
      }
      when(csrIndex === Mstatus.U){
        mstatus := csrUpdate
      }
    }
    // ecall
    when(csrWen === false.B && valid === true.B && isEcall ) {
      mcause  := ecallM.U
      mepc    := cfIn.pc
    }

    io.jmp := valid && (fuOpType === CSROpType.jmp) && !isEbreak
    io.out.bits   := MuxCase(csr, Array(
      (isEcall === true.B)   -> mtvec,
      (isMret === true.B)    -> mepc
    ))
  

}