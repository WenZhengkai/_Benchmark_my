import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val csr_read_data_in = Input(UInt(32.W))
    val wb_reg_pc = Input(UInt(32.W))
    val wb_readdata = Input(UInt(32.W))
    val wb_aluresult = Input(UInt(32.W))
    val wb_memtoreg = Input(UInt(2.W)) // 2-bit control signal
    val writedata = Output(UInt(32.W))
  })

  // Implement the writeback data multiplexer
  io.writedata := 0.U // Default value to avoid latches
  switch(io.wb_memtoreg) {
    is(0.U) { io.writedata := io.wb_reg_pc }          // Case 00
    is(1.U) { io.writedata := io.wb_readdata }        // Case 01
    is(2.U) { io.writedata := io.wb_aluresult }       // Case 10
    is(3.U) { io.writedata := io.csr_read_data_in }   // Case 11
  }
}

// Generate Verilog for the dut module
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
