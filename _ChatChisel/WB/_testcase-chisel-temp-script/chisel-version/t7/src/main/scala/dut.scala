import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val csr_read_data_in = Input(UInt(32.W))
    val wb_reg_pc = Input(UInt(32.W))
    val wb_readdata = Input(UInt(32.W))
    val wb_aluresult = Input(UInt(32.W))
    val wb_memtoreg = Input(UInt(2.W))
    val writedata = Output(UInt(32.W))
  })

  // Implement the writeback data multiplexer
  io.writedata := 0.U // Default value to avoid latches (not strictly necessary here but good practice)

  switch(io.wb_memtoreg) {
    is(0.U) { io.writedata := io.wb_reg_pc }
    is(1.U) { io.writedata := io.wb_readdata }
    is(2.U) { io.writedata := io.wb_aluresult }
    is(3.U) { io.writedata := io.csr_read_data_in }
  }
}

// Generate the Verilog for dut module
/*
object dutDriver extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
