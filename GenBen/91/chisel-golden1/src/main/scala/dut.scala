import chisel3._
import chisel3.util._

class RefFpuExceptionsIO extends Bundle {

  val enable          = Input(Bool())
  val rmode           = Input(UInt(2.W))
  val opa             = Input(UInt(64.W))
  val opb             = Input(UInt(64.W))
  val in_except       = Input(UInt(64.W))
  val exponent_in     = Input(UInt(12.W))
  val mantissa_in     = Input(UInt(2.W))
  val fpu_op          = Input(UInt(3.W))
  val ref_out         = Output(UInt(64.W))
  val ref_ex_enable   = Output(Bool())
  val ref_underflow   = Output(Bool())
  val ref_overflow    = Output(Bool())
  val ref_inexact     = Output(Bool())
  val ref_exception   = Output(Bool())
  val ref_invalid     = Output(Bool())
}

class dut extends Module {
  val io = IO(new RefFpuExceptionsIO)

  // === Constants ===
  val exp_2047 = "b11111111111".U(11.W)
  val exp_2046 = "b11111111110".U(11.W)
  val mantissa_max = "hFFFFFFFFFFFFF".U(52.W)

  // === Registers ===
  val in_et_zero           = RegInit(false.B)
  val opa_et_zero          = RegInit(false.B)
  val opb_et_zero          = RegInit(false.B)
  val input_et_zero        = RegInit(false.B)
  val add                  = RegInit(false.B)
  val subtract             = RegInit(false.B)
  val multiply             = RegInit(false.B)
  val divide               = RegInit(false.B)
  val opa_QNaN             = RegInit(false.B)
  val opb_QNaN             = RegInit(false.B)
  val opa_SNaN             = RegInit(false.B)
  val opb_SNaN             = RegInit(false.B)
  val opa_pos_inf          = RegInit(false.B)
  val opb_pos_inf          = RegInit(false.B)
  val opa_neg_inf          = RegInit(false.B)
  val opb_neg_inf          = RegInit(false.B)
  val opa_inf              = RegInit(false.B)
  val opb_inf              = RegInit(false.B)
  val NaN_input            = RegInit(false.B)
  val SNaN_input           = RegInit(false.B)
  val a_NaN                = RegInit(false.B)
  val div_by_0             = RegInit(false.B)
  val div_0_by_0           = RegInit(false.B)
  val div_inf_by_inf       = RegInit(false.B)
  val div_by_inf           = RegInit(false.B)
  val mul_0_by_inf         = RegInit(false.B)
  val mul_inf              = RegInit(false.B)
  val div_inf              = RegInit(false.B)
  val add_inf              = RegInit(false.B)
  val sub_inf              = RegInit(false.B)
  val addsub_inf_invalid   = RegInit(false.B)
  val addsub_inf           = RegInit(false.B)
  val out_inf_trigger      = RegInit(false.B)
  val out_pos_inf          = RegInit(false.B)
  val out_neg_inf          = RegInit(false.B)
  val round_nearest        = RegInit(false.B)
  val round_to_zero        = RegInit(false.B)
  val round_to_pos_inf     = RegInit(false.B)
  val round_to_neg_inf     = RegInit(false.B)
  val inf_round_down_trigger = RegInit(false.B)
  val mul_uf               = RegInit(false.B)
  val div_uf               = RegInit(false.B)
  val underflow_trigger    = RegInit(false.B)
  val invalid_trigger      = RegInit(false.B)
  val overflow_trigger     = RegInit(false.B)
  val inexact_trigger      = RegInit(false.B)
  val except_trigger       = RegInit(false.B)
  val enable_trigger       = RegInit(false.B)
  val NaN_out_trigger      = RegInit(false.B)
  val SNaN_trigger         = RegInit(false.B)
  val NaN_output_0         = RegInit(0.U(63.W))
  val NaN_output           = RegInit(0.U(63.W))
  val inf_round_down       = RegInit(0.U(63.W))
  val out_inf              = RegInit(0.U(63.W))
  val out_0                = RegInit(0.U(64.W))
  val out_1                = RegInit(0.U(64.W))
  val out_2                = RegInit(0.U(64.W))

