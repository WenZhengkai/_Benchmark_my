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
  // Define I/O ports
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

  // Internal memory array
  val dpram_content = Mem(depth, UInt(width.W))

  // Port A logic
  val portawe_latched = RegNext(io.portawe)
  val portaaddr_latched = RegNext(io.portaaddr)
  val portadatain_latched = RegNext(io.portadatain)

  when(io.portaena && io.portawe && io.portaclk.asUInt.toBool) {
    dpram_content.write(io.portaaddr, io.portadatain)
  }

  val portadataout_tmp = dpram_content.read(io.portaaddr)

  // Port B logic
  val portbwe_latched = RegNext(io.portbwe)
  val portbaddr_latched = RegNext(io.portbaddr)
  val portbdatain_latched = RegNext(io.portbdatain)

  when(io.portbena && io.portbwe && io.portbclk.asUInt.toBool) {
    dpram_content.write(io.portbaddr, io.portbdatain)
  }

  val portbdataout_tmp = dpram_content.read(io.portbaddr)

  // Output mode handling
  if (output_mode == "REG") {
    val portadataout_reg = RegNext(portadataout_tmp)
    val portbdataout_reg = RegNext(portbdataout_tmp)

    io.portadataout := portadataout_reg
    io.portbdataout := portbdataout_reg
  } else {
    io.portadataout := portadataout_tmp
    io.portbdataout := portbdataout_tmp
  }

  // Handle simultaneous read/write conflicts
  when(io.portawe && io.portbwe && io.portaaddr === io.portbaddr) {
    dpram_content.write(io.portaaddr, "hX".U(width.W))
    io.portadataout := "hX".U(width.W)
    io.portbdataout := "hX".U(width.W)
  }
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), args)
}
*/
