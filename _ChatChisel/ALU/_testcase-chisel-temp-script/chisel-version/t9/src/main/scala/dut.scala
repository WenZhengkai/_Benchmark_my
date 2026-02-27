import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val alu_in1 = Input(UInt(32.W))
    val alu_in2 = Input(UInt(32.W))
    val aluop = Input(UInt(4.W))
    val zero = Output(UInt(1.W))
    val alu_result = Output(UInt(32.W))
  })

  // Task 1: Implement the zero flag
  // Compare `alu_in1` with `alu_in2` and generate `zero` output
  io.zero := (io.alu_in1 === io.alu_in2).asUInt

  // Task 2: Declare the result wire and initialize it
  val result = WireDefault(0.U(32.W)) // Default value is 0

  // Task 2-5: Perform operations based on `aluop` using a switch statement
  switch(io.aluop) {
    // Task 2: ADD and SUB operations
    is("b0000".U) { result := io.alu_in1 + io.alu_in2 } // ADD
    is("b0001".U) { result := io.alu_in1 - io.alu_in2 } // SUB

    // Task 3: Bitwise operations
    is("b0010".U) { result := io.alu_in1 ^ io.alu_in2 } // XOR
    is("b0011".U) { result := io.alu_in1 | io.alu_in2 } // OR
    is("b0100".U) { result := io.alu_in1 & io.alu_in2 } // AND

    // Task 4: Shift operations
    is("b0101".U) { result := io.alu_in1 << io.alu_in2(4, 0) } // SLL (uses lower 5 bits)
    is("b0110".U) { result := io.alu_in1 >> io.alu_in2(4, 0) } // SRL (uses lower 5 bits)
    is("b0111".U) { // SRA (arithmetic shift)
      result := (io.alu_in1.asSInt >> io.alu_in2(4, 0)).asUInt
    }

    // Task 5: Comparison operations
    is("b1000".U) { // SLT (signed comparison)
      result := Mux(io.alu_in1.asSInt < io.alu_in2.asSInt, 1.U, 0.U)
    }
    is("b1001".U) { // SLTU (unsigned comparison)
      result := Mux(io.alu_in1 < io.alu_in2, 1.U, 0.U)
    }
  }

  // Task 6: Connect the result to the output port
  io.alu_result := result
}

// Test your dut module in a Chisel `testbench` or `chiseltest` environment.
