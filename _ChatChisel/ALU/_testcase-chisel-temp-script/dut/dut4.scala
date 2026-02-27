import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val alu_in1 = Input(UInt(32.W))    // First input
    val alu_in2 = Input(UInt(32.W))    // Second input
    val aluop = Input(UInt(4.W))       // Operation selector
    val zero = Output(UInt(1.W))       // Zero flag
    val alu_result = Output(UInt(32.W)) // Result of dut operations
  })

  // Task 1: Implement the zero flag
  // Compare if alu_in1 is equal to alu_in2
  io.zero := (io.alu_in1 === io.alu_in2).asUInt

  // Task 2: Declare the result wire and begin handling operations
  val result = Wire(UInt(32.W)) // Intermediate result
  result := 0.U                 // Default value

  // Task 3: Switch statement to handle operations
  switch(io.aluop) {
    // Arithmetic operations
    is("b0000".U) { result := io.alu_in1 + io.alu_in2 } // ADD
    is("b0001".U) { result := io.alu_in1 - io.alu_in2 } // SUB

    // Bitwise operations
    is("b0010".U) { result := io.alu_in1 ^ io.alu_in2 } // XOR
    is("b0011".U) { result := io.alu_in1 | io.alu_in2 } // OR
    is("b0100".U) { result := io.alu_in1 & io.alu_in2 } // AND

    // Shift operations
    is("b0101".U) { result := io.alu_in1 << io.alu_in2(4, 0) } // SLL
    is("b0110".U) { result := io.alu_in1 >> io.alu_in2(4, 0) } // SRL
    is("b0111".U) { result := (io.alu_in1.asSInt >> io.alu_in2(4, 0)).asUInt } // SRA

    // Comparison operations
    is("b1000".U) { result := Mux(io.alu_in1.asSInt < io.alu_in2.asSInt, 1.U, 0.U) } // SLT
    is("b1001".U) { result := Mux(io.alu_in1 < io.alu_in2, 1.U, 0.U) }              // SLTU
  }

  // Task 6: Connect the result to the output port
  io.alu_result := result
}

// Generate Verilog for the dut module
/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
