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

  // Pipeline registers for stage enable and partial sum/carry
  val stageEnables = RegInit(VecInit(Seq.fill(4)(false.B)))
  val sumStage = RegInit(VecInit(Seq.fill(4)(0.U(17.W)))) // 16 bits sum + carry
  val carryStage = RegInit(VecInit(Seq.fill(4)(0.U(1.W))))

  // Updating stage enables
  when(reset.asBool) {
    stageEnables.foreach(_ := false.B)
  }.otherwise {
    stageEnables(0) := io.i_en
    for (i <- 1 until 4) {
      stageEnables(i) := stageEnables(i - 1)
    }
  }

  // Divide input into 4 parts of 16 bits and process each stage
  val partsA = io.adda.asTypeOf(Vec(4, UInt(16.W)))
  val partsB = io.addb.asTypeOf(Vec(4, UInt(16.W)))

  // Carry propagation (initial carry is 0)
  val carryIn = RegInit(0.U(1.W))
  val carryOut = Wire(Vec(4, UInt(1.W)))

  // Adder pipeline stages
  for (i <- 0 until 4) {
    when(stageEnables(i)) {
      val fullAdderResult = partsA(i) + partsB(i) + carryIn
      sumStage(i) := fullAdderResult
      carryOut(i) := fullAdderResult(16) // MSB as carry to the next stage
    }
    // Carry for the next stage
    if (i < 3) {
      carryIn := carryOut(i)
    }
  }

  // Aggregate final result from all stages
  io.result := Cat(carryOut(3), sumStage(3)(15, 0), sumStage(2)(15, 0), sumStage(1)(15, 0), sumStage(0)(15, 0))
  io.o_en := stageEnables(3)
}

