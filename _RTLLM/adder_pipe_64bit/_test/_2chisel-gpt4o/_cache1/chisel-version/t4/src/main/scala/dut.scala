
import chisel3._
import chisel3.util._

class AdderStage extends Module {
  val io = IO(new Bundle {
    val en    = Input(Bool())
    val a     = Input(UInt(16.W))
    val b     = Input(UInt(16.W))
    val cin   = Input(Bool())
    val sum   = Output(UInt(16.W))
    val cout  = Output(Bool())
    val o_en  = Output(Bool())
  })

  val fullAdder = a +& b + cin
  io.sum := fullAdder(15, 0)
  io.cout := fullAdder(16)
  io.o_en := RegNext(io.en)

  when(!io.en) {
    io.sum := 0.U
    io.cout := false.B
  }
}

class dut extends Module {
  val io = IO(new Bundle {
    val i_en  = Input(Bool())
    val adda  = Input(UInt(64.W))
    val addb  = Input(UInt(64.W))
    val result = Output(UInt(65.W))
    val o_en   = Output(Bool())
  })

  // Split inputs into 16-bit chunks
  val inputA = VecInit(Seq.tabulate(4)(i => io.adda(16 * (i + 1) - 1, 16 * i)))
  val inputB = VecInit(Seq.tabulate(4)(i => io.addb(16 * (i + 1) - 1, 16 * i)))
  val carries = Wire(Vec(5, Bool()))
  carries(0) := false.B

  val pipelineStages = Seq.fill(4)(Module(new AdderStage))

  for(i <- 0 until 4) {
    pipelineStages(i).io.en := io.i_en || (i > 0 && pipelineStages(i - 1).io.o_en)
    pipelineStages(i).io.a := inputA(i)
    pipelineStages(i).io.b := inputB(i)
    pipelineStages(i).io.cin := carries(i)
    carries(i + 1) := pipelineStages(i).io.cout
  }

  // Concatenate the sums from all stages
  io.result := Cat(carries(4), pipelineStages(3).io.sum, pipelineStages(2).io.sum, pipelineStages(1).io.sum, pipelineStages(0).io.sum)
  
  // Output enable signal is the final stage's enable
  io.o_en := pipelineStages(3).io.o_en
}