  // Output registers
  val ref_ex_enable        = RegInit(false.B)
  val ref_underflow        = RegInit(false.B)
  val ref_overflow         = RegInit(false.B)
  val ref_inexact          = RegInit(false.B)
  val ref_exception        = RegInit(false.B)
  val ref_invalid          = RegInit(false.B)
  val ref_out              = RegInit(0.U(64.W))

  // === Synchronous logic ===
  // First always block
  when (reset.asBool) {
    in_et_zero           := false.B
    opa_et_zero          := false.B
    opb_et_zero          := false.B
    input_et_zero        := false.B
    add                  := false.B
    subtract             := false.B
    multiply             := false.B
    divide               := false.B
    opa_QNaN             := false.B
    opb_QNaN             := false.B
    opa_SNaN             := false.B
    opb_SNaN             := false.B
    opa_pos_inf          := false.B
    opb_pos_inf          := false.B
    opa_neg_inf          := false.B
    opb_neg_inf          := false.B
    opa_inf              := false.B
    opb_inf              := false.B
    NaN_input            := false.B
    SNaN_input           := false.B
    a_NaN                := false.B
    div_by_0             := false.B
    div_0_by_0           := false.B
    div_inf_by_inf       := false.B
    div_by_inf           := false.B
    mul_0_by_inf         := false.B
    mul_inf              := false.B
    div_inf              := false.B
    add_inf              := false.B
    sub_inf              := false.B
    addsub_inf_invalid   := false.B
    addsub_inf           := false.B
    out_inf_trigger      := false.B
    out_pos_inf          := false.B
    out_neg_inf          := false.B
    round_nearest        := false.B
    round_to_zero        := false.B
    round_to_pos_inf     := false.B
    round_to_neg_inf     := false.B
    inf_round_down_trigger := false.B
    mul_uf               := false.B
    div_uf               := false.B
    underflow_trigger    := false.B
    invalid_trigger      := false.B
    overflow_trigger     := false.B
    inexact_trigger      := false.B
    except_trigger       := false.B
    enable_trigger       := false.B
    NaN_out_trigger      := false.B
    SNaN_trigger         := false.B
    NaN_output_0         := 0.U
    NaN_output           := 0.U
    inf_round_down       := 0.U
    out_inf              := 0.U
    out_0                := 0.U
    out_1                := 0.U
    out_2                := 0.U
  } .elsewhen (io.enable) {
    // Zero detection
    in_et_zero    := !(io.in_except(62,0).orR)
    opa_et_zero   := !(io.opa(62,0).orR)
    opb_et_zero   := !(io.opb(62,0).orR)
    input_et_zero := !(io.in_except(62,0).orR)
    // FPU op-code
    add      := io.fpu_op === "b000".U
    subtract := io.fpu_op === "b001".U
    multiply := io.fpu_op === "b010".U
    divide   := io.fpu_op === "b011".U
    // QNaN and SNaN detection
    opa_QNaN := (io.opa(62,52) === exp_2047) && io.opa(51,0).orR && io.opa(51)
    opb_QNaN := (io.opb(62,52) === exp_2047) && io.opb(51,0).orR && io.opb(51)
    opa_SNaN := (io.opa(62,52) === exp_2047) && io.opa(51,0).orR && !io.opa(51)
    opb_SNaN := (io.opb(62,52) === exp_2047) && io.opb(51,0).orR && !io.opb(51)
    // Infinity detection
    opa_pos_inf := !io.opa(63) && (io.opa(62,52) === exp_2047) && !io.opa(51,0).orR
    opb_pos_inf := !io.opb(63) && (io.opb(62,52) === exp_2047) && !io.opb(51,0).orR
    opa_neg_inf := io.opa(63) && (io.opa(62,52) === exp_2047) && !io.opa(51,0).orR
    opb_neg_inf := io.opb(63) && (io.opb(62,52) === exp_2047) && !io.opb(51,0).orR
    opa_inf := (io.opa(62,52) === exp_2047) && !io.opa(51,0).orR
    opb_inf := (io.opb(62,52) === exp_2047) && !io.opb(51,0).orR
    // NaN detection
    NaN_input := opa_QNaN || opb_QNaN || opa_SNaN || opb_SNaN
    SNaN_input := opa_SNaN || opb_SNaN
    a_NaN := opa_QNaN || opa_SNaN
    // Special operation detection
    div_by_0         := divide && opb_et_zero && !opa_et_zero
    div_0_by_0       := divide && opb_et_zero && opa_et_zero
    div_inf_by_inf   := divide && opa_inf && opb_inf
    div_by_inf       := divide && !opa_inf && opb_inf
    mul_0_by_inf     := multiply && ((opa_inf && opb_et_zero) || (opa_et_zero && opb_inf))
    mul_inf          := multiply && (opa_inf || opb_inf) && !mul_0_by_inf
    div_inf          := divide && opa_inf && !opb_inf
    add_inf          := add && (opa_inf || opb_inf)
    sub_inf          := subtract && (opa_inf || opb_inf)
    addsub_inf_invalid := (add && opa_pos_inf && opb_neg_inf) || (add && opa_neg_inf && opb_pos_inf) ||
                          (subtract && opa_pos_inf && opb_pos_inf) || (subtract && opa_neg_inf && opb_neg_inf)
    addsub_inf := (add_inf || sub_inf) && !addsub_inf_invalid
    out_inf_trigger := addsub_inf || mul_inf || div_inf || div_by_0 || (io.exponent_in > exp_2046)
    out_pos_inf := out_inf_trigger && !io.in_except(63)
    out_neg_inf := out_inf_trigger && io.in_except(63)
    // Rounding modes
    round_nearest    := io.rmode === "b00".U
    round_to_zero    := io.rmode === "b01".U
    round_to_pos_inf := io.rmode === "b10".U
    round_to_neg_inf := io.rmode === "b11".U
    inf_round_down_trigger := (out_pos_inf && round_to_neg_inf) ||
                             (out_neg_inf && round_to_pos_inf) ||
                             (out_inf_trigger && round_to_zero)
    // Underflow triggers
    mul_uf := multiply && !opa_et_zero && !opb_et_zero && in_et_zero
    div_uf := divide && !opa_et_zero && in_et_zero
    underflow_trigger := div_by_inf || mul_uf || div_uf
    // Exception triggers
    invalid_trigger := SNaN_input || addsub_inf_invalid || mul_0_by_inf ||
                       div_0_by_0 || div_inf_by_inf
    overflow_trigger := out_inf_trigger && !NaN_input
    inexact_trigger := (io.mantissa_in.orR || out_inf_trigger || underflow_trigger) && !NaN_input
    except_trigger := invalid_trigger || overflow_trigger || underflow_trigger || inexact_trigger
    enable_trigger := except_trigger || out_inf_trigger || NaN_input
    NaN_out_trigger := NaN_input || invalid_trigger
    SNaN_trigger := invalid_trigger && !SNaN_input
    // NaN output encoding
    NaN_output_0 := Mux(a_NaN, Cat(exp_2047, 1.U(1.W), io.opa(50,0)), Cat(exp_2047, 1.U(1.W), io.opb(50,0)))
    NaN_output := Mux(SNaN_trigger, Cat(exp_2047, "b01".U(2.W), io.opa(49,0)), NaN_output_0)
    inf_round_down := Cat(exp_2046, mantissa_max)
    out_inf := Mux(inf_round_down_trigger, inf_round_down, Cat(exp_2047, 0.U(52.W)))
    // Output path
    out_0 := Mux(underflow_trigger, Cat(io.in_except(63), 0.U(63.W)), io.in_except)
    out_1 := Mux(out_inf_trigger, Cat(io.in_except(63), out_inf), out_0)
    out_2 := Mux(NaN_out_trigger, Cat(io.in_except(63), NaN_output), out_1)
  }

  // Second always block (outputs)
  when (reset.asBool) {
    ref_ex_enable := false.B
    ref_underflow := false.B
    ref_overflow  := false.B
    ref_inexact   := false.B
    ref_exception := false.B
    ref_invalid   := false.B
    ref_out       := 0.U
  } .elsewhen (io.enable) {
    ref_ex_enable := enable_trigger
    ref_underflow := underflow_trigger
    ref_overflow  := overflow_trigger
    ref_inexact   := inexact_trigger
    ref_exception := except_trigger
    ref_invalid   := invalid_trigger
    ref_out       := out_2
  }

  // === IO Connections ===
  io.ref_ex_enable := ref_ex_enable
  io.ref_underflow := ref_underflow
  io.ref_overflow  := ref_overflow
  io.ref_inexact   := ref_inexact
  io.ref_exception := ref_exception
  io.ref_invalid   := ref_invalid
  io.ref_out       := ref_out
}