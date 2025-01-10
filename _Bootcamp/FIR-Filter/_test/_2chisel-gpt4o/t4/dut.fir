circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip in : UInt<12>, out : UInt<27>}

    wire _delayLine_WIRE : UInt<12>[7] @[dut.scala 15:34]
    _delayLine_WIRE[0] <= UInt<12>("h0") @[dut.scala 15:34]
    _delayLine_WIRE[1] <= UInt<12>("h0") @[dut.scala 15:34]
    _delayLine_WIRE[2] <= UInt<12>("h0") @[dut.scala 15:34]
    _delayLine_WIRE[3] <= UInt<12>("h0") @[dut.scala 15:34]
    _delayLine_WIRE[4] <= UInt<12>("h0") @[dut.scala 15:34]
    _delayLine_WIRE[5] <= UInt<12>("h0") @[dut.scala 15:34]
    _delayLine_WIRE[6] <= UInt<12>("h0") @[dut.scala 15:34]
    reg delayLine : UInt<12>[7], clock with :
      reset => (reset, _delayLine_WIRE) @[dut.scala 15:26]
    wire _WIRE : UInt<12>[7] @[dut.scala 18:23]
    _WIRE[0] <= io.in @[dut.scala 18:23]
    _WIRE[1] <= delayLine[0] @[dut.scala 18:23]
    _WIRE[2] <= delayLine[1] @[dut.scala 18:23]
    _WIRE[3] <= delayLine[2] @[dut.scala 18:23]
    _WIRE[4] <= delayLine[3] @[dut.scala 18:23]
    _WIRE[5] <= delayLine[4] @[dut.scala 18:23]
    _WIRE[6] <= delayLine[5] @[dut.scala 18:23]
    delayLine <= _WIRE @[dut.scala 18:13]
    node mults_0 = mul(delayLine[0], UInt<1>("h0")) @[dut.scala 22:12]
    node mults_1 = mul(delayLine[1], UInt<11>("h555")) @[dut.scala 22:12]
    node mults_2 = mul(delayLine[2], UInt<12>("haab")) @[dut.scala 22:12]
    node mults_3 = mul(delayLine[3], UInt<13>("h1000")) @[dut.scala 22:12]
    node mults_4 = mul(delayLine[4], UInt<12>("haab")) @[dut.scala 22:12]
    node mults_5 = mul(delayLine[5], UInt<11>("h555")) @[dut.scala 22:12]
    node mults_6 = mul(delayLine[6], UInt<1>("h0")) @[dut.scala 22:12]
    node _sum_T = add(mults_0, mults_1) @[dut.scala 26:28]
    node _sum_T_1 = add(_sum_T, mults_2) @[dut.scala 26:28]
    node _sum_T_2 = add(_sum_T_1, mults_3) @[dut.scala 26:28]
    node _sum_T_3 = add(_sum_T_2, mults_4) @[dut.scala 26:28]
    node _sum_T_4 = add(_sum_T_3, mults_5) @[dut.scala 26:28]
    node sum = add(_sum_T_4, mults_6) @[dut.scala 26:28]
    io.out <= sum @[dut.scala 29:10]

