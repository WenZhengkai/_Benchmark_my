circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, flip reset : UInt<1>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>}

    reg state : UInt<3>, clock with :
      reset => (reset, UInt<3>("h1")) @[dut.scala 16:22]
    reg prevSensors : UInt<3>, clock with :
      reset => (reset, UInt<3>("h0")) @[dut.scala 19:28]
    io.fr1 <= UInt<1>("h0") @[dut.scala 22:10]
    io.fr2 <= UInt<1>("h0") @[dut.scala 23:10]
    io.fr3 <= UInt<1>("h0") @[dut.scala 24:10]
    io.dfr <= UInt<1>("h0") @[dut.scala 25:10]
    node s1 = bits(io.s, 0, 0) @[dut.scala 28:16]
    node s2 = bits(io.s, 1, 1) @[dut.scala 29:16]
    node s3 = bits(io.s, 2, 2) @[dut.scala 30:16]
    wire waterLevel : UInt<3> @[dut.scala 33:24]
    node _T = and(s1, s2) @[dut.scala 34:11]
    node _T_1 = and(_T, s3) @[dut.scala 34:17]
    when _T_1 : @[dut.scala 34:24]
      waterLevel <= UInt<2>("h3") @[dut.scala 35:16]
    else :
      node _T_2 = and(s1, s2) @[dut.scala 36:17]
      node _T_3 = eq(s3, UInt<1>("h0")) @[dut.scala 36:26]
      node _T_4 = and(_T_2, _T_3) @[dut.scala 36:23]
      when _T_4 : @[dut.scala 36:31]
        waterLevel <= UInt<2>("h2") @[dut.scala 37:16]
      else :
        node _T_5 = eq(s2, UInt<1>("h0")) @[dut.scala 38:20]
        node _T_6 = and(s1, _T_5) @[dut.scala 38:17]
        node _T_7 = eq(s3, UInt<1>("h0")) @[dut.scala 38:27]
        node _T_8 = and(_T_6, _T_7) @[dut.scala 38:24]
        when _T_8 : @[dut.scala 38:32]
          waterLevel <= UInt<1>("h1") @[dut.scala 39:16]
        else :
          waterLevel <= UInt<1>("h0") @[dut.scala 41:16]
    node isRising = gt(waterLevel, prevSensors) @[dut.scala 45:29]
    when io.reset : @[dut.scala 48:18]
      state <= UInt<3>("h1") @[dut.scala 50:11]
      prevSensors <= UInt<1>("h0") @[dut.scala 51:17]
      io.fr1 <= UInt<1>("h1") @[dut.scala 52:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 53:12]
      io.fr3 <= UInt<1>("h1") @[dut.scala 54:12]
      io.dfr <= UInt<1>("h1") @[dut.scala 55:12]
    else :
      prevSensors <= io.s @[dut.scala 58:17]
      node _T_9 = eq(UInt<1>("h0"), waterLevel) @[dut.scala 61:24]
      when _T_9 : @[dut.scala 61:24]
        state <= UInt<3>("h1") @[dut.scala 62:23]
      else :
        node _T_10 = eq(UInt<1>("h1"), waterLevel) @[dut.scala 61:24]
        when _T_10 : @[dut.scala 61:24]
          state <= UInt<3>("h2") @[dut.scala 63:23]
        else :
          node _T_11 = eq(UInt<2>("h2"), waterLevel) @[dut.scala 61:24]
          when _T_11 : @[dut.scala 61:24]
            state <= UInt<3>("h3") @[dut.scala 64:23]
          else :
            node _T_12 = eq(UInt<2>("h3"), waterLevel) @[dut.scala 61:24]
            when _T_12 : @[dut.scala 61:24]
              state <= UInt<3>("h4") @[dut.scala 65:23]
      node _T_13 = eq(UInt<3>("h1"), state) @[dut.scala 69:19]
      when _T_13 : @[dut.scala 69:19]
        io.fr1 <= UInt<1>("h1") @[dut.scala 72:16]
        io.fr2 <= UInt<1>("h1") @[dut.scala 73:16]
        io.fr3 <= UInt<1>("h1") @[dut.scala 74:16]
      else :
        node _T_14 = eq(UInt<3>("h2"), state) @[dut.scala 69:19]
        when _T_14 : @[dut.scala 69:19]
          io.fr1 <= UInt<1>("h1") @[dut.scala 78:16]
          io.fr2 <= UInt<1>("h1") @[dut.scala 79:16]
          io.fr3 <= UInt<1>("h0") @[dut.scala 80:16]
        else :
          node _T_15 = eq(UInt<3>("h3"), state) @[dut.scala 69:19]
          when _T_15 : @[dut.scala 69:19]
            io.fr1 <= UInt<1>("h1") @[dut.scala 84:16]
            io.fr2 <= UInt<1>("h0") @[dut.scala 85:16]
            io.fr3 <= UInt<1>("h0") @[dut.scala 86:16]
          else :
            node _T_16 = eq(UInt<3>("h4"), state) @[dut.scala 69:19]
            when _T_16 : @[dut.scala 69:19]
              io.fr1 <= UInt<1>("h0") @[dut.scala 90:16]
              io.fr2 <= UInt<1>("h0") @[dut.scala 91:16]
              io.fr3 <= UInt<1>("h0") @[dut.scala 92:16]
      io.dfr <= isRising @[dut.scala 97:12]


