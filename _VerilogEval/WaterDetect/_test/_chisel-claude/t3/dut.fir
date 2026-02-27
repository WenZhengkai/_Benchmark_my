circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, flip reset : UInt<1>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    reg currentState : UInt<2>, clock with :
      reset => (reset, UInt<2>("h3")) @[dut.scala 18:29]
    reg previousState : UInt<2>, clock with :
      reset => (reset, UInt<2>("h3")) @[dut.scala 21:30]
    reg REG : UInt, clock with :
      reset => (UInt<1>("h0"), REG) @[dut.scala 24:32]
    REG <= currentState @[dut.scala 24:32]
    node _T = neq(currentState, REG) @[dut.scala 24:21]
    when _T : @[dut.scala 24:48]
      reg previousState_REG : UInt, clock with :
        reset => (UInt<1>("h0"), previousState_REG) @[dut.scala 25:29]
      previousState_REG <= currentState @[dut.scala 25:29]
      previousState <= previousState_REG @[dut.scala 25:19]
    wire newState : UInt<2> @[dut.scala 29:22]
    node _T_1 = bits(io.s, 2, 2) @[dut.scala 30:12]
    node _T_2 = bits(io.s, 1, 1) @[dut.scala 30:23]
    node _T_3 = and(_T_1, _T_2) @[dut.scala 30:16]
    node _T_4 = bits(io.s, 0, 0) @[dut.scala 30:34]
    node _T_5 = and(_T_3, _T_4) @[dut.scala 30:27]
    when _T_5 : @[dut.scala 30:39]
      newState <= UInt<2>("h0") @[dut.scala 31:14]
    else :
      node _T_6 = bits(io.s, 1, 1) @[dut.scala 32:18]
      node _T_7 = bits(io.s, 0, 0) @[dut.scala 32:29]
      node _T_8 = and(_T_6, _T_7) @[dut.scala 32:22]
      node _T_9 = bits(io.s, 2, 2) @[dut.scala 32:41]
      node _T_10 = eq(_T_9, UInt<1>("h0")) @[dut.scala 32:36]
      node _T_11 = and(_T_8, _T_10) @[dut.scala 32:33]
      when _T_11 : @[dut.scala 32:46]
        newState <= UInt<2>("h1") @[dut.scala 33:14]
      else :
        node _T_12 = bits(io.s, 0, 0) @[dut.scala 34:18]
        node _T_13 = bits(io.s, 1, 1) @[dut.scala 34:30]
        node _T_14 = eq(_T_13, UInt<1>("h0")) @[dut.scala 34:25]
        node _T_15 = and(_T_12, _T_14) @[dut.scala 34:22]
        node _T_16 = bits(io.s, 2, 2) @[dut.scala 34:42]
        node _T_17 = eq(_T_16, UInt<1>("h0")) @[dut.scala 34:37]
        node _T_18 = and(_T_15, _T_17) @[dut.scala 34:34]
        when _T_18 : @[dut.scala 34:47]
          newState <= UInt<2>("h2") @[dut.scala 35:14]
        else :
          newState <= UInt<2>("h3") @[dut.scala 37:14]
    when io.reset : @[dut.scala 41:18]
      currentState <= UInt<2>("h3") @[dut.scala 42:18]
      previousState <= UInt<2>("h3") @[dut.scala 43:19]
    else :
      currentState <= newState @[dut.scala 45:18]
    wire wasRising : UInt<1> @[dut.scala 49:23]
    node _wasRising_T = lt(previousState, currentState) @[dut.scala 50:31]
    wasRising <= _wasRising_T @[dut.scala 50:13]
    io.fr1 <= UInt<1>("h0") @[dut.scala 54:10]
    io.fr2 <= UInt<1>("h0") @[dut.scala 55:10]
    io.fr3 <= UInt<1>("h0") @[dut.scala 56:10]
    io.dfr <= UInt<1>("h0") @[dut.scala 57:10]
    when io.reset : @[dut.scala 59:18]
      io.fr1 <= UInt<1>("h1") @[dut.scala 61:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 62:12]
      io.fr3 <= UInt<1>("h1") @[dut.scala 63:12]
      io.dfr <= UInt<1>("h1") @[dut.scala 64:12]
    else :
      node _T_19 = eq(UInt<2>("h0"), currentState) @[dut.scala 66:26]
      when _T_19 : @[dut.scala 66:26]
        skip
      else :
        node _T_20 = eq(UInt<2>("h1"), currentState) @[dut.scala 66:26]
        when _T_20 : @[dut.scala 66:26]
          io.fr1 <= UInt<1>("h1") @[dut.scala 71:16]
          io.dfr <= wasRising @[dut.scala 72:16]
        else :
          node _T_21 = eq(UInt<2>("h2"), currentState) @[dut.scala 66:26]
          when _T_21 : @[dut.scala 66:26]
            io.fr1 <= UInt<1>("h1") @[dut.scala 75:16]
            io.fr2 <= UInt<1>("h1") @[dut.scala 76:16]
            io.dfr <= wasRising @[dut.scala 77:16]
          else :
            node _T_22 = eq(UInt<2>("h3"), currentState) @[dut.scala 66:26]
            when _T_22 : @[dut.scala 66:26]
              io.fr1 <= UInt<1>("h1") @[dut.scala 80:16]
              io.fr2 <= UInt<1>("h1") @[dut.scala 81:16]
              io.fr3 <= UInt<1>("h1") @[dut.scala 82:16]
              io.dfr <= wasRising @[dut.scala 83:16]


