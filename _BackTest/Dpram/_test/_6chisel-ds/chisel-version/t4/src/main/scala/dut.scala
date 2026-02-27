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
  val io = IO(new Bundle {
    // Inputs
    val portawe = Input(Bool())
    val portbwe = Input(Bool())
    val portaena = Input(Bool())
    val portbena = Input(Bool())
    val portaclk = Input(Clock())
    val portbclk = Input(Clock())
    val portadatain = Input(UInt(width.W))
    val portbdatain = Input(UInt(width.W))
    val portaaddr = Input(UInt(addrwidth.W))
    val portbaddr = Input(UInt(addrwidth.W))
    // Outputs
    val portadataout = Output(UInt(width.W))
    val portbdataout = Output(UInt(width.W))
  })

  // Internal memory storage
  val dpram_content = SyncReadMem(depth, UInt(width.W))

  // Internal signals for Port A
  val portawe_latched = RegNext(io.portawe, false.B)
  val portaaddr_latched = RegNext(io.portaaddr, 0.U)
  val portadatain_latched = RegNext(io.portadatain, 0.U)
  val portadataout_tmp = Wire(UInt(width.W))
  val portadataout_reg = Reg(UInt(width.W))
  val portadataout_reg_out = RegNext(portadataout_reg, 0.U)

  // Internal signals for Port B
  val portbwe_latched = RegNext(io.portbwe, false.B)
  val portbaddr_latched = RegNext(io.portbaddr, 0.U)
  val portbdatain_latched = RegNext(io.portbdatain, 0.U)
  val portbdataout_tmp = Wire(UInt(width.W))
  val portbdataout_reg = Reg(UInt(width.W))
  val portbdataout_reg_out = RegNext(portbdataout_reg, 0.U)

  // Port A logic
  withClock(io.portaclk) {
    when(io.portaena) {
      when(io.portawe) {
        // Write operation for Port A
        dpram_content.write(io.portaaddr, io.portadatain)
      }.otherwise {
        // Read operation for Port A
        portadataout_tmp := dpram_content.read(io.portaaddr)
      }
    }
    // Registered output mode for Port A
    when(io.portaena) {
      portadataout_reg := portadataout_tmp
    }
  }

  // Port B logic
  withClock(io.portbclk) {
    when(io.portbena) {
      when(io.portbwe) {
        // Write operation for Port B
        dpram_content.write(io.portbaddr, io.portbdatain)
      }.otherwise {
        // Read operation for Port B
        portbdataout_tmp := dpram_content.read(io.portbaddr)
      }
    }
    // Registered output mode for Port B
    when(io.portbena) {
      portbdataout_reg := portbdataout_tmp
    }
  }

  // Output selection based on output_mode
  io.portadataout := Mux(output_mode === "REG", portadataout_reg_out, portadataout_tmp)
  io.portbdataout := Mux(output_mode === "REG", portbdataout_reg_out, portbdataout_tmp)
}

// Generate Verilog
/*
object Dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new Dut(), Array("--target-dir", "generated"))
}
*/
