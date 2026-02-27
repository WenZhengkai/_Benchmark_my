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
    val portadataout = Output(UInt(width.W))
    val portbdataout = Output(UInt(width.W))
  })

  // Internal memory representation
  val dpram_content = Mem(depth, UInt(width.W))

  // Registered outputs
  val portadataout_reg = Reg(UInt(width.W))
  val portbdataout_reg = Reg(UInt(width.W))

  // Temporary outputs
  val portadataout_tmp = Wire(UInt(width.W))
  val portbdataout_tmp = Wire(UInt(width.W))

  // Port A logic
  withClock(io.portaclk) {
    when(io.portaena) {
      when(io.portawe) {
        dpram_content.write(io.portaaddr, io.portadatain)
        portadataout_tmp := DontCare // Undefined behavior if writing
      }.otherwise {
        portadataout_tmp := dpram_content.read(io.portaaddr)
      }
    }.otherwise {
      portadataout_tmp := DontCare // Port disabled
    }

    if (output_mode == "REG") {
      portadataout_reg := portadataout_tmp
      io.portadataout := portadataout_reg
    } else {
      io.portadataout := portadataout_tmp
    }
  }

  // Port B logic
  withClock(io.portbclk) {
    when(io.portbena) {
      when(io.portbwe) {
        dpram_content.write(io.portbaddr, io.portbdatain)
        portbdataout_tmp := DontCare // Undefined behavior if writing
      }.otherwise {
        portbdataout_tmp := dpram_content.read(io.portbaddr)
      }
    }.otherwise {
      portbdataout_tmp := DontCare // Port disabled
    }

    if (output_mode == "REG") {
      portbdataout_reg := portbdataout_tmp
      io.portbdataout := portbdataout_reg
    } else {
      io.portbdataout := portbdataout_tmp
    }
  }

  // Handle simultaneous access conflicts
  when(io.portaena && io.portbena && io.portaaddr === io.portbaddr) {
    when(io.portawe || io.portbwe) {
      portadataout_tmp := "x".U(width.W)
      portbdataout_tmp := "x".U(width.W)
    }
  }
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut(), args)
}
*/
