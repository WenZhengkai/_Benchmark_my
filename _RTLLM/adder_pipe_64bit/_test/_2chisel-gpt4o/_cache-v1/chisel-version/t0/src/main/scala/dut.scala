import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val i_en = Input(Bool())
    val adda = Input(UInt(64.W))
    val addb = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en = Output(Bool())
  })

  // Split the 64-bit inputs into 16-bit chunks
  val adda_chunks = Wire(Vec(4, UInt(16.W)))
  val addb_chunks = Wire(Vec(4, UInt(16.W)))

  odda_chunks(0) := io.adda(15, 0)
  odda_chunks(1) := io.adda(31, 16)
  odda_chunks(2) := io.adda(47, 32)
  odda_chunks(3) := io.adda(63, 48)

  oaddb_chunks(0) := io.addb(15, 0)
  oaddb_chunks(1) := io.addb(31, 16)
  oaddb_chunks(2) := io.addb(47, 32)
  oaddb_chunks(3) := io.addb(63, 48)

  // Registers for pipeline stages
  val sum_reg = RegInit(VecInit(Seq.fill(4)(0.U(16.W))))
  val carry_reg = RegInit(VecInit(Seq.fill(4)(false.B)))
  val en_reg = RegInit(false.B)

  // Pipeline stages calculation
  val stage_sums = Wire(Vec(4, UInt(16.W)))
  val stage_carries = Wire(Vec(4, Bool()))

  stage_sums(0) := adda_chunks(0) + addb_chunks(0)
  stage_carries(0) := stage_sums(0)(16) // Extract carry bit

  for (i <- 1 to 3) {
    stage_sums(i) := adda_chunks(i) + addb_chunks(i) + stage_carries(i-1)
    stage_carries(i) := stage_sums(i)(16) // Extract carry bit
  }

  // Pipeline control
  when(io.i_en) {
    sum_reg := stage_sums
    carry_reg := stage_carries
    en_reg := true.B
  }

  // Output assignment
  io.result := Cat(carry_reg(3), sum_reg.asUInt)
  io.o_en := en_reg
}

