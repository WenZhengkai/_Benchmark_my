circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, flip reset : UInt<1>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    reg currentState : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 21:29]
    reg previousState : UInt, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 24:30]
    wire waterLevel : UInt<2> @[dut.scala 27:24]
    node _T = bits(io.s, 2, 2) @[dut.scala 28:12]
    node _T_1 = bits(io.s, 1, 1) @[dut.scala 28:25]
    node _T_2 = and(_T, _T_1) @[dut.scala 28:18]
    node _T_3 = bits(io.s, 0, 0) @[dut.scala 28:38]
    node _T_4 = and(_T_2, _T_3) @[dut.scala 28:31]
    when _T_4 : @[dut.scala 28:45]
      waterLevel <= UInt<2>("h3") @[dut.scala 29:16]
    else :
      node _T_5 = bits(io.s, 1, 1) @[dut.scala 30:18]
      node _T_6 = bits(io.s, 0, 0) @[dut.scala 30:31]
      node _T_7 = and(_T_5, _T_6) @[dut.scala 30:24]
      when _T_7 : @[dut.scala 30:38]
        waterLevel <= UInt<2>("h2") @[dut.scala 31:16]
      else :
        node _T_8 = bits(io.s, 0, 0) @[dut.scala 32:18]
        when _T_8 : @[dut.scala 32:25]
          waterLevel <= UInt<1>("h1") @[dut.scala 33:16]
        else :
          waterLevel <= UInt<1>("h0") @[dut.scala 35:16]
    when io.reset : @[dut.scala 39:18]
      currentState <= UInt<1>("h0") @[dut.scala 40:18]
      previousState <= UInt<1>("h0") @[dut.scala 41:19]
    else :
      node _T_9 = neq(waterLevel, currentState) @[dut.scala 42:25]
      when _T_9 : @[dut.scala 42:43]
        previousState <= currentState @[dut.scala 43:19]
        currentState <= waterLevel @[dut.scala 44:18]
    node isRising = gt(currentState, previousState) @[dut.scala 48:31]
    when io.reset : @[dut.scala 51:18]
      io.fr3 <= UInt<1>("h1") @[dut.scala 53:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 54:12]
      io.fr1 <= UInt<1>("h1") @[dut.scala 55:12]
      io.dfr <= UInt<1>("h1") @[dut.scala 56:12]
    else :
      node _io_fr3_T = eq(currentState, UInt<1>("h0")) @[dut.scala 59:28]
      io.fr3 <= _io_fr3_T @[dut.scala 59:12]
      node _io_fr2_T = eq(currentState, UInt<1>("h0")) @[dut.scala 60:28]
      node _io_fr2_T_1 = eq(currentState, UInt<1>("h1")) @[dut.scala 60:57]
      node _io_fr2_T_2 = or(_io_fr2_T, _io_fr2_T_1) @[dut.scala 60:41]
      io.fr2 <= _io_fr2_T_2 @[dut.scala 60:12]
      node _io_fr1_T = eq(currentState, UInt<1>("h0")) @[dut.scala 61:28]
      node _io_fr1_T_1 = eq(currentState, UInt<1>("h1")) @[dut.scala 61:57]
      node _io_fr1_T_2 = or(_io_fr1_T, _io_fr1_T_1) @[dut.scala 61:41]
      node _io_fr1_T_3 = eq(currentState, UInt<2>("h2")) @[dut.scala 61:91]
      node _io_fr1_T_4 = or(_io_fr1_T_2, _io_fr1_T_3) @[dut.scala 61:75]
      io.fr1 <= _io_fr1_T_4 @[dut.scala 61:12]
      io.dfr <= isRising @[dut.scala 64:12]


