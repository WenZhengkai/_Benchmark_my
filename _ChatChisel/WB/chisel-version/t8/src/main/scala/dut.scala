import chisel3._
import chisel3.util._

class dut extends Module {
  // I/O Declaration
  val io = IO(new Bundle {
    val csr_read_data_in = Input(UInt(32.W))  // Input: CSR read data
    val wb_reg_pc = Input(UInt(32.W))        // Input: Program counter value
    val wb_readdata = Input(UInt(32.W))      // Input: Data read from memory
    val wb_aluresult = Input(UInt(32.W))     // Input: ALU result
    val wb_memtoreg = Input(UInt(2.W))       // Input: Writeback control signal
    val writedata = Output(UInt(32.W))       // Output: Data to write to regfile
  })

  // Multiplexer Implementation for Writeback Data Selection
  io.writedata := 0.U  // Default assignment (avoiding latches)
  switch(io.wb_memtoreg) {
    is(0.U) { io.writedata := io.wb_reg_pc }        // Case: 00 -> Program counter (PC)
    is(1.U) { io.writedata := io.wb_readdata }      // Case: 01 -> Read data (Memory)
    is(2.U) { io.writedata := io.wb_aluresult }     // Case: 10 -> ALU result
    is(3.U) { io.writedata := io.csr_read_data_in } // Case: 11 -> CSR read data
  }
}

// Generate Verilog to verify your design
/*
object dutDriver extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
