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
  io.zero := (io.alu_in1 === io.alu_in2).asUInt

  // Task 2: Declare the result wire and handle ADD/SUB operations
  val result = WireDefault(0.U(32.W)) // Declare a 32-bit result wire with default value 0

  switch(io.aluop) {
    // ADD operation
    is("b0000".U) {
      result := io.alu_in1 + io.alu_in2
    }

    // SUB operation
    is("b0001".U) {
      result := io.alu_in1 - io.alu_in2
    }

    // Task 3: Implement bitwise operations
    // XOR operation
    is("b0010".U) {
      result := io.alu_in1 ^ io.alu_in2
    }

    // OR operation
    is("b0011".U) {
      result := io.alu_in1 | io.alu_in2
    }

    // AND operation
    is("b0100".U) {
      result := io.alu_in1 & io.alu_in2
    }

    // Task 4: Implement shift operations
    // Shift Left Logical (SLL)
    is("b0101".U) {
      result := io.alu_in1 << io.alu_in2(4, 0) // Use low 5 bits of alu_in2
    }

    // Shift Right Logical (SRL)
    is("b0110".U) {
      result := io.alu_in1 >> io.alu_in2(4, 0) // Use low 5 bits of alu_in2
    }

    // Shift Right Arithmetic (SRA)
    is("b0111".U) {
      result := (io.alu_in1.asSInt >> io.alu_in2(4, 0)).asUInt // Convert alu_in1 to signed, perform shift, convert back to unsigned
    }

    // Task 5: Implement comparison operations
    // Set Less Than (SLT)
    is("b1000".U) {
      result := Mux(io.alu_in1.asSInt < io.alu_in2.asSInt, 1.U, 0.U)
    }

    // Set Less Than Unsigned (SLTU)
    is("b1001".U) {
      result := Mux(io.alu_in1 < io.alu_in2, 1.U, 0.U)
    }
  }

  // Task 6: Connect the result to the output port
  io.alu_result := result
}

/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
