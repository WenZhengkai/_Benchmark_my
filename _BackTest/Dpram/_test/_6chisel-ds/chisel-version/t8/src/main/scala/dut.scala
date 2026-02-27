import chisel3._
import chisel3.util._

class dut(
  val operation_mode: String = "DUAL_PORT",
  val addrwidth: Int = 14,
  val width: Int = 32,
  val depth: Int = 16384,
  val ramblock: Int = 65535,
  val output_mode: String = "REG",
  val lpm_file: String = "NONE",
  val lpm_type: String = "alt_exc_dpram",
  val lpm_hint: String = "UNUSED"
) extends Module {
  require(operation_mode == "SINGLE_PORT" || operation_mode == "DUAL_PORT", "Invalid operation_mode")
  require(output_mode == "REG" || output_mode == "UNREG", "Invalid output_mode")

  val io = IO(new Bundle {
    // Port A
    val portawe = Input(Bool())
    val portaena = Input(Bool())
    val portaclk = Input(Clock())
    val portadatain = Input(UInt(width.W))
    val portaaddr = Input(UInt(addrwidth.W))
    val portadataout = Output(UInt(width.W))

    // Port B
    val portbwe = Input(Bool())
    val portbena = Input(Bool())
    val portbclk = Input(Clock())
    val portbdatain = Input(UInt(width.W))
    val portbaddr = Input(UInt(addrwidth.W))
    val portbdataout = Output(UInt(width.W))
  })

  // Internal memory storage
  val dpram_content = SyncReadMem(depth, UInt(width.W))

  // Port A logic
  val portawe_latched = RegNext(io.portawe, false.B)
  val portaaddr_latched = RegNext(io.portaaddr, 0.U)
  val portadatain_latched = RegNext(io.portadatain, 0.U)
  val portadataout_tmp = Wire(UInt(width.W))

  when(io.portaena && io.portawe) {
    dpram_content.write(io.portaaddr, io.portadatain)
  }

  portadataout_tmp := dpram_content.read(io.portaaddr)

  // Port B logic
  val portbwe_latched = RegNext(io.portbwe, false.B)
  val portbaddr_latched = RegNext(io.portbaddr, 0.U)
  val portbdatain_latched = RegNext(io.portbdatain, 0.U)
  val portbdataout_tmp = Wire(UInt(width.W))

  when(io.portbena && io.portbwe) {
    dpram_content.write(io.portbaddr, io.portbdatain)
  }

  portbdataout_tmp := dpram_content.read(io.portbaddr)

  // Handle simultaneous read/write conflicts
  when(io.portawe && io.portbwe && io.portaaddr === io.portbaddr) {
    portadataout_tmp := "x".asUInt(width.W)
    portbdataout_tmp := "x".asUInt(width.W)
  }

  // Output mode handling
  if (output_mode == "REG") {
    val portadataout_reg = RegNext(portadataout_tmp, 0.U)
    val portbdataout_reg = RegNext(portbdataout_tmp, 0.U)
    io.portadataout := portadataout_reg
    io.portbdataout := portbdataout_reg
  } else {
    io.portadataout := portadataout_tmp
    io.portbdataout := portbdataout_tmp
  }
}

// Generate Verilog
/*
object Dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new Dut(), args)
}
*/
