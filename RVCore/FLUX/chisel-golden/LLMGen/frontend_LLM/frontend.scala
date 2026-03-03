// Frontend module definition
class Frontend(XLen: Int) extends Module {
  val io = IO(new FrontendIO(XLen))

  // Instantiate submodules
  val ifu = Module(new IFU_LLM2(XLen))
  val idu = Module(new IDU_LLM2(XLen))
  val isu = Module(new ISU_LLM2(XLen))

  // Connect IFU inputs and outputs
  ifu.io.inst := io.inst
  io.pc := ifu.io.pc
  ifu.io.redirect := io.ifuredirect

  // Connect ISU signals to IO port
  isu.io.wb := io.wb
  io.to_exu <> isu.io.to_exu

  // Processing rs1 and rs2
  val (rs1, rs2) = isu.rs1_rs2(io.rfSrc1, io.rfSrc2)
  io.rs1 := rs1
  io.rs2 := rs2

  // Interconnect between pipeline stages
  StageConnect(ifu.io.to_idu, idu.io.from_ifu, idu.io.to_isu.fire, io.redirect)
  StageConnect(idu.io.to_isu, isu.io.from_idu, isu.io.to_exu.fire, io.redirect)
}
