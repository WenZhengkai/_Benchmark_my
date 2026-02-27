import chisel3._
import chisel3.util._

class dut(
    operation_mode: String = "DUAL_PORT",
    addrwidth: Int = 14,
    width: Int = 32,
    depth: Int = 16384,
    output_mode: String = "REG"
) extends Module {
  require(operation_mode == "DUAL_PORT" || operation_mode == "SINGLE_PORT",
    "operation_mode must be either 'DUAL_PORT' or 'SINGLE_PORT'")
  require(output_mode == "REG" || output_mode == "UNREG",
    "output_mode must be either 'REG' or 'UNREG'")
  
  // Ports
  val io = IO(new Bundle {
    // Clock and enable signals
    val portawe      = Input(Bool())             // Write enable (Port A)
    val portbwe      = Input(Bool())             // Write enable (Port B)
    val portaena     = Input(Bool())             // Port A enable
    val portbena     = Input(Bool())             // Port B enable
    val portaclk     = Input(Clock())            // Clock for Port A
    val portbclk     = Input(Clock())            // Clock for Port B
    // Address and data buses
    val portadatain  = Input(UInt(width.W))      // Data input (Port A)
    val portbdatain  = Input(UInt(width.W))      // Data input (Port B)
    val portaaddr    = Input(UInt(addrwidth.W))  // Address input (Port A)
    val portbaddr    = Input(UInt(addrwidth.W))  // Address input (Port B)
    val portadataout = Output(UInt(width.W))     // Data output (Port A)
    val portbdataout = Output(UInt(width.W))     // Data output (Port B)
  })

  // Internal memory array
  val dpram_content = SyncReadMem(depth, UInt(width.W))

  // Registered outputs (used if output_mode = "REG")
  val portadataout_reg = RegInit(0.U(width.W))
  val portbdataout_reg = RegInit(0.U(width.W))

  // Port A Write Operation
  withClock(io.portaclk) {
    when(io.portawe && io.portaena) {
      dpram_content.write(io.portaaddr, io.portadatain)
    }
  }

  // Port B Write Operation
  withClock(io.portbclk) {
    when(io.portbwe && io.portbena) {
      dpram_content.write(io.portbaddr, io.portbdatain)
    }
  }

  // Port A Read Operation
  val portadataout_tmp = Wire(UInt(width.W))
  withClock(io.portaclk) {
    when(io.portaena && !io.portawe) {
      portadataout_tmp := dpram_content.read(io.portaaddr, io.portaena)
    }.otherwise {
      portadataout_tmp := 0.U
    }
  }
  when(output_mode == "REG".U) {
    when(io.portaena) {
      portadataout_reg := portadataout_tmp
    }
    io.portadataout := portadataout_reg
  }.otherwise {
    io.portadataout := portadataout_tmp
  }

  // Port B Read Operation
  val portbdataout_tmp = Wire(UInt(width.W))
  withClock(io.portbclk) {
    when(io.portbena && !io.portbwe) {
      portbdataout_tmp := dpram_content.read(io.portbaddr, io.portbena)
    }.otherwise {
      portbdataout_tmp := 0.U
    }
  }
  when(output_mode == "REG".U) {
    when(io.portbena) {
      portbdataout_reg := portbdataout_tmp
    }
    io.portbdataout := portbdataout_reg
  }.otherwise {
    io.portbdataout := portbdataout_tmp
  }
}

/*
object AltExcDPRAM extends App {
  // Generate Verilog for the module with default parameters
  println("Generating Verilog for AltExcDPRAM...")
  (new chisel3.stage.ChiselStage).emitVerilog(
    new AltExcDPRAM(),
    args
  )
}
*/
