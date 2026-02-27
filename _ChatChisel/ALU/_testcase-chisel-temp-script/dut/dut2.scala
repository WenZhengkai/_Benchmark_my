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

  // Task 2: Declare the result wire
  val result = WireDefault(0.U(32.W))

  // Task 3, 4, 5: Handle all dut operations using a switch
  switch(io.aluop) {
    // ADD
    is("b0000".U) { result := io.alu_in1 + io.alu_in2 } 
    
    // SUB
    is("b0001".U) { result := io.alu_in1 - io.alu_in2 } 
    
    // XOR
    is("b0010".U) { result := io.alu_in1 ^ io.alu_in2 } 
    
    // OR
    is("b0011".U) { result := io.alu_in1 | io.alu_in2 } 
    
    // AND
    is("b0100".U) { result := io.alu_in1 & io.alu_in2 } 
    
    // Shift Left Logical
    is("b0101".U) { result := io.alu_in1 << io.alu_in2(4, 0) } 
    
    // Shift Right Logical
    is("b0110".U) { result := io.alu_in1 >> io.alu_in2(4, 0) } 
    
    // Shift Right Arithmetic
    is("b0111".U) { result := (io.alu_in1.asSInt >> io.alu_in2(4, 0)).asUInt } 
    
    // Set Less Than
    is("b1000".U) {
      result := Mux(io.alu_in1.asSInt < io.alu_in2.asSInt, 1.U, 0.U)
    }
    
    // Set Less Than Unsigned
    is("b1001".U) {
      result := Mux(io.alu_in1 < io.alu_in2, 1.U, 0.U)
    }
  }

  // Task 6: Connect the result to the output port
  io.alu_result := result
}
