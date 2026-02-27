import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val alu_in1 = Input(UInt(32.W))     // First dut input
    val alu_in2 = Input(UInt(32.W))     // Second dut input
    val aluop   = Input(UInt(4.W))      // dut operation code
    val zero    = Output(UInt(1.W))     // Zero flag output
    val alu_result = Output(UInt(32.W)) // dut result output
  })

  // Task 1: Implement the zero flag
  io.zero := Mux(io.alu_in1 === io.alu_in2, 1.U, 0.U) // Set zero flag if inputs are equal

  // Declare a wire for intermediate result
  val result = WireDefault(0.U(32.W)) // Initialize result wire to 0

  // Task 2-5: Implement operations using a switch statement
  switch(io.aluop) {
    // ADD
    is("b0000".U) {
      result := io.alu_in1 + io.alu_in2 // Perform addition
    }
    // SUB
    is("b0001".U) {
      result := io.alu_in1 - io.alu_in2 // Perform subtraction
    }
    // XOR
    is("b0010".U) {
      result := io.alu_in1 ^ io.alu_in2 // Perform bitwise XOR
    }
    // OR
    is("b0011".U) {
      result := io.alu_in1 | io.alu_in2 // Perform bitwise OR
    }
    // AND
    is("b0100".U) {
      result := io.alu_in1 & io.alu_in2 // Perform bitwise AND
    }
    // Shift Left Logical (SLL)
    is("b0101".U) {
      result := io.alu_in1 << io.alu_in2(4, 0) // Logical left shift using low 5 bits of alu_in2
    }
    // Shift Right Logical (SRL)
    is("b0110".U) {
      result := io.alu_in1 >> io.alu_in2(4, 0) // Logical right shift using low 5 bits
    }
    // Shift Right Arithmetic (SRA)
    is("b0111".U) {
      result := (io.alu_in1.asSInt >> io.alu_in2(4, 0)).asUInt // Arithmetic right shift (sign-extends)
    }
    // Set Less Than (SLT)
    is("b1000".U) {
      result := Mux(io.alu_in1.asSInt < io.alu_in2.asSInt, 1.U, 0.U) // Signed comparison
    }
    // Set Less Than Unsigned (SLTU)
    is("b1001".U) {
      result := Mux(io.alu_in1 < io.alu_in2, 1.U, 0.U) // Unsigned comparison
    }
  }

  // Task 6: Connect the result wire to the output
  io.alu_result := result // Output the computed dut result
}

// Generate Verilog code for the dut module
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
