// package alu

import chisel3._
import chisel3.util._

/**
 * dut Module: Implements arithmetic, logic, shift, and comparison operations
 * as part of a RISC-V processor.
 */
class dut extends Module {
  val io = IO(new Bundle {
    val alu_in1 = Input(UInt(32.W))  // First dut operand
    val alu_in2 = Input(UInt(32.W))  // Second dut operand
    val aluop = Input(UInt(4.W))     // dut operation selector
    val zero = Output(UInt(1.W))     // Flag indicating equality between inputs
    val alu_result = Output(UInt(32.W)) // dut computed result
  })

  // Task 1: Implement the zero flag (output signal to indicate alu_in1 == alu_in2)
  io.zero := Mux(io.alu_in1 === io.alu_in2, 1.U, 0.U)

  // Task 2: Declare result wire and initialize to default value
  val result = WireDefault(0.U(32.W)) // Default value: 0

  // Task 3-5: Handle different dut operations
  switch(io.aluop) {
    // Arithmetic operations
    is("b0000".U) { result := io.alu_in1 + io.alu_in2 } // ADD
    is("b0001".U) { result := io.alu_in1 - io.alu_in2 } // SUB

    // Bitwise operations
    is("b0010".U) { result := io.alu_in1 ^ io.alu_in2 } // XOR
    is("b0011".U) { result := io.alu_in1 | io.alu_in2 } // OR
    is("b0100".U) { result := io.alu_in1 & io.alu_in2 } // AND

    // Shift operations
    is("b0101".U) { result := io.alu_in1 << io.alu_in2(4, 0) } // SLL (Shift Left Logical)
    is("b0110".U) { result := io.alu_in1 >> io.alu_in2(4, 0) } // SRL (Shift Right Logical)
    is("b0111".U) { // SRA (Shift Right Arithmetic)
      result := (io.alu_in1.asSInt >> io.alu_in2(4, 0)).asUInt
    }

    // Comparison operations
    is("b1000".U) { // SLT (Set Less Than, signed comparison)
      result := Mux(io.alu_in1.asSInt < io.alu_in2.asSInt, 1.U, 0.U)
    }
    is("b1001".U) { // SLTU (Set Less Than, unsigned comparison)
      result := Mux(io.alu_in1 < io.alu_in2, 1.U, 0.U)
    }
  }

  // Task 6: Connect the result wire to the output port
  io.alu_result := result
}

// Generate Verilog code from Chisel
/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
