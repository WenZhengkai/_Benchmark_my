import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val alu_in1 = Input(UInt(32.W))
    val alu_in2 = Input(UInt(32.W))
    val aluop   = Input(UInt(4.W))
    val zero    = Output(UInt(1.W))
    val alu_result = Output(UInt(32.W))
  })

  // Task 1: Implement the `zero` flag
  io.zero := (io.alu_in1 === io.alu_in2).asUInt

  // Task 2: Declare the result wire
  val result = Wire(UInt(32.W))
  result := 0.U // Initialize the result wire
  
  // Task 2-5: Implement dut operations using a switch on `aluop`
  switch(io.aluop) {
    // Task 2: ADD and SUB operations
    is("b0000".U) { result := io.alu_in1 + io.alu_in2 } // ADD
    is("b0001".U) { result := io.alu_in1 - io.alu_in2 } // SUB
    
    // Task 3: Bitwise operations (XOR, OR, AND)
    is("b0010".U) { result := io.alu_in1 ^ io.alu_in2 } // XOR
    is("b0011".U) { result := io.alu_in1 | io.alu_in2 } // OR
    is("b0100".U) { result := io.alu_in1 & io.alu_in2 } // AND
    
    // Task 4: Shift operations (SLL, SRL, SRA)
    is("b0101".U) { result := io.alu_in1 << io.alu_in2(4, 0) } // SLL (Shift Left Logical)
    is("b0110".U) { result := io.alu_in1 >> io.alu_in2(4, 0) } // SRL (Shift Right Logical)
    is("b0111".U) { result := (io.alu_in1.asSInt >> io.alu_in2(4, 0)).asUInt } // SRA (Arithmetic Right Shift)
    
    // Task 5: Comparison operations (SLT, SLTU)
    is("b1000".U) { 
      result := Mux(io.alu_in1.asSInt < io.alu_in2.asSInt, 1.U, 0.U) // SLT (Set Less Than, signed)
    }
    is("b1001".U) { 
      result := Mux(io.alu_in1 < io.alu_in2, 1.U, 0.U) // SLTU (Set Less Than, unsigned)
    }
  }
  
  // Task 6: Connect the result to the output port
  io.alu_result := result
}

/*
object dut extends App {
  chisel3.Driver.execute(args, () => new dut)
}
*/
