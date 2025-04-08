
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

  // Pipeline registers
  val pipe_en   = RegInit(VecInit(Seq.fill(4)(false.B)))
  val partialSum = RegInit(VecInit(Seq.fill(4)(0.U(17.W))))
  val carry     = RegInit(VecInit(Seq.fill(4)(0.U(1.W))))

  // Break input into 16-bit segments
  val adda_segments = VecInit(Seq.tabulate(4)(i => io.adda(16*i+15, 16*i)))
  val addb_segments = VecInit(Seq.tabulate(4)(i => io.addb(16*i+15, 16*i)))

  // First stage
  when(io.i_en) {
    val res0 = adda_segments(0) +& addb_segments(0)
    partialSum(0) := res0
    carry(0) := res0(16) // capture the carry out of the least significant add
    pipe_en(0) := io.i_en
  }

  // Subsequent stages
  for (i <- 1 until 4) {
    when(pipe_en(i-1)) {
      val res = adda_segments(i) +& addb_segments(i) +& carry(i-1)
      partialSum(i) := res
      carry(i) := res(16) // capture the carry out
      pipe_en(i) := true.B
    } .otherwise {
      pipe_en(i) := false.B
    }
  }

  // Output stage
  val result = Wire(UInt(65.W))
  result := Cat(carry(3), partialSum(3)(15,0), partialSum(2)(15,0), 
                partialSum(1)(15,0), partialSum(0)(15,0))

  io.result := result
  io.o_en := pipe_en(3)

}

