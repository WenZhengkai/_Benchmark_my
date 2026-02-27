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

  // Task 1: Implement the zero flag to indicate equality
  io.zero := Mux(io.alu_in1 === io.alu_in2, 1.U, 0.U)

  // Declare the result wire with a default value
  val result = WireDefault(0.U(32.W))

  // Task 2-5: Implement dut operations
  switch(io.aluop) {
    // Case ADD (0000)
    is("b0000".U) {
      result := io.alu_in1 + io.alu_in2
    }
    // Case SUB (0001)
    is("b0001".U) {
      result := io.alu_in1 - io.alu_in2
    }
    // Case XOR (0010)
    is("b0010".U) {
      result := io.alu_in1 ^ io.alu_in2
    }
    // Case OR (0011)
    is("b0011".U) {
      result := io.alu_in1 | io.alu_in2
    }
    // Case AND (0100)
    is("b0100".U) {
      result := io.alu_in1 & io.alu_in2
    }
    // Case SLL (Shift Left Logical, 0101)
    is("b0101".U) {
      result := io.alu_in1 << io.alu_in2(4, 0) // Use low 5 bits of alu_in2
    }
    // Case SRL (Shift Right Logical, 0110)
    is("b0110".U) {
      result := io.alu_in1 >> io.alu_in2(4, 0) // Use low 5 bits of alu_in2
    }
    // Case SRA (Shift Right Arithmetic, 0111)
    is("b0111".U) {
      result := (io.alu_in1.asSInt >> io.alu_in2(4, 0)).asUInt // Convert alu_in1 to SInt, perform arithmetic shift, return UInt
    }
    // Case SLT (Set Less Than, signed, 1000)
    is("b1000".U) {
      result := Mux(io.alu_in1.asSInt < io.alu_in2.asSInt, 1.U, 0.U)
    }
    // Case SLTU (Set Less Than, unsigned, 1001)
    is("b1001".U) {
      result := Mux(io.alu_in1 < io.alu_in2, 1.U, 0.U)
    }
  }

  // Task 6: Connect the computed result to the output port
  io.alu_result := result
}

// Generate the Verilog code for the dut
/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
