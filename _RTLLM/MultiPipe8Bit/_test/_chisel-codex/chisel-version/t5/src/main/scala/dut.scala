import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val mul_en_in  = Input(Bool())
    val mul_a      = Input(UInt(8.W))
    val mul_b      = Input(UInt(8.W))
    val mul_en_out = Output(Bool())
    val mul_out    = Output(UInt(16.W))
  })

  // 5-bit enable pipeline; MSB is output-valid.
  val mulEnOutReg = RegInit(0.U(5.W))
  mulEnOutReg := Cat(mulEnOutReg(3, 0), io.mul_en_in)
  io.mul_en_out := mulEnOutReg(4)

  // Input registers (update only when input enable is high).
  val mulAReg = RegInit(0.U(8.W))
  val mulBReg = RegInit(0.U(8.W))
  when(io.mul_en_in) {
    mulAReg := io.mul_a
    mulBReg := io.mul_b
  }

  // Partial products.
  val temp = Wire(Vec(8, UInt(16.W)))
  val aExt = Cat(0.U(8.W), mulAReg) // zero-extend to 16 bits
  for (i <- 0 until 8) {
    temp(i) := Mux(mulBReg(i), (aExt << i)(15, 0), 0.U(16.W))
  }

  // Partial sums across pipeline stages.
  val sumL = RegInit(VecInit(Seq.fill(4)(0.U(16.W)))) // level-1
  val sumM = RegInit(VecInit(Seq.fill(2)(0.U(16.W)))) // level-2
  val sumH = RegInit(0.U(16.W))                       // level-3
  val mulOutReg = RegInit(0.U(16.W))                  // final product reg

  when(mulEnOutReg(0)) {
    sumL(0) := temp(0) + temp(1)
    sumL(1) := temp(2) + temp(3)
    sumL(2) := temp(4) + temp(5)
    sumL(3) := temp(6) + temp(7)
  }

  when(mulEnOutReg(1)) {
    sumM(0) := sumL(0) + sumL(1)
    sumM(1) := sumL(2) + sumL(3)
  }

  when(mulEnOutReg(2)) {
    sumH := sumM(0) + sumM(1)
  }

  when(mulEnOutReg(3)) {
    mulOutReg := sumH
  }

  // Output product is valid only when mul_en_out is high.
  io.mul_out := Mux(io.mul_en_out, mulOutReg, 0.U(16.W))
}
