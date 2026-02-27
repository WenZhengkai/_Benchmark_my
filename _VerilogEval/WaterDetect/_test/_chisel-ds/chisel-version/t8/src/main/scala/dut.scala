import chisel3._
import chisel3.util._

class dut extends Module {
  val io = IO(new Bundle {
    val s = Input(UInt(3.W)) // Sensors s[3:1]
    val fr3 = Output(Bool()) // Nominal flow rate 3
    val fr2 = Output(Bool()) // Nominal flow rate 2
    val fr1 = Output(Bool()) // Nominal flow rate 1
    val dfr = Output(Bool()) // Supplemental flow valve
    val reset = Input(Bool()) // Active-high synchronous reset
  })

  // Define states for the water level
  val aboveS3 :: betweenS3S2 :: betweenS2S1 :: belowS1 :: Nil = Enum(4)

  // State register
  val stateReg = RegInit(belowS1)

  // Output registers
  val fr3Reg = RegInit(true.B)
  val fr2Reg = RegInit(true.B)
  val fr1Reg = RegInit(true.B)
  val dfrReg = RegInit(true.B)

  // Assign outputs
  io.fr3 := fr3Reg
  io.fr2 := fr2Reg
  io.fr1 := fr1Reg
  io.dfr := dfrReg

  // Reset logic
  when(io.reset) {
    stateReg := belowS1
    fr3Reg := true.B
    fr2Reg := true.B
    fr1Reg := true.B
    dfrReg := true.B
  }.otherwise {
    // State transition logic
    switch(stateReg) {
      is(aboveS3) {
        when(io.s === "b111".U) {
          stateReg := aboveS3
        }.elsewhen(io.s === "b110".U) {
          stateReg := betweenS3S2
        }.otherwise {
          stateReg := betweenS2S1
        }
      }
      is(betweenS3S2) {
        when(io.s === "b111".U) {
          stateReg := aboveS3
        }.elsewhen(io.s === "b110".U) {
          stateReg := betweenS3S2
        }.elsewhen(io.s === "b100".U) {
          stateReg := betweenS2S1
        }.otherwise {
          stateReg := belowS1
        }
      }
      is(betweenS2S1) {
        when(io.s === "b111".U) {
          stateReg := aboveS3
        }.elsewhen(io.s === "b110".U) {
          stateReg := betweenS3S2
        }.elsewhen(io.s === "b100".U) {
          stateReg := betweenS2S1
        }.otherwise {
          stateReg := belowS1
        }
      }
      is(belowS1) {
        when(io.s === "b111".U) {
          stateReg := aboveS3
        }.elsewhen(io.s === "b110".U) {
          stateReg := betweenS3S2
        }.elsewhen(io.s === "b100".U) {
          stateReg := betweenS2S1
        }.otherwise {
          stateReg := belowS1
        }
      }
    }

    // Output logic based on state
    switch(stateReg) {
      is(aboveS3) {
        fr3Reg := false.B
        fr2Reg := false.B
        fr1Reg := false.B
        dfrReg := false.B
      }
      is(betweenS3S2) {
        fr3Reg := false.B
        fr2Reg := false.B
        fr1Reg := true.B
        dfrReg := false.B
      }
      is(betweenS2S1) {
        fr3Reg := false.B
        fr2Reg := true.B
        fr1Reg := true.B
        dfrReg := false.B
      }
      is(belowS1) {
        fr3Reg := true.B
        fr2Reg := true.B
        fr1Reg := true.B
        dfrReg := true.B
      }
    }

    // Supplemental flow valve logic
    when(stateReg === betweenS3S2 || stateReg === betweenS2S1) {
      when(io.s === "b111".U || io.s === "b110".U || io.s === "b100".U) {
        dfrReg := true.B
      }.otherwise {
        dfrReg := false.B
      }
    }.otherwise {
      dfrReg := false.B
    }
  }
}

// Generate Verilog
/*
object dut extends App {
  (new chisel3.stage.ChiselStage).emitVerilog(new dut())
}
*/
