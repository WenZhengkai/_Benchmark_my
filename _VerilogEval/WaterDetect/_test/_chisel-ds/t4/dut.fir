circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip s : UInt<3>, fr3 : UInt<1>, fr2 : UInt<1>, fr1 : UInt<1>, dfr : UInt<1>, flip reset : UInt<1>}

    reg prevLevel : UInt<2>, clock with :
      reset => (reset, UInt<2>("h0")) @[dut.scala 15:26]
    when io.reset : @[dut.scala 18:18]
      io.fr3 <= UInt<1>("h1") @[dut.scala 19:12]
      io.fr2 <= UInt<1>("h1") @[dut.scala 20:12]
      io.fr1 <= UInt<1>("h1") @[dut.scala 21:12]
      io.dfr <= UInt<1>("h1") @[dut.scala 22:12]
      prevLevel <= UInt<1>("h0") @[dut.scala 23:15]
    else :
      io.fr3 <= UInt<1>("h0") @[dut.scala 26:12]
      io.fr2 <= UInt<1>("h0") @[dut.scala 27:12]
      io.fr1 <= UInt<1>("h0") @[dut.scala 28:12]
      io.dfr <= UInt<1>("h0") @[dut.scala 29:12]
      wire currentLevel : UInt<2> @[dut.scala 32:35]
      currentLevel <= UInt<2>("h0") @[dut.scala 32:35]
      node _T = bits(io.s, 2, 2) @[dut.scala 33:14]
      node _T_1 = bits(io.s, 1, 1) @[dut.scala 33:25]
      node _T_2 = and(_T, _T_1) @[dut.scala 33:18]
      node _T_3 = bits(io.s, 0, 0) @[dut.scala 33:36]
      node _T_4 = and(_T_2, _T_3) @[dut.scala 33:29]
      when _T_4 : @[dut.scala 33:41]
        currentLevel <= UInt<2>("h3") @[dut.scala 34:20]
      else :
        node _T_5 = bits(io.s, 1, 1) @[dut.scala 35:20]
        node _T_6 = bits(io.s, 0, 0) @[dut.scala 35:31]
        node _T_7 = and(_T_5, _T_6) @[dut.scala 35:24]
        when _T_7 : @[dut.scala 35:36]
          currentLevel <= UInt<2>("h2") @[dut.scala 36:20]
        else :
          node _T_8 = bits(io.s, 0, 0) @[dut.scala 37:20]
          when _T_8 : @[dut.scala 37:25]
            currentLevel <= UInt<1>("h1") @[dut.scala 38:20]
          else :
            currentLevel <= UInt<1>("h0") @[dut.scala 40:20]
      node _T_9 = eq(UInt<2>("h3"), currentLevel) @[dut.scala 44:26]
      when _T_9 : @[dut.scala 44:26]
        io.fr3 <= UInt<1>("h0") @[dut.scala 46:16]
        io.fr2 <= UInt<1>("h0") @[dut.scala 47:16]
        io.fr1 <= UInt<1>("h0") @[dut.scala 48:16]
        io.dfr <= UInt<1>("h0") @[dut.scala 49:16]
      else :
        node _T_10 = eq(UInt<2>("h2"), currentLevel) @[dut.scala 44:26]
        when _T_10 : @[dut.scala 44:26]
          io.fr1 <= UInt<1>("h1") @[dut.scala 52:16]
          node _T_11 = lt(prevLevel, currentLevel) @[dut.scala 53:24]
          when _T_11 : @[dut.scala 53:40]
            io.dfr <= UInt<1>("h1") @[dut.scala 54:18]
        else :
          node _T_12 = eq(UInt<1>("h1"), currentLevel) @[dut.scala 44:26]
          when _T_12 : @[dut.scala 44:26]
            io.fr1 <= UInt<1>("h1") @[dut.scala 58:16]
            io.fr2 <= UInt<1>("h1") @[dut.scala 59:16]
            node _T_13 = lt(prevLevel, currentLevel) @[dut.scala 60:24]
            when _T_13 : @[dut.scala 60:40]
              io.dfr <= UInt<1>("h1") @[dut.scala 61:18]
          else :
            node _T_14 = eq(UInt<1>("h0"), currentLevel) @[dut.scala 44:26]
            when _T_14 : @[dut.scala 44:26]
              io.fr1 <= UInt<1>("h1") @[dut.scala 65:16]
              io.fr2 <= UInt<1>("h1") @[dut.scala 66:16]
              io.fr3 <= UInt<1>("h1") @[dut.scala 67:16]
              io.dfr <= UInt<1>("h1") @[dut.scala 68:16]
      prevLevel <= currentLevel @[dut.scala 73:15]


