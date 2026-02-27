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
      node _T_3 = bits(io.r, 0, 0) @[dut.scala 26:16]
      node _T_4 = eq(_T_3, UInt<1>("h1")) @[dut.scala 26:20]
      when _T_4 : @[dut.scala 26:29]
        state <= UInt<1>("h1") @[dut.scala 27:15]
      else :
        node _T_5 = bits(io.r, 1, 1) @[dut.scala 28:22]
        node _T_6 = eq(_T_5, UInt<1>("h1")) @[dut.scala 28:26]
        when _T_6 : @[dut.scala 28:35]
          state <= UInt<2>("h2") @[dut.scala 29:15]
        else :
          node _T_7 = bits(io.r, 2, 2) @[dut.scala 30:22]
          node _T_8 = eq(_T_7, UInt<1>("h1")) @[dut.scala 30:26]
          when _T_8 : @[dut.scala 30:35]
            state <= UInt<2>("h3") @[dut.scala 31:15]
          else :
            state <= UInt<1>("h0") @[dut.scala 33:15]
    else :
      node _T_9 = asUInt(UInt<1>("h1")) @[dut.scala 24:17]
      node _T_10 = asUInt(state) @[dut.scala 24:17]
      node _T_11 = eq(_T_9, _T_10) @[dut.scala 24:17]
      when _T_11 : @[dut.scala 24:17]
        io.g <= UInt<1>("h1") @[dut.scala 37:12]
        node _T_12 = bits(io.r, 0, 0) @[dut.scala 38:16]
        node _T_13 = eq(_T_12, UInt<1>("h0")) @[dut.scala 38:20]
        when _T_13 : @[dut.scala 38:29]
          state <= UInt<1>("h0") @[dut.scala 39:15]
        else :
          state <= UInt<1>("h1") @[dut.scala 41:15]
      else :
        node _T_14 = asUInt(UInt<2>("h2")) @[dut.scala 24:17]
        node _T_15 = asUInt(state) @[dut.scala 24:17]
        node _T_16 = eq(_T_14, _T_15) @[dut.scala 24:17]
        when _T_16 : @[dut.scala 24:17]
          io.g <= UInt<2>("h2") @[dut.scala 45:12]
          node _T_17 = bits(io.r, 1, 1) @[dut.scala 46:16]
          node _T_18 = eq(_T_17, UInt<1>("h0")) @[dut.scala 46:20]
          when _T_18 : @[dut.scala 46:29]
            state <= UInt<1>("h0") @[dut.scala 47:15]
          else :
            state <= UInt<2>("h2") @[dut.scala 49:15]
        else :
          node _T_19 = asUInt(UInt<2>("h3")) @[dut.scala 24:17]
          node _T_20 = asUInt(state) @[dut.scala 24:17]
          node _T_21 = eq(_T_19, _T_20) @[dut.scala 24:17]
          when _T_21 : @[dut.scala 24:17]
            io.g <= UInt<3>("h4") @[dut.scala 53:12]
            node _T_22 = bits(io.r, 2, 2) @[dut.scala 54:16]
            node _T_23 = eq(_T_22, UInt<1>("h0")) @[dut.scala 54:20]
            when _T_23 : @[dut.scala 54:29]
              state <= UInt<1>("h0") @[dut.scala 55:15]
            else :
              state <= UInt<2>("h3") @[dut.scala 57:15]


