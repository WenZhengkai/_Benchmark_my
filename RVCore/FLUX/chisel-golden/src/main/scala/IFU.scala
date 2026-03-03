import chisel3._
import chisel3.util._



class IFUIO extends NPCBundle {
    val inst = Input(UInt(32.W))
    val to_idu = Decoupled(new CtrlFlow)

    val pc = Output(UInt(XLen.W))


    val redirect = Input(new Redirect)
}

class BruRes extends NPCBundle {
    val valid = Bool()
    val targetPc = UInt(XLen.W)
}

class IFU extends NPCModule 
with HasNPCParameter{
    val io = IO(new IFUIO)
    //val pc = RegNext(Mux(io.redirect, io.tnpc, io.snpc))
    val pc = RegInit("h80000000".U(XLen.W))
    val valid = RegInit(true.B)

    val out = io.to_idu

    val inInstOp = io.inst(6,0)
    val inInst   = io.inst

    val isBranch = MuxLookup(inInstOp,false.B, Array(
        "b1101111".U    -> true.B,      /* jal */
        "b1100111".U    -> true.B,      /* jalr */
        "b1100011".U    -> true.B       /* B type */
    ))
    val isEcall = inInst === "b000000000000_00000_000_00000_1110011".U
    val isMret  = inInst === "b0011000_00010_00000_000_00000_1110011".U
    val needBruRes = isBranch || isEcall || isMret
    out.bits.isBranch := isBranch

    //>>> jal branch process
    val jalBruRes = Wire(new BruRes)
    jalBruRes.valid := inInstOp === "b1101111".U
    val isJal = jalBruRes.valid
    val jalImmExt   = Cat(Fill(XLen - 21, inInst(31)), inInst(31), inInst(19,12), inInst(20), inInst(30, 21), 0.U(1.W))
    jalBruRes.targetPc := pc + jalImmExt

    //<<<

    //>>> branch result

    val snpc = pc + 4.U
    val predictPc = snpc 
    // BPU end
    val next_pc =   Mux(io.redirect.valid,      io.redirect.target,
                    Mux(out.ready === false.B,  pc,                 /* stop in back */
                    Mux(needBruRes === false.B, snpc,               /* Instruction is not branch type or trap */
                    Mux(isJal,                  jalBruRes.targetPc,
                    Mux(isJal === false.B,      predictPc,           /* branch, jalr, csr */
                    pc)))))                                         // otherwise

    pc := next_pc


    //>>> io
    io.to_idu.bits.pc := pc
    io.pc := pc
    io.to_idu.bits.inst := io.inst
    io.to_idu.bits.next_pc := next_pc

    
    val AnyInvalidCondition = false.B // TODO: add condition to it
    io.to_idu.valid := valid && (!AnyInvalidCondition)
    //<<< io
    


}

class IFU_LLM extends NPCModule {
  val io = IO(new IFUIO)

  // Task 1: PC Register Implementation
  val pcReg = RegInit("h80000000".U(XLen.W))

  // Connect current program counter to output
  io.pc := pcReg

  // Task 2: Instruction Type Decoding
  val opcode = io.inst(6, 0)

  val isJal = (opcode === "b1101111".U)
  val isJalr = (opcode === "b1100111".U)
  val isBranch = (opcode === "b1100011".U)
  val isJump = isJal || isJalr || isBranch
  val isEcall = (io.inst === "h00000073".U) // b0000000000000_00000_000_00000_1110011
  val isMret = (io.inst === "h30200073".U) // b0011000_00010_00000_000_00000_1110011

  // Task 3: JAL Target Calculation
  val jalOffset = Cat(
    Fill(XLen - 21, io.inst(31)),
    io.inst(31),
    io.inst(19, 12),
    io.inst(20),
    io.inst(30, 21),
    0.U(1.W)
  )
  val jalTarget = pcReg + jalOffset

  // Task 4: Static Branch Prediction
  val snpc = pcReg + 4.U // Static next PC
  val predictPc = snpc // Currently simple sequential prediction

  // Task 5: Next PC Selection Logic
  val next_pc = MuxCase(pcReg, Seq( // Default: stall current PC
    io.redirect.valid -> io.redirect.target,
    !io.to_idu.ready -> pcReg, // Stall if IDU not ready
    !isJump -> snpc, // Regular instruction
    isJal -> jalTarget, // JAL instruction
    (isJalr || isBranch) -> predictPc // Other jumps use prediction
  ))

  // Task 6: Control Flow Output Generation
  // io.to_idu.bits := new CtrlFlow().apply(
  //   inst = io.inst,
  //   pc = pcReg,
  //   next_pc = Mux(io.redirect.valid, io.redirect.target, predictPc), // Note: Actual next_pc for IDU
  //   isBranch = isBranch
  // )
  io.to_idu.bits.inst := io.inst
  io.to_idu.bits.pc   := pcReg
  //io.to_idu.bits.next_pc := Mux(io.redirect.valid, io.redirect.target, predictPc)
  io.to_idu.bits.next_pc := next_pc
  io.to_idu.bits.isBranch := isJump


  io.to_idu.valid := true.B // Always valid (stall handled by next_pc)

  // Task 7: Memory Interface Connection
  // Output `io.pc` is already connected in Task 1 as `pcReg`.

  // Task 8: Clock Domain Integration
  // Update PC register only when IDU is ready
  // when(io.to_idu.ready) {
  //   pcReg := next_pc
  // }
  pcReg := next_pc
}