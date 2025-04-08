import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in = Input(Bool())
    val mul_a     = Input(UInt(8.W))
    val mul_b     = Input(UInt(8.W))
    val mul_en_out = Output(Bool())
    val mul_out   = Output(UInt(16.W))
  })

  // Pipeline registers for input enable and operands
  val mul_en_out_reg = RegInit(false.B)
  val mul_a_reg      = RegInit(0.U(8.W))
  val mul_b_reg      = RegInit(0.U(8.W))

  // Pipeline stage: On the positive clock edge, sample the inputs if mul_en_in is active
  when(io.mul_en_in) {
    mul_en_out_reg := true.B
    mul_a_reg := io.mul_a
    mul_b_reg := io.mul_b
  }.otherwise {
    mul_en_out_reg := false.B
  }

  // Partial product wires and registers
  val temp = Wire(Vec(8, UInt(16.W)))
  for (i <- 0 until 8) {
    temp(i) := Mux(mul_b_reg(i), (mul_a_reg << i).asUInt, 0.U)
  }

  // Sum the partial products
  val sum_reg1 = RegInit(0.U(16.W))
  val sum_reg2 = RegInit(0.U(16.W))
  val sum_reg3 = RegInit(0.U(16.W))
  val sum_reg4 = RegInit(0.U(16.W))

  sum_reg1 := temp(0) + temp(1)
  sum_reg2 := temp(2) + temp(3)
  sum_reg3 := temp(4) + temp(5)
  sum_reg4 := temp(6) + temp(7)

  val final_sum_reg = RegInit(0.U(16.W))
  final_sum_reg := sum_reg1 + sum_reg2 + sum_reg3 + sum_reg4

  // Output assignment
  io.mul_en_out := mul_en_out_reg
  io.mul_out := Mux(mul_en_out_reg, final_sum_reg, 0.U)
}


