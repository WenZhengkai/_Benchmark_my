circuit dut :
  module dut :
    input clock : Clock
    input reset : UInt<1>
    output io : { flip r : UInt<3>, g : UInt<3>}

    reg state : UInt<2>, clock with :
      reset => (reset, UInt<1>("h0")) @[dut.scala 18:22]
    io.g <= UInt<1>("h0") @[dut.scala 21:8]
    node _T = asUInt(UInt<1>("h0")) @[dut.scala 24:17]
    node _T_1 = asUInt(state) @[dut.scala 24:17]
    node _T_2 = eq(_T, _T_1) @[dut.scala 24:17]
    when _T_2 : @[dut.scala 24:17]
      node _T_3 = bits(io.r, 0, 0) @[dut.scala 27:16]
      when _T_3 : @[dut.scala 27:21]
        state <= UInt<1>("h1") @[dut.scala 28:15]
      else :
        node _T_4 = bits(io.r, 1, 1) @[dut.scala 29:22]
        when _T_4 : @[dut.scala 29:27]
          state <= UInt<2>("h2") @[dut.scala 30:15]
        else :
          node _T_5 = bits(io.r, 2, 2) @[dut.scala 31:22]
          when _T_5 : @[dut.scala 31:27]
            state <= UInt<2>("h3") @[dut.scala 32:15]
          else :
            state <= UInt<1>("h0") @[dut.scala 34:15]
    else :
      node _T_6 = asUInt(UInt<1>("h1")) @[dut.scala 24:17]
      node _T_7 = asUInt(state) @[dut.scala 24:17]
      node _T_8 = eq(_T_6, _T_7) @[dut.scala 24:17]
      when _T_8 : @[dut.scala 24:17]
        io.g <= UInt<1>("h1") @[dut.scala 40:12]
        node _T_9 = bits(io.r, 0, 0) @[dut.scala 42:16]
        when _T_9 : @[dut.scala 42:21]
          state <= UInt<1>("h1") @[dut.scala 43:15]
        else :
          state <= UInt<1>("h0") @[dut.scala 45:15]
      else :
        node _T_10 = asUInt(UInt<2>("h2")) @[dut.scala 24:17]
        node _T_11 = asUInt(state) @[dut.scala 24:17]
        node _T_12 = eq(_T_10, _T_11) @[dut.scala 24:17]
        when _T_12 : @[dut.scala 24:17]
          io.g <= UInt<2>("h2") @[dut.scala 51:12]
          node _T_13 = bits(io.r, 1, 1) @[dut.scala 53:16]
          when _T_13 : @[dut.scala 53:21]
            state <= UInt<2>("h2") @[dut.scala 54:15]
          else :
            state <= UInt<1>("h0") @[dut.scala 56:15]
        else :
          node _T_14 = asUInt(UInt<2>("h3")) @[dut.scala 24:17]
          node _T_15 = asUInt(state) @[dut.scala 24:17]
          node _T_16 = eq(_T_14, _T_15) @[dut.scala 24:17]
          when _T_16 : @[dut.scala 24:17]
            io.g <= UInt<1>("h1") @[dut.scala 62:12]
            node _T_17 = bits(io.r, 2, 2) @[dut.scala 64:16]
            when _T_17 : @[dut.scala 64:21]
              state <= UInt<2>("h3") @[dut.scala 65:15]
            else :
              state <= UInt<1>("h0") @[dut.scala 67:15]
    node _T_18 = bits(reset, 0, 0) @[dut.scala 73:14]
    when _T_18 : @[dut.scala 73:22]
      state <= UInt<1>("h0") @[dut.scala 74:11]


