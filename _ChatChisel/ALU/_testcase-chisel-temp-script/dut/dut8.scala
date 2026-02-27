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
  val result = WireDefault(0.U(32.W))
  switch(io.aluop) {
    is("b0000".U) { // ADD
      result := io.alu_in1 + io.alu_in2
    }
    is("b0001".U) { // SUB
      result := io.alu_in1 - io.alu_in2
    }

    // Task 3: Implement bitwise operations (XOR, OR, AND)
    is("b0010".U) { // XOR
      result := io.alu_in1 ^ io.alu_in2
    }
    is("b0011".U) { // OR
      result := io.alu_in1 | io.alu_in2
    }
    is("b0100".U) { // AND
      result := io.alu_in1 & io.alu_in2
    }

    // Task 4: Implement shift operations (SLL, SRL, SRA)
    is("b0101".U) { // Shift Left Logical (SLL)
      result := io.alu_in1 << io.alu_in2(4, 0) // Shift amount is the lower 5 bits
    }
    is("b0110".U) { // Shift Right Logical (SRL)
      result := io.alu_in1 >> io.alu_in2(4, 0) // Logical shift
    }
    is("b0111".U) { // Shift Right Arithmetic (SRA)
      result := (io.alu_in1.asSInt >> io.alu_in2(4, 0)).asUInt // Arithmetic shift
    }

    // Task 5: Implement comparison operations (SLT, SLTU)
    is("b1000".U) { // Set Less Than (SLT, signed)
      result := Mux(io.alu_in1.asSInt < io.alu_in2.asSInt, 1.U, 0.U)
    }
    is("b1001".U) { // Set Less Than Unsigned (SLTU)
      result := Mux(io.alu_in1 < io.alu_in2, 1.U, 0.U)
    }
  }

  // Task 6: Connect the result to the output port
  io.alu_result := result
}

// Generate the Verilog output for the dut module for testing purposes
/*
object dutMain extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut)
}
*/
