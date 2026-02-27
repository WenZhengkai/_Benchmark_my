import chisel3._

class dut extends Module {
  val io = IO(new Bundle {
    val alu_in1 = Input(UInt(32.W))  // First input operand
    val alu_in2 = Input(UInt(32.W))  // Second input operand
    val aluop = Input(UInt(4.W))     // dut operation selector
    val zero = Output(UInt(1.W))     // Zero flag (whether alu_in1 == alu_in2)
    val alu_result = Output(UInt(32.W))  // dut computation result
  })

  // Task 1: Generate the zero flag
  io.zero := (io.alu_in1 === io.alu_in2).asUInt

  // Task 2: Declare result wire and handle ADD/SUB operations
  val result = Wire(UInt(32.W))  // Placeholder for dut result
  result := 0.U                 // Initialize result with default value

  // Perform dut operations based on aluop value
  switch(io.aluop) {
    // ADD (aluop = 0000)
    is("b0000".U) { result := io.alu_in1 + io.alu_in2 }

    // SUB (aluop = 0001)
    is("b0001".U) { result := io.alu_in1 - io.alu_in2 }

    // Task 3: Bitwise operations (XOR, OR, AND)
    // XOR (aluop = 0010)
    is("b0010".U) { result := io.alu_in1 ^ io.alu_in2 }

    // OR (aluop = 0011)
    is("b0011".U) { result := io.alu_in1 | io.alu_in2 }

    // AND (aluop = 0100)
    is("b0100".U) { result := io.alu_in1 & io.alu_in2 }

    // Task 4: Shift operations (SLL, SRL, SRA)
    // Shift Left Logical (aluop = 0101)
    is("b0101".U) { result := io.alu_in1 << io.alu_in2(4, 0) }  // Use lower 5 bits of alu_in2

    // Shift Right Logical (aluop = 0110)
    is("b0110".U) { result := io.alu_in1 >> io.alu_in2(4, 0) }  // Use lower 5 bits of alu_in2

    // Shift Right Arithmetic (aluop = 0111)
    is("b0111".U) {
      result := (io.alu_in1.asSInt >> io.alu_in2(4, 0)).asUInt  // Arithmetic shift
    }

    // Task 5: Comparison operations (SLT, SLTU)
    // Set Less Than Signed (aluop = 1000)
    is("b1000".U) {
      result := Mux(io.alu_in1.asSInt < io.alu_in2.asSInt, 1.U, 0.U)
    }

    // Set Less Than Unsigned (aluop = 1001)
    is("b1001".U) {
      result := Mux(io.alu_in1 < io.alu_in2, 1.U, 0.U)
    }
  }

  // Task 6: Assign result to the output port
  io.alu_result := result
}
