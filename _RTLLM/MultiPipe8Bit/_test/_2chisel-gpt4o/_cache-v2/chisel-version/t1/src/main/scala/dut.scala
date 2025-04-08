import chisel3._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool())  // Input enable signal
    val mul_a = Input(UInt(8.W))  // 8-bit multiplicand
    val mul_b = Input(UInt(8.W))  // 8-bit multiplier
    val mul_en_out = Output(Bool())  // Output enable signal
    val mul_out = Output(UInt(16.W))  // 16-bit product output
  })

  // Number of pipeline stages (5 in this design)
  val pipelineDepth = 5

  // Registers to store the delayed enable signal
  val mulEnReg = RegInit(VecInit(Seq.fill(pipelineDepth)(false.B)))
  mulEnReg(0) := io.mul_en_in // Update the first stage with input enable signal
  for (i <- 1 until pipelineDepth) {
    mulEnReg(i) := mulEnReg(i - 1) // Propagate enable signal through the pipeline
  }

  // Expose final enable signal as output
  io.mul_en_out := mulEnReg(pipelineDepth - 1)

  // Registers to store pipeline stages of multiplicand and multiplier
  val mulAReg = RegInit(VecInit(Seq.fill(pipelineDepth)(0.U(8.W))))
  val mulBReg = RegInit(VecInit(Seq.fill(pipelineDepth)(0.U(8.W))))
  
  // Update multiplicand and multiplier registers only when input enable is active
  when(io.mul_en_in) {
    mulAReg(0) := io.mul_a
    mulBReg(0) := io.mul_b
  }
  for (i <- 1 until pipelineDepth) {
    mulAReg(i) := mulAReg(i - 1)
    mulBReg(i) := mulBReg(i - 1)
  }

  // Wires for partial products and sums
  val partialProducts = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    partialProducts(i) := Mux(mulBReg(pipelineDepth - 1)(i), mulAReg(pipelineDepth - 1) << i, 0.U)
  }

  // Registers to store intermediate sums (pipeline stages for partial sum calculation)
  val sumReg1 = RegInit(0.U(16.W))
  val sumReg2 = RegInit(0.U(16.W))
  val sumReg3 = RegInit(0.U(16.W))
  
  // Compute partial sums in pipeline stages
  when(mulEnReg(1)) {
    sumReg1 := partialProducts(0) + partialProducts(1)
  }
  when(mulEnReg(2)) {
    sumReg2 := sumReg1 + partialProducts(2) + partialProducts(3)
  }
  when(mulEnReg(3)) {
    sumReg3 := sumReg2 + partialProducts(4) + partialProducts(5)
  }

  // Final product calculation and output
  val mulOutReg = RegInit(0.U(16.W))
  when(mulEnReg(4)) {
    mulOutReg := sumReg3 + partialProducts(6) + partialProducts(7)
  }
  
  // Assign the final product to the output port
  io.mul_out := Mux(io.mul_en_out, mulOutReg, 0.U)
}
